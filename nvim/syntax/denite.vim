syntax region MyDeniteUnimportant matchgroup=MyDeniteConceal excludenl start=/\V{{{/ end=/\V}}}/ concealends
	\ containedin=deniteSource_file_rec,deniteSource_file_mru,deniteSource_project_file_mru
highlight link MyDeniteUnimportant Comment
