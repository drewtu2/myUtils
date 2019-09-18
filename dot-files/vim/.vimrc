"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Configurations
"
" Andrew Tu
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Include Plugins
source $MYUTILS_HOME/dot-files/vim/.plugins.vim

" Turn on syntax highlighting
syntax on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab Expansion 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4           " Width of a tab is 4 spaces (still interpretted as /t)
set shiftwidth=4
set softtabstop=4       " Sets the number of columns for a tab 

" If this is a C(++) file, use c++ indents
set cindent
set cinoptions=g.5s,h.5s "Only indent 2 spaces for the scopes. 

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
"nnoremap <esc> :noh<return><esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map F2 to print the date in insert mode. 
imap <F2> <C-R>=strftime("%A, %h %d, %Y")<CR>


au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main

"""
" Map F3 to toggle paste mode. Paste mode prevents autoindent
"""
set pastetoggle=<F3>

" Set the filetype based on the file's extension, overriding any
" " 'filetype' that has already been set
au BufRead,BufNewFile *.launch,*.test set filetype=xml

" Fuzzy file searching
" use :find <regex> and then tab through options
set path+=**
set wildmenu
