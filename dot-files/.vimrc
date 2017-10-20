" Turn on syntax highlighting, overwrite with default color scheme
syntax on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab Expansion 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on 
set tabstop=4           " Width of a tab is 4 spaces (still interpretted as /t)
set softtabstop=4       " Sets the number of columns for a tab 
set expandtab           " Expands tabs to spaces 
"set smarttab

" Color Line 80 (helps keep consistent lines) 
set cc=80       
" Turn on Numbered Lines
set nu         

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight search results (including incomplete seraches)
set hlsearch  
set incsearch

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Completion 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
imap <S-Tab> <C-X><C-O>
set complete=.,b,u,]
set wildmode=longest,list:longest
set completeopt=menu,preview        " shows a menu and, if available, any 
                                    " additional tips such as the method 
                                    " signature or defining file




