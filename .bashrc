# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
        # Shell is non-interactive.  Be done now!
        return
fi

source ~/dotfiles/vendor/git-completion/git-completion.bash
source ~/dotfiles/vendor/git-completion/git-prompt.sh

if [ "Darwin" = "$(uname)" ]; then
	stty dsusp undef

	alias sed=gsed
fi

if [ "$(hostname)" = "t-atom" ]; then
	if [ "${STY}" == "" ]; then
		export PS1_WARNING="${PS1_WARNING}Gentoo"
	fi
fi

# PS1 {{{

# Show errorcode {{{

function __show_error_bar() {
	local err=$?
	if [ $err != 0 ]; then
		echo -e "\033[31m============================== ✗ $err ✗ =============================="
		echo  " "
	fi
	exit $err
}

function __show_errorcode_color() {
	local err=$?
	if [ $err != 0 ]; then
		echo -en "\033[31m\033[05m"
	else
		echo -en "\033[32m"
	fi
	exit $err
}
function __show_errorcode_symbol() {
	local err=$?
	if [ $err != 0 ]; then
		# echo -en "✘ $err"
		echo ''
	else
		echo -en "✓"
	fi
	exit $err
}

# }}}

function __show_jobs() {
	JOBS=$(jobs -s|sed 's/ \+/\t/g'|cut -f1,3|tr \\t :|tr \\n ','|sed 's/,$//'|sed 's/,/, /g')
	if [ "$JOBS" != "" ]; then
		echo " ($JOBS)"
	fi
}

function __show_warning_message() {
	local err=$?
	if [ "$PS1_WARNING" != "" ]; then
		echo -en "[${PS1_WARNING}] "
	fi
	exit $err
}

# ORIGINAL: https://gist.github.com/538522
# Show SVN status {{{
# If you want to see svn modifications:
# export SVN_SHOWDIRTYSTATE=1
#
# Put this in your PS1 like this:
# PS1='\u@\h:\W\[\033[01;33m\]$(__git_svn_ps1)\[\033[00m\]$ '


# Git/Subversion prompt function
__svn_ps1() {
    local s=
    if [[ -d ".svn" ]] ; then
		local svn_info=$(svn info)

        local b=`__svn_branch "$svn_info"`
        local r=`__svn_rev "$svn_info"`
        s=" ($b@$r)"
    fi
    echo -n "$s"
}

# Outputs the current trunk, branch, or tag
__svn_branch() {
	local svn_info=$1
	[ -z "$svn_info" ] && svn_info=$(svn info)
	local url=$(echo "$svn_info" | awk '/^URL:/ {print $2}')
	if [[ $url =~ trunk ]]; then
		echo trunk
	elif [[ $url =~ /branches/ ]]; then
		echo $url | sed -e 's#^.*/\(branches/.*\)\(/.*\)\?$#\1#'
	elif [[ $url =~ /tags/ ]]; then
		echo $url | sed -e 's#^.*/\(tags/.*\)/.*$#\1#'
	fi
}

# Outputs the current revision
__svn_rev() {
	local svn_info=$1
	[ -z "$svn_info" ] && svn_info=$(svn info)
	local r=$(echo "$svn_info" | awk '/Revision:/ {print $2}')
	local svnst flag
	svnst=$(svn status | grep --line-buffered '^\s*[?ACDMR?!]' | head -n 1)
	[ -z "$svnst" ] || flag=*
	r=$r$flag
    echo $r
}
# }}}

export GIT_PS1_SHOWUPSTREAM=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_DESCRIBE_STYLE=branch

function __my_git_ps1() {
	local out=$(__git_ps1)
	if ( echo $out | egrep '\$' > /dev/null ) ; then
		local stashes=$(git stash list | wc -l | ruby -e "puts('\$'*ARGF.read.to_i**2)")
		out=$(echo $out | sed "s/\\$/${stashes}/")
	fi
	if [ -n "$out" ]; then
		local BRANCH=$(git rev-parse --abbrev-ref HEAD)
		local CONFIG="branch.${BRANCH}.message-prefix"
		local PREFIX=$(git config --get "$CONFIG" || echo '')
		if [ -n "$PREFIX" ]; then
			out="${out} - ${PREFIX}"
		fi
	fi
	echo -n $out
}

function __my_vcs_ps1() {
	__my_git_ps1 ; __svn_ps1
}

export PS1='
$(__show_error_bar)\[\033[31m\]\[$(__show_errorcode_color)\]$(__show_errorcode_symbol)\[\033[0m\] \[\033[33m\]\w$(__my_vcs_ps1)\[\033[0m\]$(__show_jobs)
\[\033[31m\]$(__show_warning_message)\[\033[32m\][$(date +"%m-%d %H:%M:%S")]\[\033[0m\] § '

# }}}

export MYSQL_PS1="(\u@\h) [\d] > "

# Alias {{{
alias g=git
complete -o bashdefault -o default -o nospace -F _git g
alias ls='ls -F'
alias la='ls -lag'
alias ll='ls -l'
alias lh='ls -lh'
alias G='egrep --line-buffered'
alias L=less
alias F=find
alias be='bundle exec'
alias r='bundle exec rails'
alias c=cd
alias s='svn'
alias t='screen -X title'
alias re='rbenv'
complete -F _rbenv re
# }}}

complete -d cd

export HISTSIZE=50000
export HISTFILESIZE=50000
export HISTCONTROL=ignoreboth
export HISTIGNORE="rm *:g reset*"

shopt -s histappend
shopt -s checkwinsize
shopt -s no_empty_cmd_completion

if [ -x /usr/local/bin/brew ]; then
	export PATH=/usr/local/sbin:/usr/local/bin:$PATH
fi
export PATH="$HOME/bin:$HOME/local/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.svm/current/rt/bin:$PATH"
export PATH="$HOME/.playenv/bin:$PATH"

export LC_CTYPE="en_US.UTF-8"
export LANG="$LC_CTYPE"

function jvm() {
	local cmd="$1"
	local java_root="/Library/Java/JavaVirtualMachines/"
	case "$cmd" in
		list )
			find "$java_root" -maxdepth 1 | grep 'jdk.*\.jdk' | gsed 's/.*jdk\(.*\)\.jdk$/\1/' ;;
		use )
			local version="$2"
			local home="$java_root/jdk${version}.jdk/Contents/Home/"
			if [ -d "$home" ]; then
				export JAVA_HOME="$home"
				echo "JAVA_HOME=$JAVA_HOME"
			else
				echo "Not found: $home"
				return 1
			fi
			;;
		"" | "help")
			echo "USAGE: $0 list|use <version>" ;;
		* )
			echo "Unknown command: ${cmd}"
	esac
}

export IGNOREEOF=10

export EDITOR=`which vim`

if which rbenv > /dev/null 2>&1; then eval "$(rbenv init -)"; fi

if [ -f "$HOME/.bashrc.local" ]; then source "$HOME/.bashrc.local"; fi
