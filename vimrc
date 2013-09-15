" general
set nocompatible " no backwards compatibility for enhanced awesomeness
syntax on        " syntax highlighting
"set spell        " spell checking

" newlines
set cul        " highlight current line
set number     " enable line numbering
set linebreak  " break line between words

" searching
set incsearch  " search while typing
set ignorecase " case-insensitive search
set smartcase  " uppercase-only-sensitive search

" indentation
set smartindent  " auto indentation
set tabstop=2    " length of tabs
set expandtab    " tabs as spaces
set shiftwidth=2 " used by < and >

" wild menu (tab completion)
set wildmenu
set wildmode=list:longest,full

" setup Solarized theme
if &term == "xterm"
	set t_Co=16
  set background=light
	"let g:solarized_contrast="high"
	let g:solarized_termcolors=256
	colo solarized
endif

