" Vim global plugin for Atcoder
" Last Change: 2019 Dec 5
" Maintainer: Ayato Suzuki <test@example.com>
" License: This file is placed in the public domain.
"



if exists("g:loaded_AtcoderX")
  finish
endif
let g:loaded_AtcoderX = 1

let s:save_cpo = &cpo
set cpo&vim


function! AtcoderX()
    :e ~/programs/python/atcoder.py
    :vert rightb term
    :wincmd h
    40:wincmd >
endfunction

command! AtcoderX :call AtcoderX()
let &cpo = s:save_cpo
unlet s:save_cpo
