" vi: fdm=marker
if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpo
set cpo&vim

"set shell=/bin/bash " macOS. zsh doesn't work
"set shell+=\ -O\ extglob
" see 'man bash'
" > If the extglob shell option is enabled using the shopt builtin
" for the use of ffplay

"map keybindings

nmap <silent> <cr> yy1gtGpg<tab>0cw---<ESC>0j

" split style :sp cherrypick.tsv
"nmap <cr> yy<C-w><C-w>Gp<C-W><C-w>j


" add a space in tab 1, nah.. too radical
"nmap <silent> <space> 1gtG2o<esc>g<tab>

nmap <silent> <delete> :s/^EDL/xxx/<cr>j
nmap <silent> <backspace> :s/^EDL/xxx/<cr>j

nnoremap <silent> <tab> :call tsv_edl#ffplay_current_range()<CR>
" start from cursor, stop at the end

nnoremap <silent> <S-tab> 02f\|2l:call tsv_edl#ffplay_current_range()<CR>
" start from head of line, stop at the end

nnoremap <silent> \<tab> :call tsv_edl#ffplay_current_range(v:false)<CR>
" start from cursor, play all along passing the end of this line

" Play clips continously from current line if starts with 'EDL'.
" One can press Ctrl-C very hard to stop.
nmap <silent> <space> 0:call tsv_edl#continous_play()<CR>

" Go to record_in timecode
nnoremap <silent> g9 0f,l

" Go to record_out timecode on the prevous line
nnoremap <silent> g8 0k2f,l

" Go to the start of subtitle
nnoremap <silent> g0 02f\|2l

" append a gap for 5 secs below current line.
nnoremap <silent> go oEDL	00:00:00,000	00:00:05,000	\| GAP \|	[ SPACE 5.0 secs ]<esc>

nmap <silent> \| :call tsv_edl#break_line()<CR>
nmap <silent> J :call tsv_edl#join_with_next_line()<CR>

"vnoremap <space> :'<,'>w !tsv2roughcut<CR>
vnoremap <space> :w !tsv2roughcut<CR>

"Folding Behavior {{{
set fdm=marker
"set foldopen=all
set foldclose=all
" }}}

set nrformats=
" only decimal

" shift the record_in timecode by 1 sec  {{{
nmap <silent> <S-Left> 02f:l<C-X>0?^EDL\\|\\---\\|xxx<CR>02f<Tab>2f:l<C-X>:.,/^EDL\\|---\\|xxx/s/[:\t]\zs\ze\d[,:]/0/ge<CR>/^EDL\\|xxx\\|---/<CR>02f:l
"                                                   ^^ this line and prev EDL line
"                                                  :   s/[:\t]\zs\ze\d[,:]/0/g    do zero padding afterwards
"                      ^^^^^^^^^^ record_in
"                                ^^^^^^^^^^^^^^^^^^ previous line, record_out
"
"nmap <silent> <S-Right> 02f:l<C-A>k02f<Tab>2f:l<C-A>j:?^EDL\|---\|xxx?.-1,.s/[:\t]\zs\ze\d[,:]/0/ge<CR>02f:l
nmap <silent> <S-Right> 02f:l<C-A>0?^EDL\\|\\---\\|xxx<CR>02f<Tab>2f:l<C-A>:.,/^EDL\\|---\\|xxx/s/[:\t]\zs\ze\d[,:]/0/ge<CR>/^EDL\\|xxx\\|---/<CR>02f:l

" {{{2
" shift the record_out timecode by 1 sec FIXME map doen't work
"nmap <silent> <S-Up> 02f<Tab>2f:ll<C-X>
"nmap <silent> <S-Down> 02f<Tab>2f:ll<C-A>
" }}}2

" }}}


"map <Up> gk
"map <Down> gj

set guioptions=aiAe "for macVim
" https://stackoverflow.com/questions/12177686/how-do-i-get-macvim-tabs-to-display-graphically/30108155

set wrap linebreak "to avoid words broken into characters
