"---------------------------------------------------------------------------
" カラー設定:
"colorscheme hybrid
syntax on


"---------------------------------------------------------------------------
" ウインドウに関する設定:
" ウインドウの幅
set columns=180
" ウインドウの高さ
set lines=80
" コマンドラインの高さ(GUI使用時)
set cmdheight=1

"---------------------------------------------------------------------------
" ウインドウに関する設定:
" function! ExecuteWindowResize()
"     if !exists('g:windowstatus')
"         execute 'simalt ~x'
"         let g:windowstatus = 1
"     elseif g:windowstatus == 1
"         execute 'simalt ~r'
"         let g:windowstatus = 2
"     elseif g:windowstatus == 2
"         execute 'simalt ~x'
"         let g:windowstatus = 1
" 
"     endif
" endfunction
" noremap <C-X> :call ExecuteWindowResize()<CR>

"

" フォント
" フォント
" set guifont=MeiryoKe_Console:h10:cSHIFTJIS
" set guifont=Ricty:h14
set guifont=源ノ角ゴシック\ Code\ JP\ Light:h14

"マルチディスプレイ用redraw
nnoremap <C-D> :redraw! <CR>
" 透過設定
set transparency=15 


