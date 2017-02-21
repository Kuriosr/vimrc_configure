set nocompatible
filetype off         " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('/home/vasil/.vim/')
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"
" " The following are examples of different formats supported.
" " Keep Plugin commands between vundle#begin/end.
" " plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" " plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" " Git plugin not hosted on GitHub
"
Plugin 'tomasr/molokai'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-scripts/taglist.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'ervandew/supertab'
Plugin 'kien/ctrlp.vim'
Plugin 'Kuriosr/vim-airline'
Plugin 'mileszs/ack.vim'
"
" " All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" " To ignore plugin indent changes, instead use:
"filetype plugin on
" "
" " Brief help
" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line
"
let mapleader = ","

"Configure for YouCompleteMe
nnoremap <leader>g :YcmCompleter GoTo<CR>

"Configure for Ack Plugin
nnoremap <leader>fg :Ack -i --ignore-file=is:tags 
nnoremap <leader>fw :call Search_World()<CR>
function! Search_World()
	let w = expand("<cword>")
	execute "Ack -w --ignore-file=is:tags " . w 
endfunction	

"Configure for airline
"let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

nmap <leader>q <Plug>AirlineDeleteCurTab

nmap <leader>p <Plug>AirlineSelectPrevTab
nmap <leader>n <Plug>AirlineSelectNextTab

let g:airline#extensions#tabline#formatter = 'unique_tail'

"let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_working_path_mode = 2 
let g:ctrlp_cmd = 'CtrlPMRUFiles'

set hlsearch
sy on
set nu
set shiftwidth=4
" set tab witdth
set tabstop=4

" use space insead of tab
set expandtab

set cursorline
set smartindent
set encoding=utf-8
set fileencodings=utf-8,gbk,GB2312
set guifont=Consolas:h12
colorscheme molokai
"if use vim under ssh, Use this two configure
let g:molokai_original = 1
let g:rehash256 = 1
set t_Co=256
set laststatus=2
set showmatch
if has('mouse')
"	set mouse=a
endif
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"括号、引号自动补全
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

"粘贴复制专用寄存器的内容
nnoremap yp "0p
nnoremap yP "0P

" tags 快捷键 
map <C-]> :tselect <C-R>=expand("<cword>")<CR><CR>
map <C-]> g<C-]>

" tab 和换行符显示 
set list
set listchars=tab:▸\ 
",eol:¬

function! ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endf

function! CloseBracket()
	if match(getline(line('.') + 1), '\s*}') < 0
		return "\<CR>}"
	else
		return "\<Esc>j0f}a"
	endif
endf

function! QuoteDelim(char)
	let line = getline('.')
	let col = col('.')
	if line[col - 2] == "\\"
		return a:char
	elseif line[col - 1] == a:char
		return "\<Right>"
	else
		return a:char.a:char."\<Esc>i"
	endif
endf

"NERDTree Open
nnoremap <F2> :NERDTreeToggle<CR>
"Taglist Config
let Tlist_Use_Right_Window = 1
nnoremap <F3> :TlistToggle<CR>

map <F4> ms:call AddTitle()<cr>

function! AddTitle()
    call append(0,"/*******************************************************************************")
    call append(1, "*")
    call append(2,"Copyright (c) XunLong, Inc. All Right Reserved")
    call append(3, "*")
    call append(4,"*******************************************************************************/")
    call append(5, "\/*")
    call append(6," * Author : vasil@xlcwnet.com")
    call append(7," * Last modified : ".strftime("%Y-%m-%d %H:%M"))
    call append(8," * Filename : ".expand("%:t"))
    call append(9," * Description : ")
    call append(10, "*\/")

    echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endf

