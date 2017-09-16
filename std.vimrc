execut pathogen#infect()
syntax on
filetype plugin indent on

" 80 characters line
set colorcolumn=81
execute "set colorcolumn=" . join(range(81,335), ',')
highlight ColorColumn ctermbg=Black ctermfg=DarkRed

set nocompatible
syntax on
set hlsearch
set autoindent
set ruler

" Set mouse for all modes
set mouse=a

" Display line numbers
set number

set noexpandtab
set shiftwidth=8
set softtabstop=8
set tabstop=8

" Enable better autocompletion
set wildmenu

" Show matching parens
set showmatch

set nowrap

" NERDTree shortcut
map <C-t> :NERDTreeToggle<CR>

