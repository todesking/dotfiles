#!/bin/sh
set -e

# vendor dir
BASE=$(cd $(dirname $0) && pwd)

mkdir -p $BASE/git-completion
mkdir -p $BASE/git-contrib
wget 'https://github.com/git/git/raw/master/contrib/completion/git-completion.bash' -O $BASE/git-completion/git-completion.bash --no-check-certificate
wget 'https://github.com/git/git/raw/master/contrib/completion/git-prompt.sh' -O $BASE/git-completion/git-prompt.sh --no-check-certificate
wget 'https://raw.github.com/git/git/master/contrib/diff-highlight/diff-highlight' -O $BASE/git-contrib/diff-highlight --no-check-certificate


