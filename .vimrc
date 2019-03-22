".vimディレクトリが無ければ作る
let s:vimdir = $HOME . '/.vim'
if has('vim_starting') && ! isdirectory(s:vimdir)
    call mkdir(s:vimdir)
endif
"全角スペースを血祭りに上げる,これより後にカラースキーマ
scriptencoding utf-8
augroup highlightIdegraphicSpace
  autocmd!
  autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkRed guibg=DarkRed
  autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END
"カラースキーマ molokaiがなければ持ってくる
if ! filereadable(s:vimdir . '/colors/molokai.vim')
    if executable('git') && confirm("Prepare molokai form github?", "Yes\nNo", 2) == 1
        echo 'Ok, now installing molokai'
        call system('git clone https://github.com/tomasr/molokai ' . s:vimdir)
        call system('rm ' . s:vimdir . '/LICENSE.md  ' .s:vimdir . '/README.md')
        colorscheme molokai
    else
        echo 'molokai is not installed'
    endif
else
    colorscheme molokai
endif
set t_Co=256
"折り返さない
set nowrap
" インクリメンタルサーチ. １文字入力毎に検索を行う
set incsearch
" ハイライトサーチを有効にする。
set hlsearch
" 大文字小文字を区別しない(検索時)
set ignorecase
" ただし大文字を含んでいた場合は大文字小文字を区別する(検索時)
set smartcase
" カーソル位置が右下に表示される
set ruler
" 行番号を付ける
set number
" タブ文字の表示 ^I で表示されるよ
set list
" コマンドライン補完が強力になる
set wildmenu
" コマンドを画面の最下部に表示する
set showcmd
" クリップボードを共有する
set clipboard=unnamed
" 改行時にインデントを引き継いで改行する
set autoindent
"自動インデント増減
set smartindent
" インデントにつかわれる空白の数
set shiftwidth=4
" <Tab>押下時の空白数
set softtabstop=4
" <Tab>押下時に<Tab>ではなく、ホワイトスペースを挿入する
set expandtab
" <Tab>が対応する空白の数
set tabstop=4
" インクリメント、デクリメントを16進数にする(0x0とかにしなければ10進数です。007をインクリメントすると010になるのはデフォルト設定が8進数のため)
set nf=hex
"改行時にインデント継続
set autoindent
" マウス使えます
set mouse=a
"バックスペースでの行移動を可能にする
set backspace=indent,eol,start
"その場にswpを作らない
set directory-=.
"undoを永続化
set undofile
set undodir=~/tmp
"ステータスラインを常に表示
set laststatus=2
" カーソル行を強調表示
set cursorline
"lightlineがあるから、挿入モードとか表示しない
set noshowmode
augroup MyAutoCmd
    autocmd!
    "保存時に行末スペースを取り除く
    autocmd BufWritePre * %s/\s\+$//e
    "テンプレートファイル
    autocmd BufNewFile *.c 0r $HOME/.vim/template/main.c
augroup END
if has("autocmd")
  " 編集箇所のカーソルを記憶
  augroup redhat
    " In text files, always limit the width of text to 78 characters
    autocmd BufRead *.txt set tw=78
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END
endif
""""""""""""""""""""""""
"オリジナルキーバインド"
""""""""""""""""""""""""
let mapleader = "\<Space>"
" インサートモードの時に C-j でノーマルモードに戻る
inoremap <C-j> <esc>
vnoremap <C-j> <esc>
"C-dでその場の文字を消す
noremap <C-d> <Del>
"C-hで前の文字を消す
noremap <C-h> <LEFT><Del>
"表示上のj, k移動を取り替え
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
"NERDTreeのショートカット
nnoremap <Leader>n  :NERDTree<CR>
"押しにくい移動を便利に
noremap <Leader>h ^
noremap <Leader>l $
"コメントの色を変える
noremap <Leader>c :call CommentHl()<CR>
let s:commentHlNumber = 0
function! CommentHl()
    if s:commentHlNumber == 0
        :hi Comment ctermfg=white
        let s:commentHlNumber = 1
    elseif s:commentHlNumber == 1
        :hi Comment ctermfg=green
        let s:commentHlNumber = 2
    else
        :hi Comment ctermfg=grey
        let s:commentHlNumber = 0
    endif
endfunction
"twitvim
noremap <Leader>tp :PosttoTwitter<CR>
" ２回esc を押したら検索のハイライトをヤメる
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>

"""""""""""""""""""""""""
"Emacsライクな挿入モード"
"""""""""""""""""""""""""
inoremap <C-f> <Right>
inoremap <C-b> <Left>
"undo
inoremap <silent> <C-u> <C-g>u<C-r>=MyExecExCommand('undo', 'onemore')<CR>
"行頭へ
inoremap <silent> <C-a> <C-r>=MyJumptoBol('　。、．，／！？「」')<CR>
"行末へ
inoremap <silent> <C-e> <C-r>=MyJumptoEol('　。、．，／！？「」')<CR>
"カーソル以降の単語削除
inoremap <silent> <C-k> <C-g>u<C-r>=MyExecExCommand('normal! D', 'onemore')<CR>
"非補完時は行移動をj,kと同じ動作にして補完中は候補選択
inoremap <silent> <expr> <C-p>  pumvisible() ? "\<C-p>" : "<C-r>=MyExecExCommand('normal k')<CR>"
inoremap <silent> <expr> <C-n>  pumvisible() ? "\<C-n>" : "<C-r>=MyExecExCommand('normal j')<CR>"
inoremap <silent> <expr> <Up>   pumvisible() ? "\<C-p>" : "<C-r>=MyExecExCommand('normal k')<CR>"
inoremap <silent> <expr> <Down> pumvisible() ? "\<C-n>" : "<C-r>=MyExecExCommand('normal j')<CR>"
"sepが空でなければ、sepをセパレータとしてジャンプ。
"見つからなければ行末へ。除
function! MyJumptoEol(sep)
  if col('.') == col('$')

    silent exec 'normal! w'
    return ''
  endif
  if a:sep != ''
    let prevcol = col('.')
    call search('['.a:sep.']\+[^'.a:sep.']', 'eW', line("."))
    if col('.') != prevcol
      return ''
    endif
  endif
  call cursor(line('.'), col('$'))
  return ''
endfunction
"sepが空でなければ、sepをセパレータとしてジャンプ。
"見つからなければ見かけの行頭へ。
"カーソル位置が見かけの行頭の場合は真の行頭へ。
function! MyJumptoBol(sep)
  if col('.') == 1
    call cursor(line('.')-1, col('$'))
    call cursor(line('.'), col('$'))
    return ''
  endif
  if matchend(strpart(getline('.'), 0, col('.')), '[[:blank:]]\+') >= col('.')-1
    silent exec 'normal! 0'
    return ''
  endif
  if a:sep != ''
    call search('[^'.a:sep.']\+', 'bW', line("."))
    if col('.') == 1
      silent exec 'normal! ^'
    endif
    return ''
  endif
  exec 'normal! ^'
  return ''
endfunction
"IMEの状態とカーソル位置保存のため<C-r>を使用してコマンドを実行。
function! MyExecExCommand(cmd, ...)
  let saved_ve = &virtualedit
  let index = 1
  while index <= a:0
    if a:{index} == 'onemore'
      silent setlocal virtualedit+=onemore
    endif
    let index = index + 1
  endwhile
  silent exec a:cmd
  if a:0 > 0
    silent exec 'setlocal virtualedit='.saved_ve
  endif
  return ''
endfunction
"Emcasライクな挿入モード終了:

""""""""""""""
"dein Scripts"
""""""""""""""
if &compatible
  set nocompatible               " Be iMproved
endif
" Flags
let s:use_dein = 1
" Prepare .vim dir
let s:vimdir = $HOME . '/.vim'
" dein
let s:dein_enabled  = 0
if v:version >= 704 && s:use_dein && !filereadable(expand("~/.vim/no_dein"))
  if executable('git')
    " Set dein paths
    let s:dein_dir = s:vimdir . '/bundles'
    let s:dein_github = s:dein_dir . '/repos/github.com'
    let s:dein_repo_name = 'Shougo/dein.vim'
    let s:dein_repo_dir = s:dein_github . '/' . s:dein_repo_name
    " Check dein has been installed or not.
    if !isdirectory(s:dein_repo_dir)
      if confirm("Prepare dein?", "Yes\nNo", 2)  == 1
        let s:dein_enabled = 1
        echo 'dein is not installed, install now '
        let s:dein_repo = 'https://github.com/' . s:dein_repo_name
        echo 'git clone ' . s:dein_repo . ' ' . s:dein_repo_dir
        call system('git clone ' . s:dein_repo . ' ' . s:dein_repo_dir)
      elseif confirm("Show install dein message again?", "Don't show\nShow again", 2) == 1
        echo 'ok, if you want me show actually, remove ' . s:vimdir . '/no_dein')
        execute 'redir > ' , s.vimdir . '/no_dein'
        redir END
      endif
    else
      let s:dein_enabled = 1
    endif
  endif
endif
if s:dein_enabled == 1
  " Required:
  set runtimepath+=$HOME/.vim/bundles//repos/github.com/Shougo/dein.vim
  " Required:
  if dein#load_state($HOME .  '/.vim/bundles/')
    call dein#begin($HOME . '/.vim/bundles/')
    " Let dein manage dein
    " Required:
    call dein#add($HOME . '/.vim/bundles//repos/github.com/Shougo/dein.vim')
    " Add or remove your plugins here like this:
    "call dein#add('Shougo/neosnippet.vim')
    "call dein#add('Shougo/neosnippet-snippets')
    ":NERDTreeでフォルダ構造を出す
    call dein#add('scrooloose/nerdtree')
    "上下に出てくるカラフルなライン
    call dein#add('itchyny/lightline.vim')
    "tomlファイルをきらびやかに
    call dein#add('cespare/vim-toml')
    "indentの深さを表すガイド
    call dein#add('nathanaelkane/vim-indent-guides')
    "gcc, gcでコメントアウト、コメントイン
    call dein#add('tomtom/tcomment_vim')
    "間違いみたいだったら即座に教える
    call dein#add('w0rp/ale')
    "括弧を自動で閉じる
    call dein#add('cohama/lexima.vim')
    "ログに色付け
    call dein#add('vim-scripts/AnsiEsc.vim')
    "Twitterをする
    call dein#add('twitvim/twitvim')
    "チートシート
    call dein#add('reireias/vim-cheatsheet')
    " Required:
    call dein#end()
    call dein#save_state()
  endif
  " Required:
  filetype plugin indent on
  syntax enable
  " If you want to install not installed plugins on startup.
  if dein#check_install()
    call dein#install()
  endif
endif
"End dein Scripts------------------------- "
"
""""""""""""""""""""
"Set plugin configs"
""""""""""""""""""""
"lightline
set hidden  " allow buffer switching without saving
set showtabline=2  " always show tabline
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'LightlineModified',
        \   'readonly': 'LightlineReadonly',
        \   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename',
        \   'fileformat': 'LightlineFileformat',
        \   'filetype': 'LightlineFiletype',
        \   'fileencoding': 'LightlineFileencoding',
        \   'mode': 'LightlineMode'
        \ }
        \ }

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
    return fugitive#head()
  else
    return ''
  endif
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
"indent_guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_auto_colors=0
augroup indent_guides_autocmd
    autocmd!
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=8
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=238
augroup END
"ale
let g:ale_lint_on_text_changed = 0
"TwiitVim
let twitvim_browser_cmd = 'open' " for Mac
let twitvim_force_ssl = 1
let twitvim_count = 40
"cheetsheet
let g:cheatsheet#cheat_file = s:vimdir . '/cheatsheet'
"End plugin configs
