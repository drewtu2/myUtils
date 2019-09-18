" Turn on syntax highlighting, overwrite with default color scheme
syntax on
set nocompatible

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Automatically surround selected text with brackets
Plugin 'tpope/vim-surround'

" Wanna be a bougee staus line btch
Plugin 'vim-airline/vim-airline'

Plugin 'scrooloose/nerdtree'

call vundle#end()            " required
filetype plugin indent on    " required
filetype plugin on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab Expansion 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on 
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Completion 
" Grabbed Configs from:
" [1] http://vim.wikia.com/wiki/VimTip1386
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
imap <S-Tab> <C-X><C-O>
filetype plugin on
set omnifunc=syntaxcomplete#Complete
"""""""""""""""""
"From [1]
"""""""""""""""""
set completeopt=longest,menuone
" If in a completion menu, map enter key to select menu option.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

"""""""""""""""""
" End [1]
"""""""""""""""""
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
