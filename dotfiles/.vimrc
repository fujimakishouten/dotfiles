"====================================================================
" .vimrc
"====================================================================

"--------------------------------------------------------------------
" General settings
"--------------------------------------------------------------------

" Increase the undo limit.
set history=2048

" Clipboard settings.
set clipboard^=unnamed,unnamedplus

" Automatically move to previous/next line when press left/rigth key.
set whichwrap=b,s,h,l,<,>,[,]

" Disable automatic visual mode on mouse select.
set mouse-=a

" No pauses in listings.
set more

" Enable modeline.
set modeline

" Thanks for flying Vim.
set notitle

"--------------------------------------------------------------------
" Search settings
"--------------------------------------------------------------------

" Ignore case when searching.
set ignorecase

" Automatically switch search to case-sensitive when search query contains an uppercase letter.
set smartcase

" Search wraps around to the beginning when reaches end of file
set wrapscan

" Disable incremental search
set noincsearch

"--------------------------------------------------------------------
" Appearance settings
"--------------------------------------------------------------------

" Show line numbers on the sidebar.
set number

" Highlight the line currently under cursor.
set cursorline

" Set the window’s title, reflecting the file currently being edited.
set title

" Hide ruler.
set noruler

" Show command.
set showcmd

" Highlight matching braces.
set showmatch

" Always display the status bar.
set laststatus=2

" Status line format.
set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}\ %F%=%l,%c%V%8P

" Enable syntax highlighting.
syntax on

" Enable true color.
"set termguicolors

" Set background color.
set background=light

" Change color scheme.
colorscheme hemisu

" Enable search highlighting.
set hlsearch

" Show mode.
set showmode

" Display command line’s tab complete options as a menu.
set wildmenu

" Wildmenu settings.
set wildmode=full

" Disable word wrap.
set nowrap

" Always try to show a paragraph’s last line.
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

" Allow backspacing over indention, line breaks and insertion start.
set backspace=indent,eol,start

" New lines inherit the indentation of previous lines.
set autoindent

" Enable smart indent.
set smartindent

" Indent using N spaces.
set tabstop=4

" Convert tab to spaces.
set expandtab

" When shifting, indent using N spaces.
set shiftwidth=4

" Insert "tabstop" number of spaces when the "tab" key is pressed.
set smarttab

" Hide files in the background instead of closing them.
set hidden

" Disable prepend BOM to the file.
set nobomb

" Enable spell check.
" set spell

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

" Remove trailing spaces on save.
autocmd BufWritePre * :%s/\s\+$//e

