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

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Show matching parens
set showmatch

set nowrap

" Highlight trailing spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Enable better autocompletion
set wildmenu

" NERDTree shortcut
map <C-t> :NERDTreeToggle<CR>

" Tabbar shortcut
nmap <F12> :TagbarToggle<CR>

" autopep8 shortcut
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>

" Python Complete plugin
set omnifunc=syntaxcomplete#Complete

" Python skeleton file
if has("autocmd")
    augroup templates
        autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh
        autocmd BufNewFile *.py 0r ~/.vim/templates/skeleton.py
    augroup END
endif

