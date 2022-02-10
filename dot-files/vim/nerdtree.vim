""""""""""""""""""""""""""""""""""
" Settings for NerdTree
""""""""""""""""""""""""""""""""""

" CTR-L n toggles nerdtree browser
map <C-n> :NERDTreeToggle<CR>

" Autostart NerdTree
autocmd vimenter * NERDTree | wincmd p

" Autostart Nerd tree if no files were selected
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif


" Close Nerd tree if its the only window open in vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Show hidden files by default
let NERDTreeShowHidden=1


" Nerdtree Syntax Highlight
let g:NERDTreeFileExtensionHighlightFullName = 0
let g:NERDTreeExactMatchHighlightFullName = 0
let g:NERDTreePatternMatchHighlightFullName = 0

