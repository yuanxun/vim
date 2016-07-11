" ------------------------------------------------------------------------------
" File: gvimrc
" Description: _all_ the vim settings!
" Author: Timm Stelzer <timmstelzer@gmail.com>
" Source: https://github.com/tstelzer/vim
" ------------------------------------------------------------------------------
" SETTINGS
" ##############################################################################
try
  set guifont=Fira_Mono_Patch_Medium:h10:cANSI
catch
endtry
set guioptions-=m                       " disable the menu
set guioptions-=t                       " disable tear-off menus
set guioptions-=T                       " disable toolbar
" set guioptions-=e                       " disable tabs
set guioptions-=r                       " disable righthand scrollbar
set guioptions-=L                       " disable lefthand scrollbar
" set guitablabel=%N\ %f                      " tab title
set guicursor+=n-v-c:block-Cursor-blinkon0
set guicursor+=i-ci:ver15-iCursor-blinkwait100-blinkon350-blinkoff350

try
  colorscheme welpe                   " set colorscheme
catch
endtry

augroup Windows
  autocmd GUIEnter * silent! WToggleClean
  autocmd GUIEnter * set columns=999
  autocmd GUIEnter * set lines=999
augroup END

" PLUGINS
" ##############################################################################

" Wimproved.vim 
" ------------------------------------------------------------------------------
noremap <F11> :WToggleFullscreen<CR>
