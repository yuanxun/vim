" ------------------------------------------------------------------------------
" File: vimrc
" Description: _all_ the vim settings!
" Author: Timm Stelzer <timmstelzer@gmail.com>
" Source: https://github.com/tstelzer/vim
" ------------------------------------------------------------------------------
" STARTUP
" ##############################################################################

" check for compatible mode and stomp it
if &compatible
    set nocompatible
endif
" reset autocommands
" if has ('vim_starting')
"     au!
" endif
" check if is windows version of vim
let s:is_windows = has('win32') || has('win64')
" check for gui
let s:is_gui = has ('gui_running')
if s:is_windows
    " set shell=cmd.exe
    let $rtp = fnamemodify(resolve($HOME).'\vimfiles', ':p:gs?/?\\?')
else " linux or mac
    let $rtp = fnamemodify(resolve($HOME.'/.vim'), ':p')
endif
let s:patchedFont = 1           " is the font powerline patched?

" PLUGINS
" ##############################################################################

" Pre-plugin 
" ------------------------------------------------------------------------------
set runtimepath+=$rtp
call plug#begin($rtp.'plugged')

" Plugin list 
" ------------------------------------------------------------------------------
" PLUGINS MARKED WITH TODO ARE NEW TO ME AND NOT YET FULLY EXPLORED
" ------------------------------------------------------------------------------
" --- Meta
" ------------------------------------------------------------------------------
Plug 'gerw/vim-HiLinkTrace'                          " reveal syntax group stacks
Plug 'guns/xterm-color-table.vim'                    " show xterm color list
" ------------------------------------------------------------------------------
" --- Colorscheme
" ------------------------------------------------------------------------------
Plug 'C:/Users/Timm/vimfiles/plugged/welpe.vim'      " welpe colorscheme (local)
Plug 'chriskempson/base16-vim'                       " base16 vim port
Plug 'docapotamus/jellybeans.vim'                    " jellybeans
Plug 'altercation/vim-colors-solarized'              " solarized colorscheme
" ------------------------------------------------------------------------------
" --- Interface / File management
" ------------------------------------------------------------------------------
Plug 'scrooloose/nerdtree',                          " file browser
            \ { 'on' : ['NERDTreeFind', 'NERDTreeToggle'] }
Plug 'itchyny/lightline.vim'                         " simple statusline
Plug 'mhinz/vim-startify'                            " startup screen
Plug 'ctrlpvim/ctrlp.vim'                            " fuzzy stuff
            \ { 'on' : ['CtrlP', 'CtrlPBuffer', 'CtrlPMRU'] }
Plug 'junegunn/goyo.vim'                             " removes UI elements for distraction free editing
Plug 'vim-scripts/Tabmerge'                          " merge tabs
if s:is_windows
    Plug 'kkoenig/wimproved.vim',                    " Windows specific fullscreen mode
endif
" ------------------------------------------------------------------------------
" --- Filetype
" ------------------------------------------------------------------------------
Plug 'sheerun/vim-polyglot'              " multi lang
Plug 'JulesWang/css.vim'                             " css (vim runtime)
Plug 'hail2u/vim-css3-syntax'                        " css3
Plug 'cakebaker/scss-syntax.vim'                     " sass
Plug 'pangloss/vim-javascript'                       " javascript
Plug 'othree/html5.vim'                              " html5
Plug 'tpope/vim-markdown'                            " markdown
Plug 'captbaritone/better-indent-support-for-php-with-html'
" ------------------------------------------------------------------------------
" --- Syntax formatting
" ------------------------------------------------------------------------------
Plug 'maksimr/vim-jsbeautify'                        " js-beautify integration
" ------------------------------------------------------------------------------
" --- Syntax
" ------------------------------------------------------------------------------
Plug 'scrooloose/syntastic',                         " syntax integration (requires external tools)
            \ { 'for' : ['scss','html','javascript','css'] }
" ------------------------------------------------------------------------------
" --- Autocompletion
" ------------------------------------------------------------------------------
" Plug 'ervandew/supertab'                             " insert completion
Plug 'Raimondi/delimitMate'                            " auto close parentheses
Plug 'Valloric/YouCompleteMe',                         " completion engine, requires compilation
            \ { 'on': [] }
" ------------------------------------------------------------------------------
" --- Git
" ------------------------------------------------------------------------------
Plug 'airblade/vim-gitgutter' " adds diff status column
Plug 'tpope/vim-fugitive'                            " git wrapper
Plug 'junegunn/gv.vim',                              " git commit browser
            \ { 'on' : 'GV' }
" ------------------------------------------------------------------------------
" --- Language agnostic utility
" ------------------------------------------------------------------------------
Plug 'sirver/ultisnips'                              " snippet integration
Plug 'honza/vim-snippets'                            " snippets
Plug 'tpope/vim-commentary'                          " fileType specific comment creation mappings
Plug 'junegunn/vim-easy-align'                       " text align
Plug 'lilydjwg/colorizer'                            " hex, rgb and named color highlighting
" ------------------------------------------------------------------------------
" --- HTML
" ------------------------------------------------------------------------------
Plug 'Valloric/MatchTagAlways'                       " Highlight XML matching tags
Plug 'mattn/emmet-vim'                               " emmet integration
" ------------------------------------------------------------------------------
" --- Vanilla improvements
" ------------------------------------------------------------------------------
Plug 'triglav/vim-visual-increment'                  " increment sequencially with Ctrl-A
Plug 'thinca/vim-visualstar'                         " improves * and #
Plug 'Konfekt/FastFold'                              " improves Folds
Plug 'tpope/vim-speeddating'                         " improves number in-/decementation (C-X/C-A)
Plug 'tpope/vim-repeat'                              " makes lots of commands repeatable with .
Plug 'tpope/vim-abolish'                             " improves abbrev functionality
Plug 'mhinz/vim-sayonara',                           " essentially :qw
            \ { 'on' : 'Sayonara' }
Plug 'amix/open_file_under_cursor.vim'               " read its name ...
Plug 'edsono/vim-matchit'                            " improves % behaviour
Plug 'haya14busa/incsearch.vim'                      " improve incsearch
Plug 'justinmk/vim-sneak'                            " sneaky twochar motion
Plug 'Yggdroot/indentLine'                            " show indentation line
" ------------------------------------------------------------------------------
" --- Additional text-object funtionality
" ------------------------------------------------------------------------------
Plug 'tpope/vim-surround'                            " surround text-objects
Plug 'wellle/targets.vim'                            " more objects
Plug 'kana/vim-textobj-user'                         " new custom textobjects
Plug 'kana/vim-textobj-function'                     " adds functions as textobjects
Plug 'glts/vim-textobj-comment'                      " adds comments as textobject
Plug 'kana/vim-textobj-fold'                         " adds folds as textobjects
Plug 'kana/vim-textobj-indent'                       " adds indents as textobjects

" Post-plugin 
" ------------------------------------------------------------------------------
call plug#end()
filetype plugin indent on

" SOURCE
" ##############################################################################

runtime rc/abbreviations.vim
runtime rc/utils.vim

" SETTINGS
" ##############################################################################
set encoding=utf-8                      " vim encoding
scriptencoding utf-8                    " script encoding
set termencoding=utf-8                  " terminal encoding
set fileencoding=utf-8                  " file encoding
set fileencodings=ucs-bom,utf8,prc      " encoding
set langmenu=en helplang=en             " set menu and help language
set modelines=1 noshowmode              " allows filespefic vim options
set virtualedit=block                   " allows blockwise visualmode over EOL
set conceallevel=1                      " defines behaviour of concealed text
set concealcursor=ic                    " modes in which cursor is concealed
set wrapscan                            " search wraps around at EOF
set nojoinspaces                        " remove spaces when joining lines
set shortmess=atI                       " shortens some hit-enter prompts
set shortmess+=c                        " fix for YCM error message
set ffs=dos,unix                        " default fileformats
syntax enable                           " enable syntax highlighting
set history=500                         " length of history, see :h history
set undolevels=500                      " undo history lenght
set autoread                            " update files changed outside of vim
set hidden                              " abandoned buffers become hidden
set nobackup nowb noswapfile            " disable backupfiles
set mouse=                              " disable mouseinteraction
set backspace=indent,eol,start          " backspace scope in insert
set whichwrap+=<,>,h,l                  " allows movement over indentation
set ignorecase smartcase                " smartcase search
set nohlsearch                          " disable search highlighting
set incsearch                           " incremental search
" set lazyredraw                          " avoids unnessesarily redraws
set magic                               " regex magic
set matchtime=0                         " bracket blinking
set showmatch                           " jumps to a matching bracket
set noerrorbells novisualbell t_vb=     " disable audible and visual notice
set notimeout                            " no timeout on mappings
set ttimeoutlen=500                     " mapping timeout
set foldmethod=marker                   " use markers for folding
set foldlevel=0                         " depth of autoopening folds
try
  set switchbuf=useopen,split         " rules for new buffers
catch
endtry
set t_Co=256                            " terminal number of colors
set background=dark                     " use dark colorscheme
try
  colorscheme welpe                   " set colorscheme
catch
endtry
set showtabline=2                       " always show tabline
set number relativenumber               " enable number gutter
set numberwidth=4                       " width of numbergutter
set so=5                                " lines at which vim starts scrolling
set wildmenu                            " enhance commandline-completion
set laststatus=2                        " always show statusline

set cursorline                          " enable cursorline background
" autocmd FocusGained * call g:utils#pulse()

if s:is_windows                         " files to ignore
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store 
else
  set wildignore+=.git\*,.hg\*,.svn\*
endif
set cmdheight=1                         " height of commandline in lines

set expandtab                           " converts <tab> to spaces
set shiftwidth=2                        " number of spaces converted to <tab>
set tabstop=2                           " number of spaces that count as <tab>
augroup tabstopGroup
  au!
  au FileType css setlocal tabstop=4 shiftwidth=4
  au FileType sass setlocal tabstop=4 shiftwidth=4
  au FileType scss setlocal tabstop=4 shiftwidth=4
augroup end

set smarttab                            " improves vims treatment of <tab>s
set linebreak                           " soft breaks lines according to breakat
set nowrap                              " no wrap
set breakat=80                          " sets softwrap, needs wrap
set textwidth=500                       " maximum amount of text til forced EOL
set autoindent smartindent              " Auto indention
if executable('ag')                     " grep via silversearcher
  set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
  set grepformat=%f:%l:%c:%m
endif

" SYNTAX & HIGHLIGHTING
" ##############################################################################
au! FileType pov setlocal ft=php
" CSS3 Fixes 
" ------------------------------------------------------------------------------

augroup CSS3Fix
    au!
    " No idea where this comes from
    au FileType scss syn match cssBoxProp contained '\<padding\>'
    au FileType css syn match cssBoxProp contained '\<padding\>'
    au FileType scss syn match cssBoxProp contained '\<line-height\>'
    au FileType css syn match cssBoxProp contained '\<line-height\>'
    " Vendorprefixes are intentionally not part of the css3 runtime files ... 
    au FileType scss syn match cssBoxProp contained /-\(moz\|webkit\|o\|ms\)-[a-zA-Z-]\+/
    au FileType css syn match cssBoxProp contained /-\(moz\|webkit\|o\|ms\)-[a-zA-Z-]\+/
    " au FileType css match VendorPrefix /-\(moz\|webkit\|o\|ms\)-[a-zA-Z-]\+/
    " au FileType scss match VendorPrefix /-\(moz\|webkit\|o\|ms\)-[a-zA-Z-]\+/
    " font-smoothing Property missing
    au FileType css syn match cssFontProp contained "\<font-smoothing\>"
    au FileType scss syn match cssFontProp contained "\<font-smoothing\>"
    " grayscale Attribute missing
    au FileType css syn match cssFontAttr contained "\<\(subpixel-\)\=\grayscale\>"
    au FileType scss syn match cssFontAttr contained "\<\(subpixel-\)\=\grayscale\>"
    " fix functionnames starting with a keyword
    au FileType css setlocal iskeyword+=-
    au FileType scss setlocal iskeyword+=-
augroup END

" MAPPINGS
" ##############################################################################

" --- (Leader) 
" ------------------------------------------------------------------------------
let mapleader   = "\<Space>"
let g:mapleader = "\<Space>"

" --- (Unmap) 
" ------------------------------------------------------------------------------
map K         <Nop>
map <M-Right> <Nop>
map <M-Left>  <Nop>
map <M-Down>  <Nop>
map <M-Up>    <Nop>

" --- Default Remap 
" ------------------------------------------------------------------------------
" ignore EOL sign when using $ in visualmode
xnoremap $ $h

" using Ctrl-C doesn't properly call InsertLeave trigger in insertmode
inoremap <C-c> <esc>
xnoremap <C-c> <esc>

" don't yank to default register when changing something
nnoremap c "xc
xnoremap c "xc

" swap visualblock and visualselect
nnoremap v <C-V>
nnoremap <C-V> v
vnoremap v <C-V>
vnoremap <C-V> v

" don't move cursor when yanking in visualmode
vnoremap y myy`y
vnoremap Y myY`y

" center screen when moving screenwise
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz
xnoremap <C-u> <C-u>zz
xnoremap <C-d> <C-d>zz
xnoremap <C-f> <C-f>zz
xnoremap <C-b> <C-b>zz

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" go to end of inserted text after yank and put
xnoremap <silent> y y`]
xnoremap <silent> p p`]
nnoremap <silent> p p`]

" treat long lines as break lines
noremap  j g<down>
noremap  k g<up>

" center screen after next & prev search
nnoremap n nzz
nnoremap N Nzz
xnoremap n nzz
xnoremap N Nzz

" Yank until end of line with <S-y> as expected
nnoremap Y y$

" don't cancel selection after indenting in visual
xnoremap < <gv
xnoremap > >gv

" --- Keyboard specific alternatives 
" ------------------------------------------------------------------------------
" quickly write
nnoremap <leader>w  :update<CR>
nnoremap <leader>W  :update!<CR>

" quick fold toggeling
nnoremap <tab> za

" fold with ö instead of z 
" xnoremap öf mzzf`zzz
" noremap öF zF
" noremap öo zo
" noremap öd zd
" noremap öD zD
" noremap öC zC
" noremap öc zc
" noremap öa za
" noremap öA zA
" noremap öA zA
" noremap öM zM
" noremap öm zm
" noremap öR zR

" Jump to mark {a-zA-Z}
nnoremap ä '
nnoremap Ä `

" treat jk as <esc> in insertmode and commandmode
map! jk <ESC>

" start makro with alt-q instead of @
nmap Q @q
vmap Q :norm @q<cr>

" searchmode with shift-space
noremap <S-space> /

" --- Motion and Movement 
" ------------------------------------------------------------------------------
" goto start of fold
noremap gk [z
noremap gj ]z

" --- Manipulation and Selection 
" ------------------------------------------------------------------------------
" range copy here
nnoremap <C-y> :-,t.<left><left><left>

" newlines without insertmode
noremap <A-o> o<ESC>
noremap <A-S-o> <S-o><ESC>

" highlight last inserted text
nnoremap gV `[v`]

" Join upwards
noremap K kJ

" Make vaG select the entire file...
vnoremap aG VGo1G

" lower- and uppercase under cursor in normalmode
nnoremap gu  vgu
nnoremap gU  vgU
nnoremap gwu viwgu
nnoremap gwU viwgU

" in- and decrement visual (-block) selection
vnoremap <c-a> <c-a>gv
vnoremap <c-x> <c-x>gv

" --- jump to ...
" ------------------------------------------------------------------------------
" jump to diffs
" nnoremap üd ]c
" nnoremap üD [c

" jump to errors
nnoremap ge :cnext<cr>
nnoremap gE :cprev<cr>

" jump to errors
nnoremap gl :lnext<cr>
nnoremap gL :lprev<cr>

" --- Buffer and Window Management 
" ------------------------------------------------------------------------------

" buffers
nnoremap <leader>bn :bnew<cr>

" resize entire vim
nnoremap <S-right> :set columns+=5<CR>
nnoremap <S-left> :set columns-=5<CR>
nnoremap <S-up> :set lines-=3<CR>
nnoremap <S-down> :set lines+=3<CR>

" move between splits
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" center viewport
nnoremap <leader><space> zz

" switch to tabs
noremap <C-t>n :tabnew<cr>
noremap <C-t>o :tabonly<cr>
noremap <C-t>l :tabnext<cr>
noremap <C-t>h :tabprevious<cr>
noremap <C-t>j :tabfirst<cr>
noremap <C-t>k :tablast<cr>

" move tabs around
noremap <C-t><S-h> :tabmove -<CR>
noremap <C-t><S-l> :tabmove +<CR>
noremap <C-t><S-j> :tabmove 0<CR>
noremap <C-t><S-k> :tabmove $<CR>

" --- Custom functions and behaviour 
" ------------------------------------------------------------------------------
" quitall
nnoremap <silent><leader>Q :confirm wqa<CR>

" disable highlight when <leader><cr> is pressed
noremap <silent><leader><cr> :let @/ = ""<cr>

" edit and source vimrc
nnoremap <silent><leader>ve :cd $rtp<cr>:e $MYVIMRC<CR>
nnoremap <silent><leader>vs :cd $rtp<cr>:split $MYVIMRC<CR>
nnoremap <silent><leader>vv :cd $rtp<cr>:vsplit $MYVIMRC<CR>
nnoremap <silent><leader>vt :cd $rtp<cr>:tabnew $MYVIMRC<CR>
nnoremap <silent><leader>vs :source $MYVIMRC<CR>:call lightline#update()<CR>

" source current buffer
nnoremap <silent><leader>vf :source %<CR>

" Quickly open a buffer for scribble
noremap <leader>e  :tabnew $vimpath/temp/tempbuffer<cr>

" Switch CWD to the directory of the open buffer
" noremap <leader>cd :cd %:p:h<cr>:pwd<cr>

"substitute current word under the cursor
nnoremap <C-s> :%s/\M\<<C-r><C-w>\>//gc<Left><Left><Left>
xnoremap <C-s> y:%s/\M\<<C-r>"\>//gc<Left><Left><Left>

" substitute word in search register (/,?)
nnoremap <A-s> :%s/\<<C-r>/\>//gc<Left><Left><Left>

"resize viewport
nnoremap <silent> <Right> :call utils#intelligentVerticalResize('right')<CR>
nnoremap <silent> <Left> :call utils#intelligentVerticalResize('left')<CR>
nnoremap <silent> <Up> :resize -5<CR>
nnoremap <silent> <Down> :resize +5<CR>

" source local stuff
xnoremap <silent> g: :<c-U>call utils#sourceVimscript("visual")<cr>
nnoremap <silent> g: :call utils#sourceVimscript("currentline")<cr>

" move a line of text using ALT+[jk] (TODO: credit, forgot who ...)
nnoremap <A-k> :let fdm_sav=&fdm\|:set fdm=manual\|:m-2<CR>:let &fdm=fdm_sav<CR>==
nnoremap <A-j> :let fdm_sav=&fdm\|:set fdm=manual\|:m+<CR>:let &fdm=fdm_sav<CR>==
xnoremap <A-k> :<C-U>let fdm_sav=&fdm\|:set fdm=manual\|:'<,'>m'<-2<CR>gv=:let &fdm=fdm_sav<CR>gv
xnoremap <A-j> :<C-U>let fdm_sav=&fdm\|:set fdm=manual\|:'<,'>m'>+<CR>gv=:let &fdm=fdm_sav<CR>gv

" --- Options
" ------------------------------------------------------------------------------
" toggle numbers and relative numbers
nnoremap <silent><leader>tn  :call utils#toggleRNU()<cr>

" PLUGIN SETTINGS & MAPPINGS
" ##############################################################################

" Colorizer 
" ------------------------------------------------------------------------------
let g:colorizer_startup = 0
map <leader>tc <Plug>Colorizer

" Commentary 
" ------------------------------------------------------------------------------
nmap gC <Plug>CommentaryLine

" CtrlP
" ------------------------------------------------------------------------------
let g:ctrlp_working_path_mode = 'r'
" let g:ctrlp_open_new_file = 't'
let g:ctrlp_reuse_window = 'startify'
let g:ctrlp_max_depth = 15
let g:ctrlp_max_height = 20
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$|\node-modules'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']

map <leader>cf :CtrlP<cr>
map <leader>cb :CtrlPBuffer<cr>
map <leader>cm :CtrlPMRU<cr>

" delimitMate 
" ------------------------------------------------------------------------------
map! <C-l> <Plug>delimitMateS-Tab
map! <S-Tab> <Plug>delimitMateJumpMany
imap <expr> <CR> pumvisible()
            \ ? "\<C-Y>"
            \ : "<Plug>delimitMateCR"
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
" let delimitMate_excluded_regions = ''
" let delimitMate_matchpairs = "(:),[:],{:},<:>"
" let delimitMate_quotes = "\" ' ` *"
" au FileType html let b:delimitMate_quotes = "\" '"
" au FileType mail let b:delimitMate_expand_cr = 1
" let delimitMate_nesting_quotes = ['"','`']
" au FileType python let b:delimitMate_nesting_quotes = ['"']
" au FileType tcl let b:delimitMate_expand_space = 1
augroup delimitMateMatchpairs
  au! 
  au FileType vim let b:delimitMate_matchpairs = "(:),[:],{:}"
  au FileType html let b:delimitMate_matchpairs = "(:),<:>"
augroup END
" au! FileType javascript let b:delimitMate_eol_marker = ';'

" Easyalign 
" ------------------------------------------------------------------------------
xmap <leader>pl <Plug>(EasyAlign)
nmap <leader>pl <Plug>(EasyAlign)

" Emmet 
" ------------------------------------------------------------------------------
let g:user_emmet_install_global=0
autocmd FileType jade,html,php,css,scss EmmetInstall
let g:user_emmet_mode='a'
let g:user_emmet_leader_key='<C-e>'

" FastFold 
" ------------------------------------------------------------------------------
nmap zu <Plug>(FastFoldUpdate)

" Fugitive 
" ------------------------------------------------------------------------------
" nmap <leader>gs :Gstatus<CR>
nmap <leader>gd :Gvdiff<CR>
nmap <leader>gw :Gwrite<CR>
nmap <leader>gb :Gbrowse<CR>
nmap <leader>gc :Gcommit
nmap <leader>G :Git 

" Gitgutter 
" ------------------------------------------------------------------------------
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '_'
let g:gitgutter_sign_modified_removed = '*'
nmap <leader>hn <Plug>GitGutterNextHunk
nmap <leader>hp <Plug>GitGutterPrevHunk
nmap <Leader>ha <Plug>GitGutterStageHunk
nmap <Leader>hr <Plug>GitGutterUndoHunk
nmap <Leader>hv <Plug>GitGutterPreviewHunk
let g:gitgutter_override_sign_column_highlight = 1
let g:gitgutter_sign_column_always = 1
let g:gitgutter_diff_args = '--ignore-space-at-eol --ignore-all-space --ignore-blank-lines'
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

" Goyo 
" " ------------------------------------------------------------------------------
let g:goyo_height = "100%"
let g:goyo_width = 90

function! s:goyo_enter()
    set noshowmode
    set laststatus=0
    set nonu nornu
endfunction
function! s:goyo_leave()
    set showmode
    set laststatus=2
    set nu rnu
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User Goyoleave nested call <SID>goyo_leave()

nnoremap <silent>           <leader>pz :Goyo<CR>

" GV 
" ------------------------------------------------------------------------------
nmap <leader>gl :GV<cr>
nmap <leader>gL :GV!<cr>

" HiLinkTrace 
" ------------------------------------------------------------------------------
nnoremap <leader>ph :HLT<CR>

" Js-Beautify 
" ------------------------------------------------------------------------------
autocmd FileType javascript nnoremap <buffer> <leader>pb :call JsBeautify()<cr>
autocmd FileType json nnoremap <buffer> <leader>pb :call JsonBeautify()<cr>
autocmd FileType jsx nnoremap <buffer> <leader>pb :call JsxBeautify()<cr>
autocmd FileType html nnoremap <buffer> <leader>pb :call HtmlBeautify()<cr>
autocmd FileType php nnoremap <buffer> <leader>pb :call HtmlBeautify()<cr>
autocmd FileType css nnoremap <buffer> <leader>pb :call CSSBeautify()<cr>
autocmd FileType scss nnoremap <buffer> <leader>pb :call CSSBeautify()<cr>
autocmd FileType javascript xnoremap <buffer> <leader>pb :call RangeJsBeautify()<cr>
autocmd FileType json xnoremap <buffer> <leader>pb :call RangeJsonBeautify()<cr>
autocmd FileType jsx xnoremap <buffer><leader>pb :call RangeJsxBeautify()<cr>
autocmd FileType html xnoremap <buffer> <leader>pb :call RangeHtmlBeautify()<cr>
autocmd FileType php xnoremap <buffer> <leader>pb :call RangeHtmlBeautify()<cr>
autocmd FileType css xnoremap <buffer><leader>pb :call RangeCSSBeautify()<cr>
autocmd FileType scss xnoremap <buffer><leader>pb :call RangeCSSBeautify()<cr>

" Lightline 
" ------------------------------------------------------------------------------
let s:LLMaxWidth = 80

function! LLMode()
  return lightline#mode()
endfunction

function! LLFugitive()
  if exists("*fugitive#head")
    let _ = fugitive#head()
    if s:patchedFont == 1
      return winwidth(0) > s:LLMaxWidth ? (strlen(_) ? ' '._ : '?') : ''
    else
      return winwidth(0) > s:LLMaxWidth ? (strlen(_) ? '# '._ : '?') : ''
    endif
  endif
endfunction

function! LLPercent()
  return winwidth(0) > s:LLMaxWidth ? 'percent' : ''
endfunction

function! LLLineinfo()
  return winwidth(0) > s:LLMaxWidth ? 'lineinfo' : ''
endfunction

function! LLModified()
  if &filetype != "help" && &modified
    if s:patchedFont == 1
      return ""
    else
      return "+"
    endif
  else
    return ""
  endif
endfunction

function! LLReadonly()
  if &filetype == "help" || &readonly
    if s:patchedFont == 1
      return ""
    else
      return "x"
    endif
  else
    return ""
  endif
endfunction

function! LLFilepath()
  " split path into list
  let path = split(expand('%:p:h'), '\\')
  " show only tail of path
  let shorterpath = '..\'.path[-2].'\'.path[-1].'\'
  return winwidth(0) > s:LLMaxWidth ? shorterpath : ''
endfunction

function! LLFilename()
  let fname = expand('%:t')
  if winwidth(0) > s:LLMaxWidth 
    return fname == 'NERD_tree' ? 'NERD' :
          \ ('' != LLFilepath() ?  LLFilepath() : '') .
          \ ('' != fname ? fname  : '[no name]') .
          \ ('' != LLReadonly() ? ' ' . LLReadonly() . ' ' : '') .
          \ ('' != LLModified() ? ' ' . LLModified() . ' ' : '')
  else
    return fname
  endif
endfunction

function! LLFiletype()
  return winwidth(0) > s:LLMaxWidth ? (strlen(&filetype) ? &filetype : '?') : ''
endfunction

let g:lightline = {
      \ 'colorscheme': 'welpe',
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ 'component': {
      \ 'lineinfo': '%l:%c (%L)',
      \ 'zeitwerk': 'Zeitwerk gVIM'
      \ },
      \ 'component_function': {
      \ 'mode': 'LLMode',
      \ 'fugitive': 'LLFugitive',
      \ 'filename': 'LLFilename',
      \ 'readonly': 'LLReadonly',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'active': {
      \ 'left': [ ['fugitive'], ['filename'] ],
      \ 'right': [ ['filetype'], ['lineinfo', 'syntastic'] ]
      \ },
      \ 'inactive': {
      \ 'left': [ ['filename'] ],
      \ 'right': [ ['filetype'] ]
      \ },
      \ 'tabline': {
      \ 'left': [ [ 'tabs' ] ],
      \ 'right': [ [ 'zeitwerk' ] ]
      \ },
      \ }

" Incsearch 
" ------------------------------------------------------------------------------
let g:incsearch#auto_nohlsearch = 1
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n <Plug>(incsearch-nohl-n)
map N <Plug>(incsearch-nohl-N)
map * <Plug>(incsearch-nohl-*)
map # <Plug>(incsearch-nohl-#)
" map <leader>/ <Plug>(incsearch-fuzzy-/)
" map <leader>? <Plug>(incsearch-fuzzy-?)

" indentLine 
" ------------------------------------------------------------------------------
let g:indentLine_color_term = 236
" let g:indentLine_conceallevel = 2
let g:indentLine_enabled = 0
let g:indentLine_faster = 1
let g:indentLine_concealcursor = 'ic'

map <leader>ti :IndentLinesToggle<cr>

" MatchTagAlways 
" ------------------------------------------------------------------------------
let g:mta_use_matchparen_group = 1
let g:mta_filetypes = {
      \ 'html' : 1,
      \ 'xhtml' : 1,
      \ 'xml' : 1,
      \ 'jade' : 1,
      \ 'php' : 1,
      \}
nnoremap <silent>gt :MtaJumpToOtherTag<cr>

" NERDTree 
" ------------------------------------------------------------------------------
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeAutoCenter = 1
let g:NERDTreeShowLineNumbers = 0
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeBookmarksFile = $rtp.'temp/.NERDTreeBookmarks'
let g:NERDTreeMinimalUI = 1
let g:NERDTreeWinPos = "left"
let g:NERDTreeShowHidden = 1
let g:NERDTreeSortHiddenFirst = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeWinSize = 40
let g:NERDTreeIgnore = ['.git','.swp', 'NTUSER*']
let g:NERDTreeChDirMode = 1
let g:NERDTreeStatusline = ''
let g:NERDTreeCascadeOpenSingleChildDir = 0

noremap <leader>nn :NERDTreeToggle<cr>
noremap <leader>nh :NERDTreeToggle ~/<cr>
noremap <silent> <leader>nf :NERDTreeFind<cr>cd
nnoremap <leader>nb :Bookmark<space>

let NERDTreeMapOpenVSplit='v'
let NERDTreeMapOpenSplit='s'

" ~~~ Neocomplete 
" ------------------------------------------------------------------------------
" let g:acp_enableAtStartup = 0
" let g:neocomplete#enable_at_startup = 0
" let g:neocomplete#enable_smart_case = 1
" let g:neocomplete#sources#syntax#min_keyword_length = 2
" inoremap <expr><C-g>     neocomplete#undo_completion()
" inoremap <expr><C-l>     neocomplete#complete_common_string()
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" if !exists('g:neocomplete#sources#omni#input_patterns')
"   let g:neocomplete#sources#omni#input_patterns = {}
" endif

" Plug 
" ------------------------------------------------------------------------------
let g:plug_timeout = 240

" ~~~ polyglot 
" ------------------------------------------------------------------------------
" let g:polyglot_disabled = ['css', 'markdown', 'javaScript', 'html']

" ~~~ QuickScope 
" ------------------------------------------------------------------------------
" let g:qs_highlight_on_keys=['f', 'F', 't', 'T']
" nnoremap <leader>pq :QuickScopeToggle<CR>

" Sayonara 
" ------------------------------------------------------------------------------
" save current session & close all buffers
nnoremap <leader>q :Sayonara<CR>

" Startify 
" ------------------------------------------------------------------------------
let g:startify_session_delete_buffers = 1
let g:startify_files_number = 9
let g:startify_change_to_dir = 1
let g:startify_relative_path = 1
let g:startify_use_env = 1
let g:startify_enable_special = 0
let g:startify_custom_indices = ['1', '2', '3', '4', '5', '6', '7', '8', '9', 'v', 'g', 't', 'd', 'D', 'r', 'R', 'l', 'L']
if s:is_windows
  let g:startify_bookmarks = [
        \ $rtp,
        \ '~/Google Drive/',
        \ '~/temp'
        \ ]
endif
let g:startify_update_oldfiles = 1
let g:startify_session_autoload = 0
let g:startify_session_persistence = 0
if s:is_windows
  let g:startify_skiplist = [
        \ '\.vim',
        \ '\.log',
        \ 'plugged\.*\doc',
        \ 'COMMIT_EDITMSG'
        \ ]
endif
let g:startify_list_order = [
      \ ['    LRU:'],
      \ 'files',
      \ ['    Bookmarks:'],
      \ 'bookmarks',
      \ ['    Sessions:'],
      \ 'sessions',
      \ ]
let g:startify_custom_header = g:utils#centerLines([
      \ '                               ',
      \ '   __      __ _____  __  __    ',
      \ '   \ \    / /|_   _||  \/  |   ',
      \ '    \ \  / /   | |  | \  / |   ',
      \ '     \ \/ /    | |  | |\/| |   ',
      \ '      \  /    _| |_ | |  | |   ',
      \ '       \/    |_____||_|  |_|   ',
      \ ])
augroup Startify
  au!
  au User Startified file Startify
  au User Startified setlocal buftype=
  au User Startified setlocal nowrap
  au User Startified setlocal nonu norln
  au User Startified setlocal colorcolumn=
augroup END

nnoremap <leader>sd :SSave default<CR>y<CR>
nnoremap <leader>sD :SLoad default<CR>

" Surround 
" ------------------------------------------------------------------------------
nmap ms  ys
nmap mS  ysiW
nmap mss yss
nmap mSS ySS

" ~~~ Supertab 
" ------------------------------------------------------------------------------
" let g:SuperTabDefaultCompletionType = '<C-n>'

" Syntastic 
" ------------------------------------------------------------------------------
let g:syntastic_auto_loc_list = 0
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_loc_list_height = 1
let g:syntastic_auto_jump = 3 " only jump if errors are present
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_cursor_column = 0
let g:syntastic_stl_format = "%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}"
let g:syntastic_full_redraws = 1
let g:syntastic_error_symbol = "E "
let g:syntastic_warning_symbol = "W "
let g:syntastic_mode_map = {
      \ "mode": "passive",
      \ "active_filetypes": [],
      \ "passive_filetypes": [] }

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_HTML_checkers = ['jshint']
let g:syntastic_SASS_checkers = ['sass']
let g:syntastic_SCSS_checkers = ['sass']
let g:syntastic_CSS_checkers = ['sass']
let g:syntastic_pug_checkers = ['pug_lint']

map <leader>ps :SyntasticCheck<cr>:call lightline#update()<cr>

" sneak
" ------------------------------------------------------------------------------
let g:sneak#streak = 1
let g:sneak#textobject_z = 0
let g:sneak#use_ic_scs = 1

map ö <Plug>Sneak_s
map Ö <Plug>Sneak_S

" Tabmerge 
" ------------------------------------------------------------------------------
noremap <C-t>mh :Tabmerge left<CR>
noremap <C-t>ml :Tabmerge right<CR>

" Text-Obj-Fold 
" ------------------------------------------------------------------------------
let g:textobj_fold_no_default_key_mappings = 1

xmap aö <Plug>(textobj-fold-a)
xmap iö <Plug>(textobj-fold-i)

" UltiSnips 
" ------------------------------------------------------------------------------
let g:UltiSnipsEditSplit = 'context'
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger= '<C-k>'

nmap <silent><leader>pu :UltiSnipsEdit<cr>

" YouCompleteMe 
" ------------------------------------------------------------------------------
set omnifunc=syntaxcomplete#Complete
let g:ycm_auto_trigger = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ 'unite' : 1,
      \ 'text' : 1,
      \ 'vimwiki' : 1,
      \ 'pandoc' : 1,
      \ 'infolog' : 1,
      \ 'mail' : 1
      \}
if exists('youcompleteme#Enable()')
  augroup load_us_ycm
    autocmd!
    autocmd InsertEnter * call plug#load('YouCompleteMe')
          \| call youcompleteme#Enable() | autocmd! load_us_ycm
  augroup END
endif

" xterm colors 
" ------------------------------------------------------------------------------
nnoremap <silent><leader>px :VXtermColorTable<CR>

" Wimproved.vim 
" ------------------------------------------------------------------------------
if s:is_windows
  autocmd GUIEnter * set columns=120
  autocmd GUIEnter * set lines=38
  autocmd GUIEnter * silent! WToggleClean
endif

noremap <F11> :WToggleFullscreen<CR>
