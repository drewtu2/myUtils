" Turn on syntax highlighting, overwrite with default color scheme
syntax on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab Expansion 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on 
set tabstop=4           " Width of a tab is 4 spaces (still interpretted as /t)
set shiftwidth=4
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
