set encoding=UTF-8
"---------------------------------------------------------------------------
" 検索の挙動に関する設定:
"
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase
set incsearch

"---------------------------------------------------------------------------
" 編集に関する設定:
"
" タブの画面上での幅
set tabstop=4
" タブをスペースに展開する (noexpandtab:展開しない)
set expandtab
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
" 行番号を表示 (nonumber:非表示)
set number
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を非表示 (list:表示)
set nolist
" どの文字でタブや改行を表示するかを設定
"set listchars=tab:>-,extends:<,trail:-,eol:<
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title
" 画面を黒地に白にする (次行の先頭の " を削除すれば有効になる)
"colorscheme evening " (Windows用gvim使用時はgvimrcを編集すること)

" シフト移動幅
set shiftwidth=4

" 他で書き換えられたら自動で読み直す
set autoread

" カーソル行をハイライト
set cursorline
" カレントウィンドウにのみ罫線を引く
augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorline
    autocmd WinEnter,BufRead * set cursorline
augroup END


"""""""""""""""""""""""""
" ### dein.vim 設定 ### "
"""""""""""""""""""""""""

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

" 見た目変更適用
syntax on

" nerd tree 追加
" autocmd vimenter * NERDTree
map <C-e> :NERDTreeToggle<CR>

" 保存時に行末の余分な余白削除
autocmd BufWritePre * :%s/\s\+$//ge

" 末尾に改行
" autocmd BufWriteCmd * set eol
set fixendofline

" MarkDown の拡張子の追加(何がかわるのかわからん。
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown

" 検索時のハイライト設定
set hlsearch

" 日本語と、カレントカーソルがが見えにくくなったので、行ハイライト非表示
hi clear CursorLine

" 文字コード自動判別らしい
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8

" memolistの設定
" suffix type (default markdown)
let g:memolist_memo_suffix = "md"

" date format (default %Y-%m-%d %H:%M)
let g:memolist_memo_date = "%Y-%m-%d %H:%M"
let g:memolist_memo_date = "epoch"
let g:memolist_memo_date = "%D %T"

" git 差分反映時間設定
set updatetime=100

"======================================
" keymapping
"= =====================================
inoremap <C-c> <ESC>

nnoremap == gg=G    "=を二回連続入力でバッファ全体をインデント整理

" autocmd vimenter * NERDTree
map <C-e> :NERDTreeToggle<CR>

nnoremap <C-f> :MemoNew<CR>
nnoremap <C-l> :MemoList<CR>
nnoremap <C-g> :MemoGrep<CR>

" airlineテーマ
let g:airline_theme = 'wombat'
set laststatus=2
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'y', 'z']]
  let g:airline_section_b =
        \ '%{airline#extensions#branch#get_head()}' .
        \ '%{""!=airline#extensions#branch#get_head()?("  " . g:airline_left_alt_sep . " "):""}' .
        \ '%t%( %M%)'
let g:airline_section_c = '%t'
let g:airline_section_x = '%{&filetype}'
let g:airline#extensions#whitespace#enabled = 1
"左側に使用されるセパレータ
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
"右側に使用されるセパレータ
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'


"  ▼▼htmlタグ補完
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'