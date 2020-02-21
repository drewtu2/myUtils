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

" Wanna be a bougee status line btch
" Make sure the powerline fonts are installed using the script in
" $MYUTILS_HOME/scripts
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

source $MYUTILS_HOME/dot-files/vim/airline.vim

" Get that bougee branch symbol. And also interact with git. 
Plugin 'tpope/vim-fugitive'

" File Browser thing
Plugin 'scrooloose/nerdtree'
Plugin 'guns/xterm-color-table.vim'
" More bougee symbols to use with nerdtree
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'ryanoasis/vim-devicons'
source $MYUTILS_HOME/dot-files/vim/nerdtree.vim

" Auto Complete
 Plugin 'valloric/youcompleteme'

" Fuzzy file finding

call vundle#end()            " required
filetype plugin indent on    " required

