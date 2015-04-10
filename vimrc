" syntax highlighting
syntax on           " syntax highlighting
color desert        " color scheme
set cul             " highlight current line
hi CursorLine cterm=NONE ctermbg=darkgrey ctermfg=NONE

" newlines
set number          " enable line numbering
set linebreak       " break line between words

" searching
set incsearch       " search while typing
set ignorecase      " case-insensitive search
set smartcase       " uppercase-only-sensitive search

" indentation
set smartindent     " auto indentation
set tabstop=4       " length of tabs
set expandtab       " tabs as spaces
set shiftwidth=4    " used by < and >

" tab completion
set wildmenu        " activate menus
set wildmode=list:longest,full

