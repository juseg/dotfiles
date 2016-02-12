" syntax highlighting
syntax on           " syntax highlighting
color desert        " color scheme
set background=dark " better contrast on black
set cul             " highlight current line
set colorcolumn=80  " highlight column 80
hi CursorLine cterm=NONE ctermfg=NONE ctermbg=darkgrey
hi LineNr cterm=bold ctermfg=grey ctermbg=darkgrey
hi ColorColumn ctermbg=darkgrey

" newlines
set number          " enable line numbering
set linebreak       " break line between words

" searching
set incsearch       " search while typing
set ignorecase      " case-insensitive search
set smartcase       " uppercase-only-sensitive search

" indentation
set smartindent     " auto indentation
set tabstop=8       " length of tabs in display
set expandtab       " tabs as spaces
set shiftwidth=4    " used by < and >
set softtabstop=4   " length of tabs in insert mode

" tab completion
set wildmenu        " activate menus
set wildmode=list:longest,full

