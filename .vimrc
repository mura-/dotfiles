syntax enable

"---------------------------------------------------------------------------
" vi互換モードをOFF
set nocompatible

"---------------------------------------------------------------------------
" 検索に関する設定:
"
" 検索時に大文字小文字を無視 (ignorecase:無視する noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別 (smartcase:有効 nosmartcase:無効)
set smartcase
" 検索をインクリメンタルに行う
set incsearch
" 検索パターンのマッチ箇所の強調表示
set hlsearch

"---------------------------------------------------------------------------
" 編集に関する設定:
"
" タブの画面上での幅
set tabstop=4
" <Tab>の挿入や<BS>の使用等の編集操作をする時に、<Tab>が対応する空白の数。
set softtabstop=0
" インデントの各段階に使われる空白の数。
set shiftwidth=4
" タブをスペースに展開しない (expandtab:有効 noexpandtab:無効)
set expandtab
"set noexpandtab
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
"新しい行を作ったときに高度な自動インデントを行う
set smartindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=2
" 検索時にファイルの最後まで行ったら最初に戻る (wrapscan:有効 nowrapscan:無効)
set wrapscan
" VIMでPHP構文チェック
set makeprg=php\ -l\ %
set errorformat=%m\ in\ %f\ on\ line\ %l

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
" 行番号を表示 (number:有効 nonumber:無効)
set number
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (list:表示)
" set list
" どの文字でタブや改行を表示するかを設定
"set listchars=tab:>-,extends:<,trail:-,eol:<
" 長い行を折り返して表示 (wrap:有効 nowrap:無効)
set nowrap
" 勝手に改行しない
set tw=0
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
"set notitle
set title
" 現在のモードの表示
set showmode

set hidden
"---------------------------------------------------------------------------
" ファイル操作に関する設定:

" バックアップファイルを作成しない
set nobackup
set noswapfile

" undoファイルは一箇所に纏める
set undodir=$HOME/.vim/undo
set undofile

"---------------------------------------------------------------------------
"文字コードの設定
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932,iso-2022-jp,euc-jp
set fileformats=unix,dos,mac

"文字コード変換関数
function! ToUtf8()
    set fileencoding=utf-8
    set fileformat=unix
endfunction

function! ToShiftJis()
    set fileencoding=cp932
    set fileformat=dos
endfunction

function! ToEucJp()
    set fileencoding=euc-jp
    set fileformat=unix
endfunction

"---------------------------------------------------------------------------
au QuickfixCmdPost make,grep,grepadd,vimgrep copen
au QuickfixCmdPost l* lopen

"---------------------------------------------------------------------------
" Source Explorer(srcexpl.vim)
let g:SrcExpl_RefreshTime = 0
let g:SrcExpl_WinHeight = 9
let g:SrcExpl_RefreshMapKey = "<Space>"
let g:SrcExpl_GoBackMapKey = "<C-b>"
let g:SrcExpl_UpdateTags = 1
nmap <F8> :SrcExplToggle<CR>

"---------------------------------------------------------------------------
" {{{ Automatic close char mapping
"inoremap  { {<CR>}<C-O>O
"inoremap [ []<LEFT>
"inoremap ( ()<LEFT>
"inoremap \" \""<LEFT>
"inoremap ' ''<LEFT>

"---------------------------------------------------------------------------
" tags
set tags=tags

"---------------------------------------------------------------------------
" QFixHowm

"QFixHowmキーマップ
let QFixHowm_Key = 'g'

"howm_dirはファイルを保存したいディレクトリを設定。
let howm_dir             = '~/Dropbox/memo'
let howm_filename        = '%Y/%m/%Y-%m-%d-%H%M%S.md'
let howm_fileencoding    = 'utf-8'
let howm_fileformat      = 'unix'

let QFixHowm_DiaryFile = 'diary/%Y/%m/%Y-%m-%d-000000.md'

" ファイルタイプをmarkdownにする
let QFixHowm_FileType = 'markdown'
" タイトル記号
let QFixHowm_Title = '#'
" タイトル行検索正規表現の辞書を初期化
let QFixMRU_Title = {}
" MRUでタイトル行とみなす正規表現(Vimの正規表現で指定)
let QFixMRU_Title['mkd'] = '^###[^#]'
" grepでタイトル行とみなす正規表現(使用するgrepによっては変更する必要があります)
let QFixMRU_Title['mkd_regxp'] = '^###[^#]'
" }}}
"---------------------------------------------------------------------------
" 日付挿入
inoremap <Leader>date <C-R>=strftime('%Y/%m/%d (%a)')<CR>
inoremap <Leader>time <C-R>=strftime('%H:%M')<CR>
inoremap <Leader>w3cd <C-R>=strftime('%Y-%m-%dT%H:%M:%S+09:00')<CR>
"---------------------------------------------------------------------------
" プログラムの実行
"
" ShebangExecut
"
" @see http://subtech.g.hatena.ne.jp/secondlife/20060727/1153990447
"
nmap ,e :call ShebangExecute()<CR>

function! ShebangExecute()
  let m = matchlist(getline(1), '#!\(.*\)')
  if(len(m) > 2)
    execute '!'. m[1] . ' %'
  else
    execute '!' &ft ' %'
  endif
endfunction

"---------------------------------------------------------------------------
" GetStatusEx
"
" ステータス表示用function
"
function! GetStatusEx()
  let str = ''
  let str = str . '[' . &fileformat . ']'
  if has('multi_byte') && &fileencoding != ''
    let str = '[' . &fenc . ']' . str
  endif
  return str
endfunction
set statusline=%y%{GetStatusEx()}%F%m%r%=<%c:%l>

"---------------------------------------------------------------------------
" AutoComplPop
"
autocmd FileType php let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/php.dict'

" @see http://subtech.g.hatena.ne.jp/secondlife/20080104/1199418587
autocmd CmdwinEnter * AutoComplPopDisable
autocmd CmdwinLeave * AutoComplPopEnable

" ---------------------------------------------------------------------------
"挿入モード終了時にIME状態を保存しない
inoremap <silent> <ESC> <ESC>
inoremap <silent> <C-[> <ESC>

"IMEモード固定
inoremap <silent> <C-j> <C-^>

" Alt+o 現在位置を保持して下に行追加
noremap <A-o> m`o<ESC>``

" ---------------------------------------------------------------------------
"  test
set whichwrap=b,s,h,l,<,>,[,],~
set ambiwidth=double
nnoremap n nzz
nnoremap N Nzz
" ---------------------------------------------------------------------------

nnoremap <C-Tab> gt
nnoremap <C-S-Tab> gT

nmap <Space>sj <SID>(split-to-j)
nmap <Space>sk <SID>(split-to-k)
nmap <Space>sh <SID>(split-to-h)
nmap <Space>sl <SID>(split-to-l)

nnoremap <SID>(split-to-j) :<C-u>execute 'belowright' (v:count == 0 ? '' : v:count) 'split'<CR>
nnoremap <SID>(split-to-k) :<C-u>execute 'aboveleft'  (v:count == 0 ? '' : v:count) 'split'<CR>
nnoremap <SID>(split-to-h) :<C-u>execute 'topleft'    (v:count == 0 ? '' : v:count) 'vsplit'<CR>
nnoremap <SID>(split-to-l) :<C-u>execute 'botright'   (v:count == 0 ? '' : v:count) 'vsplit'<CR>

" unindent
imap <S-Tab> <C-o><<

" Yで最後の文字までYank
nnoremap Y y$

"---------------------------------------------------------------------------
" ビジュアルモードで選択したテキストが、クリップボードに入るようにする
set guioptions+=a
"windowsのクリップボードと同期
set clipboard=unnamed

"---------------------------------------------------------------------------

" カラー設定:
"
colorscheme hybrid
syntax on


"---------------------------------------------------------------------------
" ウインドウに関する設定:

" ウインドウの幅
"set columns=120
" ウインドウの高さ
"set lines=80
" コマンドラインの高さ(GUI使用時)
set cmdheight=1

"---------------------------------------------------------------------------
" ウインドウに関する設定:
"function! ExecuteWindowResize()
"    if !exists('g:windowstatus')
"        execute 'simalt ~x'
"        let g:windowstatus = 1
"    elseif g:windowstatus == 1
"        execute 'simalt ~r'
"        let g:windowstatus = 2
"    elseif g:windowstatus == 2
"        execute 'simalt ~x'
"        let g:windowstatus = 1
"
"    endif
"endfunction
"noremap <C-X> :call ExecuteWindowResize()<CR>

" ウィンドウ移動に関する設定
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l
nnoremap <C-K> <C-W>k
nnoremap <C-J> <C-W>j

" ミニバッファに関連する設定
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

"
:set tags=tags
"let g:Tlist_Auto_Open = 1
let g:Tlist_Use_Right_Window = 1


"--------------------------------------------------------------------------
" neobundle

filetype off
filetype plugin indent off
" if has('vim_starting')
"   set runtimepath+=~/.vim/bundle/neobundle.vim/
" endif
" 
" call neobundle#rc(expand('~/.vim/bundle/'))
" 
" filetype plugin indent on     " Required!
" 
" 
" NeoBundle 'git://github.com/Shougo/neocomplcache.git'
" NeoBundle 'git://github.com/Shougo/unite.vim.git'
" NeoBundle 'git://github.com/Shougo/vimfiler.git'
" NeoBundle 'git://github.com/Shougo/vimshell.git'
" NeoBundle 'git://github.com/Shougo/vimproc.git', {
"   \ 'build' : {
"     \ 'windows' : 'make -f make_mingw32.mak',
"     \ 'cygwin' : 'make -f make_cygwin.mak',
"     \ 'mac' : 'make -f make_mac.mak',
"     \ 'unix' : 'make -f make_unix.mak',
"   \ },
" \ }
" NeoBundle 'git://github.com/vim-scripts/taglist.vim.git'
" NeoBundle 'git://github.com/vim-scripts/TwitVim.git'
" NeoBundle 'git://github.com/fholgado/minibufexpl.vim.git'
" NeoBundle 'git://github.com/fuenor/qfixhowm.git'
" NeoBundle 'git://github.com/thinca/vim-qfreplace'
" NeoBundle 'git://github.com/vim-scripts/zoom.vim'
" NeoBundle 'git://github.com/thinca/vim-quickrun.git'
" NeoBundle 'troydm/easybuffer.vim'
" NeoBundle 'mbbill/undotree'
" NeoBundle 'itchyny/lightline.vim'
" NeoBundle 'airblade/vim-gitgutter'
" NeoBundle 'http://github.com/mattn/emmet-vim.git'
" NeoBundle 'git://github.com/tpope/vim-fugitive.git'
" NeoBundle 'git://github.com/rbtnn/rabbit-ui.vim'
" NeoBundle 'git://github.com/kannokanno/previm.git'
" NeoBundle 'Markdown'
" NeoBundle 'suan/vim-instant-markdown'
if !1 | finish | endif

 if has('vim_starting')
   if &compatible
     set nocompatible               " Be iMproved
   endif

   " Required:
   set runtimepath+=~/.vim/bundle/neobundle.vim/
 endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neocomplcache.git'
NeoBundleFetch 'Shougo/unite.vim.git'
NeoBundleFetch 'Shougo/vimfiler.git'
NeoBundleFetch 'Shougo/vimshell.git'
NeoBundleFetch 'Shougo/vimproc.git', {
  \ 'build' : {
    \ 'windows' : 'make -f make_mingw32.mak',
    \ 'cygwin' : 'make -f make_cygwin.mak',
    \ 'mac' : 'make -f make_mac.mak',
    \ 'unix' : 'make -f make_unix.mak',
  \ },
\ }
NeoBundleFetch 'vim-scripts/taglist.vim.git'
NeoBundleFetch 'vim-scripts/TwitVim.git'
NeoBundleFetch 'fholgado/minibufexpl.vim.git'
NeoBundleFetch 'fuenor/qfixhowm.git'
NeoBundleFetch 'thinca/vim-qfreplace'
NeoBundleFetch 'vim-scripts/zoom.vim'
NeoBundleFetch 'thinca/vim-quickrun.git'
NeoBundleFetch 'troydm/easybuffer.vim'
NeoBundleFetch 'mbbill/undotree'
NeoBundleFetch 'itchyny/lightline.vim'
NeoBundleFetch 'airblade/vim-gitgutter'
NeoBundleFetch 'mattn/emmet-vim.git'
NeoBundleFetch 'tpope/vim-fugitive.git'
NeoBundleFetch 'rbtnn/rabbit-ui.vim'
NeoBundleFetch 'kannokanno/previm.git'
NeoBundleFetch 'Markdown'
NeoBundleFetch 'suan/vim-instant-markdown'

call neobundle#end()
filetype plugin indent on     " Required!
NeoBundleCheck

" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif


autocmd BufEnter *.php set foldmethod=expr foldexpr=PHPFoldSetting(v:lnum)
autocmd BufEnter *.md set foldmethod=expr foldexpr=MarkdownLevel()
autocmd BufEnter .bashrc set foldmethod=expr foldexpr=BASHFoldSetting(v:lnum)


" php folding
function! PHPFoldSetting(lnum)
    let l:line = getline(a:lnum)
    if l:line =~ 'function '
        return '>1'
    elseif getline(a:lnum + 1) =~ ' \* '
        return 0
    elseif getline(a:lnum) =~ ' \* '
        return 0
    else
        return '='
    endif
endfunction

function! BASHFoldSetting(lnum)
    let l:line = getline(a:lnum)
    if l:line =~ '^.*() {'
        return '>1'
    elseif getline(a:lnum) =~ '^}'
        return '<1'
    elseif getline(a:lnum - 1) =~ '^}'
        return '0'
    else
        return '='
    endif
endfunction

" Markdown folding
function! MarkdownLevel()
    if getline(v:lnum) =~ '^# .*$'
        return ">1"
    endif
    if getline(v:lnum) =~ '^## .*$'
        return ">2"
    endif
    if getline(v:lnum) =~ '^### .*$'
        return ">3"
    endif
    if getline(v:lnum) =~ '^#### .*$'
        return ">4"
    endif
    if getline(v:lnum) =~ '^##### .*$'
        return ">5"
    endif
    if getline(v:lnum) =~ '^###### .*$'
        return ">6"
    endif
    return "=" 
endfunction

au BufEnter *.md setlocal foldexpr=MarkdownLevel()  
au BufEnter *.md setlocal foldmethod=expr   

"VimFilerの設定
"http://d.hatena.ne.jp/hrsh7th/20120229/1330525683
autocmd VimEnter * :VimFiler -buffer-name=explorer -split -winwidth=40 -toggle -no-quit -simple
"autocmd VimEnter * :VimFiler -buffer-name=explorer -split -toggle -no-quit
:let g:vimfiler_as_default_explorer = 1

nnoremap <F2> :VimFiler -buffer-name=explorer -split -winwidth=40 -toggle -no-quit -simple<CR>
"nnoremap <F2> :VimFiler -buffer-name=explorer -split -toggle -no-quit<Cr>
" autocmd! FileType vimfiler call g:my_vimfiler_settings()
function! s:my_vimfiler_settings()
  nmap     <buffer><expr><Cr> vimfiler#smart_cursor_map("\<Plug>(vimfiler_expand_tree)", "\<Plug>(vimfiler_edit_file)")
  nnoremap <buffer>s:call vimfiler#mappings#do_action('my_split')<Cr>
  nnoremap <buffer>v:call vimfiler#mappings#do_action('my_vsplit')<Cr>
endfunction


let my_action = { 'is_selectable' : 1 }
function! my_action.func(candidates)
  wincmd p
  exec 'split '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_split', my_action)

let my_action = { 'is_selectable' : 1 }                     
function! my_action.func(candidates)
  wincmd p
  exec 'vsplit '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_vsplit', my_action)

"neocompalcache
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }


"bufferのキーマップ
nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bp<CR>

" fileencoding
set termencoding=utf-8
set encoding=utf-8
set fileencodings=iso-2022-jp,utf-8,cp932,euc-jp
set ambiwidth=double

" vim-gitgutter
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '➜'
let g:gitgutter_sign_removed = '✘'

" lightline.vim
let g:lightline = {'colorscheme': 'Powerline'}

" カッコ補完
inoremap ( ()<ESC>i
inoremap <expr> ) ClosePair(')')
inoremap { {}<ESC>i
inoremap <expr> } ClosePair('}')
inoremap [ []<ESC>i
inoremap <expr> ] ClosePair(']')
" pair close checker.
" from othree vimrc ( http://github.com/othree/rc/blob/master/osx/.vimrc )
function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf


" EditCSV
function! s:edit_csv(path)
  call writefile(map(rabbit_ui#gridview(map(readfile(expand(a:path)),'split(v:val,",",1)')), "join(v:val, ',')"), expand(a:path))
endfunction
command! -nargs=1 EditCSV  :call <sid>edit_csv(<q-args>)
