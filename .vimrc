"====================================================================
" gvimrc
"====================================================================

"--------------------------------------------------------------------
" 全般的な設定
"--------------------------------------------------------------------

" viとの互換性をとらない（vimの独自機能を使用する）
set nocompatible

" コマンド・検索パターンを履歴に残す
set history=25 "25件まで

" クリップボードの動作設定
set clipboard=unnamed

" カーソルを行頭・行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]

" 画面に収まらずにスクロールしてしまう出力をmoreで表示する
set more

" Vimを終了した後にコンソール画面の内容が復元される
"set restorescreen

" モードラインを有効にする
set modeline

" Thanks for flying Vim
set notitle

"--------------------------------------------------------------------
" 検索の設定
"--------------------------------------------------------------------

" 大文字・小文字の区別をしない
set ignorecase

" 検索文字列に大文字が含まれている場合は大文字・小文字を区別する
set smartcase

" 検索時に最後まで行ったら最初に戻る
set wrapscan

" インクリメンタルサーチを行わない
set noincsearch

"--------------------------------------------------------------------
" 見た目の設定
"--------------------------------------------------------------------

" 行番号を表示する
set number

" 編集している行のハイライト
set cursorline

" タイトルをウィンドウ枠に表示する
set title

" ルーラーを表示しない
set noruler

" 入力中のコマンドをステータスに表示する
set showcmd

" 対応する括弧を表示する
set showmatch

" ステータスラインを常に表示する
set laststatus=2

" ステータスラインに表示する項目の設定
set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}\ %F%=%l,%c%V%8P

" シンタックスハイライトを有効にする
syntax on

" 検索結果文字列のハイライトを有効にする
set hlsearch

" モード表示
set showmode

" 補完候補をコマンドラインのすぐ上の行に表示
set wildmenu

" 補完モードの設定
set wildmode=full

" 長い行を折り返さない
set nowrap

" テキストの表示の方法を変える
set display=lastline

" タブを表示
set lcs=tab:>.,eol:$,trail:_,extends:\

" 全角スペースを表示
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
au BufRead,BufNew * match JpSpace /　/

" 全角記号の幅
set ambiwidth=double

" 折りたたみを行わない
set foldmethod=manual

"--------------------------------------------------------------------
" 編集・整形の設定
"--------------------------------------------------------------------

" Backspaceキーの挙動を定義する
set backspace=indent,eol,start

" オートインデントを有効にする
set autoindent " この設定いらないかも

" スマートインデントを有効にする
set smartindent

" タブ文字の見た目の幅を設定する
set tabstop=4

" タブを空白に置き換える
set expandtab

" タブを置き換えるスペースの数
set shiftwidth=4

" タブの動作設定
set smarttab

" 偏光中のファイルでも保存しないで他のファイルを表示
set hidden

" BOMを付加しない
set nobomb

" スペルチェックを有効にする
" set spell

"--------------------------------------------------------------------
" ファイルの設定
"--------------------------------------------------------------------

" バックアップファイルを作成しない
set nobackup

" ファイル保存ダイアログの初期ディレクトリ
set browsedir=buffer

" 前回終了時のカーソル位置を記憶する
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" 自動補完
autocmd FileTYpe c set omnifunc=ccomplete#Complete
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileTYpe javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags

"--------------------------------------------------------------------
" 日本語の設定
"--------------------------------------------------------------------

" ファイルエンコード
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,utf-16,utf-16le,utf-32,utf31-le,ucs2,ucs2-le,ucs-4,ucs-4le,iso-2022-jp,euc-jp,cp932,latin1

" 改行コード
set fileformat=unix
set fileformats=unix,dos,mac

"--------------------------------------------------------------------
" プラグイン 
"--------------------------------------------------------------------

filetype on
filetype plugin indent on

"--------------------------------------------------------------------
" その他 
"--------------------------------------------------------------------

" スペルチェック
"map ^T :w!<CR>:!aspell check %<CR>:e! %<CR>

" Ctrl+P
set runtimepath^=~/.vim/bundle/ctrlp.vim

"--------------------------------------------------------------------
"プログラミング
"--------------------------------------------------------------------

" PHP の補完
autocmd   FileType php,ctp :set dictionary=~/.vim/dict/php.dict
highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4

" 保存時に php 構文チェック
" autocmd BufWritePost *.php !php -l %

" Javascript　構文チェック
" autocmd FileType javascript noremap <buffer> <up> :<C-u>!/usr/local/bin/gjslint %<cr>

" Javascript
" Simple-Javascript-Indenter
let g:SimpleJsIndenter_BriefMode = 1
let g:SimpleJsIndenter_CaseIndentLevel = -1

" Syntax file for jQuery
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery

" jscomplete-vim
" dom  : Adding DOM keywords completion.
" moz  : Adding Mozilla JavaScript keywords completion.
" xpcom: Adding Mozilla XPCOM component keywords completion.
" es6th: Adding ECMAScript 6th keywords completion.
let g:jscomplete_use = ['dom', 'es6th']


