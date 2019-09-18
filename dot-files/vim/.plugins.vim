"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Plugin Configurations
"
" Andrew Tu
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible "required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Automatically surround selected text with brackets
Plugin 'tpope/vim-surround'

" Wanna be a bougee staus line btch
Plugin 'vim-airline/vim-airline'

" File Browser thing
Plugin 'scrooloose/nerdtree'

" Auto Complete
Plugin 'valloric/youcompleteme'

call vundle#end()            " required
filetype plugin indent on    " required
