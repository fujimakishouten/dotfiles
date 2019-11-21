"====================================================================
" .vimrc
"====================================================================

"--------------------------------------------------------------------
" General settings
"--------------------------------------------------------------------

" Save command and search history.
set history=256

" Clipboard settings.
set clipboard^=unnamed,unnamedplus

" Automatically move to previous/next line when press left/rigth key.
set whichwrap=b,s,h,l,<,>,[,]

" Disable automatic visual mode on mouse select.
set mouse-=a

" 画面に収まらずにスクロールしてしまう出力をmoreで表示する
set more

" Enable modeline.
set modeline

" Thanks for flying Vim.
set notitle

"--------------------------------------------------------------------
" Search settings
"--------------------------------------------------------------------

" Search ignore case.
set ignorecase

" Case sensitive search when pattern contains an upper and lower case.
set smartcase

" Search wraps around to the beginning when reaches end of file
set wrapscan

" Disable incremental search
set noincsearch

"--------------------------------------------------------------------
" Appearance settings
"--------------------------------------------------------------------

" Show line number.
set number

" Highlight current line.
set cursorline

" Show file name on window title bar.
set title

" Hide ruler.
set noruler

" Show command.
set showcmd

" Highlight matching braces.
set showmatch

" Always show status line.
set laststatus=2

" Status line format.
set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}\ %F%=%l,%c%V%8P

" Enable syntax highlight.
syntax on

" Enable true color.
"set termguicolors

" Set color scheme.
colorscheme desert

" Enable Highlight search pattern matches.
set hlsearch

" Show mode.
set showmode

" 補完候補をコマンドラインのすぐ上の行に表示
set wildmenu

" 補完モードの設定
set wildmode=full

" Disable word wrap.
set nowrap

" テキストの表示の方法を変える
set display=lastline

" Display tab character.
set lcs=tab:>.,eol:$,trail:_,extends:\

" Display ideographic space character.
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
au BufRead,BufNew * match JpSpace /　/

" 全角記号の幅
set ambiwidth=double

" Disable automatically folding.
set foldmethod=manual

"--------------------------------------------------------------------
" Edit and shaping settings.
"--------------------------------------------------------------------

" Set backspace key
set backspace=indent,eol,start

" Enable auto indent.
set autoindent

" Enable smart indent.
set smartindent

" Set width of tab character.
set tabstop=4

" Expand tab to spaces.
set expandtab

" タブを置き換えるスペースの数
set shiftwidth=4

" Enable smart tab.
set smarttab

" 変更中のファイルでも保存しないで他のファイルを表示
set hidden

" BOMを付加しない
set nobomb

" Enable spell check
" set spell

" Remove trailing spaces on save.
autocmd BufWritePre * :%s/\s\+$//e

"--------------------------------------------------------------------
" File settings.
"--------------------------------------------------------------------

" Disable create backup.
set nobackup

" Initial directory of save file dialog.
set browsedir=buffer

" Remind cursor position on exit.
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" Enable auto complete.
autocmd FileTYpe c set omnifunc=ccomplete#Complete
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileTYpe javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags

"--------------------------------------------------------------------
" Encoding settings.
"--------------------------------------------------------------------

" File encode.
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,utf-16,utf-16le,utf-32,utf31-le,ucs2,ucs2-le,ucs-4,ucs-4le,iso-2022-jp,euc-jp,cp932,latin1

" Newline.
set fileformat=unix
set fileformats=unix,dos,mac

"--------------------------------------------------------------------
" Plugin settings
"--------------------------------------------------------------------

filetype on
filetype plugin indent on

"--------------------------------------------------------------------
" Other settings
"--------------------------------------------------------------------

