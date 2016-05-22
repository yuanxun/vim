" ------------------------------------------------------------------------------
" File: gvimrc
" Description: _all_ the vim settings!
" Author: Timm Stelzer <timmstelzer@gmail.com>
" Source: https://github.com/tstelzer/vim
" ------------------------------------------------------------------------------
" SETTINGS
" ##############################################################################

let s:is_windows = has('win32') || has('win64')
if s:is_windows
  try
    " set guifont=Fira_Mono_Patch_Medium:h10:cANSI
    set guifont=Consolas:h11:cANSI
  catch
  endtry
  set columns=160
  set lines=40
  return strlen(_) ? '# '._ : ''
else
  try
    set guifont==Fira\ Mono\ Medium\ 10
  catch
  endtry
endif
set guioptions-=m                       " disable the menu
set guioptions-=t                       " disable tear-off menus
set guioptions-=T                       " disable toolbar
set guioptions-=r                       " disable righthand scrollbar
set guioptions-=L                       " disable lefthand scrollbar
set guitablabel=%N\ %f                      " tab title
set guicursor+=n-v-c:block-Cursor-blinkon0
set guicursor+=i-ci:ver15-iCursor-blinkwait100-blinkon350-blinkoff350

