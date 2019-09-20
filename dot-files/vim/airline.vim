"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline Configurations
" https://github.com/vim-airline/vim-airline
"
" Andrew Tu
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Something to do with how symbols are showing. 
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" Get that sweet looking theme
let g:airline_powerline_fonts = 1
let g:airline_theme='deus'

" Exit insert move faster (issue with airline or smth)
set ttimeoutlen=10
