" ------------------------------------------------------------------------------
" File: vimrc
" Description: _all_ the vim settings!
" Author: Timm Stelzer <timmstelzer@gmail.com>
" Source: https://github.com/tstelzer/vim
" ------------------------------------------------------------------------------
" STARTUP
" ##############################################################################

" if !empty($CONEMUBUILD) 
"   set shell=/usr/bin/bash
"   set shellslash
"   set term=xterm
"   set t_Co=16
"   let &t_AB="\e[48;5;%dm" 
"   let &t_AF="\e[38;5;%dm" 
"   let s:patchedFont = 0
let s:patchedFont = 1

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
    let $undodir=fnamemodify(resolve($rtp.'\undodir'), ':p:gs?/?\\?')
else " linux or mac
    let $rtp = fnamemodify(resolve($HOME.'/.vim'), ':p')
    let $undodir=fnamemodify(resolve($rtp.'/undodir'), ':p')
endif

" PLUGINS
" ##############################################################################

set runtimepath+=$rtp
call plug#begin($rtp.'plugged')

" --- Meta
" ------------------------------------------------------------------------------
Plug 'gerw/vim-HiLinkTrace'                           " reveal syntax group stacks

" --- Colorscheme
" ------------------------------------------------------------------------------
Plug 'tstelzer/welpe.vim'                             " welpe

" --- Interface / File management
" ------------------------------------------------------------------------------
Plug 'tpope/vim-vinegar'                              " split explorer
Plug 'itchyny/lightline.vim'                          " simple statusline
Plug 'ctrlpvim/ctrlp.vim'                             " fuzzy stuff
Plug 'vim-scripts/Tabmerge'                           " merge tabs
if s:is_windows
    Plug 'kkoenig/wimproved.vim', { 'branch': 'dev' } " Windows fullscreen mode
endif
Plug 'junegunn/goyo.vim', { 'on' : 'Goyo' }           " distraction free writing

" --- Filetype
" ------------------------------------------------------------------------------
Plug 'JulesWang/css.vim'                               " css (vim runtime)
Plug 'hail2u/vim-css3-syntax'                          " css3
Plug 'cakebaker/scss-syntax.vim'                       " sass
Plug 'pangloss/vim-javascript'                         " javascript
Plug 'othree/html5.vim'                                " html5
Plug 'tpope/vim-markdown'                              " markdown

" --- Syntax formatting
" ------------------------------------------------------------------------------
" Plug 'maksimr/vim-jsbeautify'                        " js-beautify integration

" --- Syntax
" ------------------------------------------------------------------------------
Plug 'scrooloose/syntastic'                            " syntax integration (requires external tools)

" --- Autocompletion
" ------------------------------------------------------------------------------
Plug 'Raimondi/delimitMate'                          " auto close parentheses
" Plug 'ervandew/supertab'                             " Perform insert mode compl. with tab
Plug 'Shougo/neocomplete.vim'                        " autocompletion based on lua

" --- Git
" ------------------------------------------------------------------------------
Plug 'airblade/vim-gitgutter'                        " adds diff status column
Plug 'tpope/vim-fugitive'                            " git wrapper
Plug 'junegunn/gv.vim'                              " git commit browser

" --- Language agnostic utility
" ------------------------------------------------------------------------------
Plug 'sirver/ultisnips'                              " snippet integration
Plug 'tpope/vim-commentary'                          " fileType specific comment creation mappings
Plug 'junegunn/vim-easy-align'                       " text align
Plug 'lilydjwg/colorizer'                            " hex, rgb and named color highlighting

" --- HTML
" ------------------------------------------------------------------------------
Plug 'mattn/emmet-vim'                               " emmet integration

" --- Vanilla improvements
" ------------------------------------------------------------------------------
Plug 'thinca/vim-visualstar'                         " improves * and #
Plug 'Konfekt/FastFold'                              " improves Folds
Plug 'tpope/vim-speeddating'                         " improves number in-/decementation (C-X/C-A)
Plug 'tpope/vim-repeat'                              " makes lots of commands repeatable with .
Plug 'tpope/vim-abolish'                             " improves abbrev functionality
Plug 'amix/open_file_under_cursor.vim'               " read its name ...
Plug 'edsono/vim-matchit'                            " improves % behaviour
Plug 'haya14busa/incsearch.vim'                      " improve incsearch
Plug 'justinmk/vim-sneak'                            " sneaky twochar motion
Plug 'Yggdroot/indentLine'                           " show indentation line
Plug 'stefandtw/quickfix-reflector.vim'              " allows modification of quickfix buffer

" --- Additional text-object funtionality
" ------------------------------------------------------------------------------
Plug 'tpope/vim-surround'                            " surround text-objects
Plug 'wellle/targets.vim'                            " more objects
Plug 'chaoren/vim-wordmotion'                        " better word motions (camelcase)
Plug 'kana/vim-textobj-user'                         " new custom textobjects
Plug 'kana/vim-textobj-function'                     " adds functions as textobjects
Plug 'glts/vim-textobj-comment'                      " adds comments as textobject
Plug 'kana/vim-textobj-indent'                       " adds indents as textobjects
Plug 'whatyouhide/vim-textobj-xmlattr'               " adds XML attributes as txobj
Plug 'tommcdo/vim-exchange'                          " easy word exchange

" --- (Post-plugin)
" ------------------------------------------------------------------------------
call plug#end()
filetype plugin indent on

" SOURCE
" ##############################################################################

runtime rc/utils.vim

" SETTINGS
" ##############################################################################
set encoding=utf-8                      " vim encoding
scriptencoding utf-8                    " script encoding
set termencoding=utf-8                  " terminal encoding
set fileencoding=utf-8                  " file encoding
set fileencodings=ucs-bom,utf8,prc      " encoding
set langmenu=en helplang=en             " set menu and help language
set nospell                             " disable spellcheck
set spelllang=en                        " set spellcheck language
set modelines=1 noshowmode              " allows filespefic vim options
set virtualedit=block                   " allows blockwise visualmode over EOL
" set conceallevel=1                      " defines behaviour of concealed text
set concealcursor=ic                    " modes in which cursor is concealed
set wrapscan                            " search wraps around at EOF
set nojoinspaces                        " remove spaces when joining lines
set shortmess=atI                       " shortens some hit-enter prompts
set shortmess+=c                        " fix for YCM error message
let g:netrw_bufsettings='noma nomod nu rnu nobl nowrap ro' 
let g:netrw_banner = 0 " hide banner
let g:netrw_list_hide='.*\.swp$,\.DS_Store' " hide swp, DS_Store files
let g:netrw_liststyle=3 " set tree style listing
let g:netrw_sort_sequence='[\/]$' " display directories first
let g:netrw_sort_options='i' " ignore case on sorting
" let g:netrw_altv = 1 " vspilt netrw to the left window 
" let g:netrw_winsize = 30 " 30% of the screen for the netrw window, 70% for the file window
" let g:netrw_browse_split = 4 " open file in a previous buffer (right window)
set ffs=dos,unix                        " default fileformats
set history=500                         " length of history, see :h history
set undolevels=500                      " undo history lenght
set undofile
set undodir=$undodir
set nobackup nowb noswapfile            " disable backupfiles
set noautoread                            " update files changed outside of vim
set hidden                              " abandoned buffers become hidden
set mouse=                              " disable mouseinteraction
set ignorecase smartcase                " smartcase search
set nohlsearch                          " disable search highlighting
set incsearch                           " incremental search
" set lazyredraw                          " avoids unnessesarily redraws
set magic                              " regex magic
set matchtime=0                         " bracket blinking
set showmatch                           " jumps to a matching bracket
set noerrorbells novisualbell t_vb=     " disable audible and visual notice
set notimeout                            " no timeout on mappings
set ttimeoutlen=500                     " mapping timeout

set foldmethod=marker                   " use markers for folding
set foldlevel=0                         " depth of autoopening folds
try
  set switchbuf=useopen,vsplit         " rules for new buffers
catch
endtry
syntax enable                           " enable syntax highlighting
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

if s:is_windows                         " files to ignore
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store 
else
  set wildignore+=.git\*,.hg\*,.svn\*
endif
set suffixesadd+=.js,.html,.css,.scss
set cmdheight=1                         " height of commandline in lines

set expandtab                           " converts <tab> to spaces
set shiftwidth=2                        " number of spaces converted to <tab>
set softtabstop=2
set tabstop=2                           " number of spaces that count as <tab>

set omnifunc=syntaxcomplete#Complete    " enable syntax completion

set backspace=indent,eol,start          " backspace scope in insert
set whichwrap+=<,>,h,l                  " allows movement over indentation
set smarttab                            " improves vims treatment of <tab>s
set linebreak                           " soft breaks lines according to breakat
set nowrap                                " no wrap
set breakat=80                          " sets softwrap, needs wrap
set textwidth=500                       " maximum amount of text til forced EOL
set autoindent smartindent             " Indentation rules
set breakindent

" by /u/ghost-in-a-shell from /r/vim
set formatoptions+=tcoqnl1j             " see help fo-table
set formatoptions-=r
set formatlistpat=^\\s*                    " Optional leading whitespace
set formatlistpat+=[                       " Start class
set formatlistpat+=\\[({]\\?               " |  Optionally match opening punctuation
set formatlistpat+=\\(                     " |  Start group
set formatlistpat+=[0-9]\\+                " |  |  A number
set formatlistpat+=\\\|[iIvVxXlLcCdDmM]\\+ " |  |  Roman numerals
set formatlistpat+=\\\|[a-zA-Z]            " |  |  A single letter
set formatlistpat+=\\)                     " |  End group
set formatlistpat+=[\\]:.)}                " |  Closing punctuation
set formatlistpat+=]                       " End class
set formatlistpat+=\\s\\+                  " One or more spaces
set formatlistpat+=\\\|^\\s*[-–+o*]\\s\\+  " Or ASCII style bullet points

" if executable('ag')                     " grep via silversearcher
"   set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
"   set grepformat=%f:%l:%c:%m
" endif

" AUTOCOMMANDS
" ##############################################################################

autocmd! FileType pov setlocal ft=php
autocmd! FileType txt call g:utils#plainText()

" ABBREVIATIONS
" ##############################################################################

cnoreabbrev <expr> h getcmdline() == 'h' ? 'tab help' : 'h'
" insert date
iab <expr> ddate strftime("%Y %b %d %H:%M")
" php function name, excluding function keyword and brackets
cabbr xfunc \s\zs[a-zA-Z_]*\ze(

" MAPPINGS
" ##############################################################################

" --- (Leader)
" ------------------------------------------------------------------------------
let mapleader   = "\<Space>"
" emmet leader
let g:user_emmet_leader_key='<C-e>'
" CamelCaseMotion trigger
" call camelcasemotion#CreateMotionMappings('<leader>')
" --- (Unmap) 
" ------------------------------------------------------------------------------
map K         <Nop>
map <M-Right> <Nop>
map <M-Left>  <Nop>
map <M-Down>  <Nop>
map <M-Up>    <Nop>

" --- Default Remap / Easier mappings
" ------------------------------------------------------------------------------
" replace default inner-obj with camelcasemotion-obj
" omap <silent> iw <Plug>CamelCaseMotion_iw
" xmap <silent> iw <Plug>CamelCaseMotion_iw
" omap <silent> ib <Plug>CamelCaseMotion_ib
" xmap <silent> ib <Plug>CamelCaseMotion_ib
" omap <silent> ie <Plug>CamelCaseMotion_ie
" xmap <silent> ie <Plug>CamelCaseMotion_ie

" alternate buffers
nnoremap <silent> <bs> <C-^>

" invoke incsearch
map / <Plug>(incsearch-forward)
map <S-space> <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map <C-space> <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n <Plug>(incsearch-nohl-n)
map N <Plug>(incsearch-nohl-N)
map * <Plug>(incsearch-nohl-*)
map # <Plug>(incsearch-nohl-#)
" map <leader>/ <Plug>(incsearch-fuzzy-/)
" map <leader>? <Plug>(incsearch-fuzzy-?)

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
noremap j g<down>
noremap k g<up>

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

" jump over delimiters
map! <C-l> <Plug>delimitMateS-Tab
map! <S-Tab> <Plug>delimitMateJumpMany

" auto insert delimiters when pressing <ENTER>
imap <expr> <CR> pumvisible() ? "\<C-Y>" : "<Plug>delimitMateCR"

" quickly write
nnoremap <leader>w  :update<CR>
nnoremap <leader>W  :update!<CR>

" treat jk as <esc> in insertmode and commandmode
map! jk <ESC>

" start makro with alt-q instead of @
nmap Q @q
vmap Q :norm @q<cr>

" --- Motion, Movement and Txtobjs
" ------------------------------------------------------------------------------
" goto start of fold
noremap gk [z
noremap gj ]z

" update folds
nmap zu <Plug>(FastFoldUpdate)

" invoke sneak
map ö <Plug>Sneak_s
map Ö <Plug>Sneak_S

" diffs
nnoremap äd ]c
nnoremap äD [c

" quickfix
nnoremap äq :cnext<cr>
nnoremap Äq :cfirst<cr>
nnoremap äQ :cprev<cr>
nnoremap ÄQ :clast<cr>

" locationlist
nnoremap äl :lnext<cr>
nnoremap Äl :lfirst<cr>
nnoremap äL :lprev<cr>
nnoremap ÄL :llast<cr>

" spelling
nnoremap äs ]s
nnoremap äS [s

" git hunks
nmap äh <Plug>GitGutterNextHunk
nmap äH <Plug>GitGutterPrevHunk

" add prefix for vim-wordmotion
let g:wordmotion_mappings = {
\ 'w' : '<M-w>',
\ 'b' : '<M-b>',
\ 'e' : '<M-e>',
\ 'ge' : 'g<M-e>',
\ 'aw' : 'a<M-w>',
\ 'iw' : 'i<M-w>'
\ }

" --- Manipulation and Selection 
" ------------------------------------------------------------------------------
" range copy here
nnoremap <C-y> :-,t.<left><left><left>

" invoke surround mappings
" [map] surround <motion>
nmap ms  ys
" shorthand for [map] surround entire outer line
nmap mS ySS

" newlines without insertmode
noremap <A-o> o<ESC>
noremap <A-S-o> <S-o><ESC>

" highlight last inserted text
nmap gV `[v`]

" comment out current line
nmap gC <Plug>CommentaryLine

" comment out last inserted text
nmap gci gVgc

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

" correct word under cursor
" nnoremap <leader>c z=
" nnoremap <leader>C 1z=

" target folds as textobject
xmap az <Plug>(textobj-fold-a)
xmap iz <Plug>(textobj-fold-i)

" --- Buffer and Window Management 
" ------------------------------------------------------------------------------
" change working dir to current files'
nnoremap <silent> cd: :cd %:p:h<cr>:echo 'Working dir now 'getcwd()<cr>

" merge tabs
noremap <C-t>mh :Tabmerge left<CR>
noremap <C-t>ml :Tabmerge right<CR>

" Ctrl-P fuzzy searches
map <leader>cf :CtrlP<cr>
map <leader>cb :CtrlPBuffer<cr>
map <leader>cm :CtrlPMRU<cr>

" fun! IsNetrw() 
"   if &ft == 'netrw'
"     return '<Plug>VinegarUp'
"   else
"     return ':Explore'
"   endif
" endfun

" nmap <expr> <silent> - IsNetrw()
" invoke netrw in vsplit
nmap _ :Vex<cr>
" invoke netrw in split
nmap <A--> :Sex<cr>

" pseudo-maximize windows
nnoremap <F12> :set lines=999 columns=999<cr>

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
" Neocomplete
nnoremap <leader>pn :NeoCompleteEnable<cr>

inoremap <expr> <C-g> neocomplete#undo_completion()
inoremap <expr> <C-l> neocomplete#complete_common_string()
" tab completetion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr> <C-h> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr> <BS>  neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr> <C-l> pumvisible() ? "\<C-y>" : "\<C-l>"
inoremap <expr> <C-e> neocomplete#cancel_popup()

" invoke Hilighting Trace plugin
nnoremap <leader>ph :HLT<cr>

" git functionality
nmap <leader>gd :Gvdiff<CR>
nmap <leader>gw :Gwrite<CR>
" nmap <leader>gb :Gbrowse<CR>
nmap <leader>gc :Gcommit
nmap <leader>G :Git 

nmap <leader>gs <Plug>GitGutterStageHunk
nmap <leader>gr <Plug>GitGutterUndoHunk

" invoke commit log browser
nmap <leader>gl :GV<cr>
nmap <leader>gL :GV!<cr>

" invoke syntastic check
map <silent> <leader>ps :SyntasticCheck<cr>:call lightline#update()<cr>

" invoke EasyAlign
xmap <leader>pl <Plug>(EasyAlign)
nmap <leader>pl <Plug>(EasyAlign)

" invoke snippet editor
nmap <silent><leader>pu :UltiSnipsEdit<cr>
" snippet trigger
let g:UltiSnipsExpandTrigger = '<C-j>'
" forward in snippets
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
" backwards in snippets
let g:UltiSnipsJumpBackwardTrigger= '<C-k>'

" page through completion
" let g:SuperTabDefaultCompletionType = '<C-n>'

" quit
nnoremap <silent><leader>q :q<cr>
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
" noremap <leader>e  :tabnew $vimpath/temp/tempbuffer<cr>

"substitute word-under-cursor
nnoremap <leader>S :%s/\M\<<C-r><C-w>\>//gce<Left><Left><Left><Left>
xnoremap <leader>S y:%s/\M\<<C-r>"\>/gce<Left><Left><Left><Left>
"substitute word-under-cursor in argslist
nnoremap <leader>A :kX\|silent! argdo %s/\M<C-r><C-w>//g\|up\|norm!`X<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
xnoremap <leader>A y:kX\|silent! argdo %s/\M<C-r>"//g\|up\|norm!`X<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" substitute word in search register (/,?)
nnoremap <leader>s/ :%s/\<<C-r>/\>//gc<Left><Left><Left>
nnoremap <leader>s<s-space> :%s/\<<C-r>/\>//gc<Left><Left><Left>
" substitute word in search register (/,?) in arglist
nnoremap <leader>a/ :silent! argdo %s/\<<C-r>/\>//g\|up<Left><Left><Left><Left><Left>

"resize viewport
nnoremap <silent> <Right> :call utils#intelligentVerticalResize('right')<CR>
nnoremap <silent> <Left> :call utils#intelligentVerticalResize('left')<CR>
nnoremap <silent> <Up> :resize -5<CR>
nnoremap <silent> <Down> :resize +5<CR>

" source local stuff
" by /u/Wiggledan from /r/vim
xnoremap <silent> g: :<c-U>call utils#sourceVimscript("visual")<cr>
nnoremap <silent> g: :call utils#sourceVimscript("currentline")<cr>

" move a line of text using ALT+[jk] (TODO: credit, forgot who ...)
nnoremap <A-k> :let fdm_sav=&fdm\|:set fdm=manual\|:m-2<CR>:let &fdm=fdm_sav<CR>==
nnoremap <A-j> :let fdm_sav=&fdm\|:set fdm=manual\|:m+<CR>:let &fdm=fdm_sav<CR>==
xnoremap <A-k> :<C-U>let fdm_sav=&fdm\|:set fdm=manual\|:'<,'>m'<-2<CR>gv=:let &fdm=fdm_sav<CR>gv
xnoremap <A-j> :<C-U>let fdm_sav=&fdm\|:set fdm=manual\|:'<,'>m'>+<CR>gv=:let &fdm=fdm_sav<CR>gv

" invoke abolish
nnoremap <leader>pa :Abolish! 

" invoke beautifier from context
" autocmd FileType javascript nnoremap <buffer> <leader>pb :call JsBeautify()<cr>
" autocmd FileType json nnoremap <buffer> <leader>pb :call JsonBeautify()<cr>
" autocmd FileType jsx nnoremap <buffer> <leader>pb :call JsxBeautify()<cr>
" autocmd FileType html nnoremap <buffer> <leader>pb :call HtmlBeautify()<cr>
" autocmd FileType php nnoremap <buffer> <leader>pb :call HtmlBeautify()<cr>
" autocmd FileType css nnoremap <buffer> <leader>pb :call CSSBeautify()<cr>
" autocmd FileType scss nnoremap <buffer> <leader>pb :call CSSBeautify()<cr>
" autocmd FileType javascript xnoremap <buffer> <leader>pb :call RangeJsBeautify()<cr>
" autocmd FileType json xnoremap <buffer> <leader>pb :call RangeJsonBeautify()<cr>
" autocmd FileType jsx xnoremap <buffer><leader>pb :call RangeJsxBeautify()<cr>
" autocmd FileType html xnoremap <buffer> <leader>pb :call RangeHtmlBeautify()<cr>
" autocmd FileType php xnoremap <buffer> <leader>pb :call RangeHtmlBeautify()<cr>
" autocmd FileType css xnoremap <buffer><leader>pb :call RangeCSSBeautify()<cr>
" autocmd FileType scss xnoremap <buffer><leader>pb :call RangeCSSBeautify()<cr>

" fix last broken word
" imap <C-l> <Esc>[s1z=gi

" --- Toggle Options
" ------------------------------------------------------------------------------
" toggle numbers and relative numbers
nnoremap <silent><leader>tn :call utils#toggleRNU()<cr>

" toggle spellcheck
nnoremap <silent><leader>ts :setlocal spell!<cr>

" toggle rendered hex-colors
map <leader>tc <Plug>Colorizer

" toggle visual indentation marks
map <leader>ti :IndentLinesToggle<cr>

" toggle goyo
nmap <leader>tg :Goyo<cr>
nmap <leader>tl :Limelight!!<cr>

" --- Filetype Specific
" ------------------------------------------------------------------------------
nnoremap <leader>fp :tabe ~/tools/standards/ruleset.xml<cr>

" PLUGIN SETTINGS & MAPPINGS
" ##############################################################################

" Colorizer 
" ------------------------------------------------------------------------------
let g:colorizer_startup = 0

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

" delimitMate 
" ------------------------------------------------------------------------------
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
let delimitMate_smart_matchpairs = 1

" Emmet 
" ------------------------------------------------------------------------------
let g:user_emmet_install_global=0
autocmd FileType jade,html,php,css,scss EmmetInstall
let g:user_emmet_mode='a'

" Gitgutter 
" ------------------------------------------------------------------------------
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '_'
let g:gitgutter_sign_modified_removed = '*'
let g:gitgutter_override_sign_column_highlight = 1
let g:gitgutter_sign_column_always = 1
let g:gitgutter_diff_args = '--ignore-space-at-eol --ignore-all-space --ignore-blank-lines'
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 1
let g:gitgutter_async = 1

" Goyo 
" ------------------------------------------------------------------------------
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

" Limelight
" ------------------------------------------------------------------------------
" Default: 0.5
let g:limelight_default_coefficient = 0.8

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

" HiLink
" ------------------------------------------------------------------------------

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
    return fname == 'netrw' ? 'browser' :
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
      \ 'zeitwerk': 'sneak,exchange,abolish,increment'
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

" Neocomplete.vim
" ------------------------------------------------------------------------------
let g:neocomplete#data_directory = '~\vimfiles\tmp\neocomplete' " TODO: link to rtp
let g:neocomplete#enable_at_startup = 0
let g:neocomplete#enable_auto_select = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#auto_completion_start_length = 2
let g:neocomplete#sources#tags#cache_limit_size = 16777216 " 16MB
let g:neocomplete#enable_fuzzy_completion = 0
if !exists('g:neocomplete#same_filetypes')
  let g:neocomplete#same_filetypes = {}
endif
let g:neocomplete#same_filetypes._ = '_'
call neocomplete#util#set_default_dictionary(
      \'g:neocomplete#sources#omni#input_patterns',
      \'php',
      \'[^. \t]->\h\w*\|\h\w*::\w*')
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType php,html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" indentLine 
" ------------------------------------------------------------------------------
let g:indentLine_color_term = 236
" let g:indentLine_conceallevel = 2
let g:indentLine_enabled = 0
let g:indentLine_faster = 1
let g:indentLine_concealcursor = 'ic'

" Incsearch 
" ------------------------------------------------------------------------------
let g:incsearch#auto_nohlsearch = 1

" Plug 
" ------------------------------------------------------------------------------
let g:plug_timeout = 240

" ~~~ Startify 
" ------------------------------------------------------------------------------
" let g:startify_session_delete_buffers = 1
" let g:startify_files_number = 9
" let g:startify_change_to_dir = 1
" let g:startify_relative_path = 1
" let g:startify_use_env = 1
" let g:startify_enable_special = 0
" let g:startify_custom_indices = ['1', '2', '3', '4', '5', '6', '7', '8', '9', 'v', 'g', 't', 'd', 'D', 'r', 'R', 'l', 'L']
" if s:is_windows
"   let g:startify_bookmarks = [
"         \ $rtp,
"         \ '~/Google Drive/',
"         \ '~/temp'
"         \ ]
" endif
" let g:startify_update_oldfiles = 1
" let g:startify_session_autoload = 0
" let g:startify_session_persistence = 0
" if s:is_windows
"   let g:startify_skiplist = [
"         \ '\.vim',
"         \ '\.log',
"         \ 'plugged\.*\doc',
"         \ 'COMMIT_EDITMSG'
"         \ ]
" endif
" let g:startify_list_order = [
"       \ ['    LRU:'],
"       \ 'files',
"       \ ['    Bookmarks:'],
"       \ 'bookmarks',
"       \ ['    Sessions:'],
"       \ 'sessions',
"       \ ]
" let g:startify_custom_header = g:utils#centerLines([
"       \ '                               ',
"       \ '   __      __ _____  __  __    ',
"       \ '   \ \    / /|_   _||  \/  |   ',
"       \ '    \ \  / /   | |  | \  / |   ',
"       \ '     \ \/ /    | |  | |\/| |   ',
"       \ '      \  /    _| |_ | |  | |   ',
"       \ '       \/    |_____||_|  |_|   ',
"       \ ])
" augroup Startify
"   au!
"   au User Startified file Startify
"   au User Startified setlocal buftype=
"   au User Startified setlocal nowrap
"   au User Startified setlocal nonu norln
"   au User Startified setlocal colorcolumn=
" augroup END

" nnoremap <leader>sd :SSave default<CR>y<CR>
" nnoremap <leader>sD :SLoad default<CR>

" Syntastic 
" ------------------------------------------------------------------------------
let g:syntastic_auto_loc_list = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_jump = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_cursor_column = 0
" let g:syntastic_stl_format = "%E{[E]%fe} %W{[W]%fw}"
let g:syntastic_enable_signs = 1
let g:syntastic_full_redraws = 1
let g:syntastic_error_symbol = "E"
let g:syntastic_style_error_symbol = "e"
let g:syntastic_warning_symbol = "W"
let g:syntastic_style_warning_symbol = "w"
let g:syntastic_mode_map = {
      \ "mode": "passive",
      \ "active_filetypes": [],
      \ "passive_filetypes": [] }
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_HTML_checkers = ['jshint']
" let g:syntastic_SCSS_checkers = ['scss_lint']
" let g:syntastic_CSS_checkers = ['scss_lint']
let g:syntastic_pug_checkers = ['pug-lint']
let g:syntastic_php_checkers = ['php', 'phpcs']
let g:syntastic_enable_highlighting = 0

" sneak
" ------------------------------------------------------------------------------
let g:sneak#streak = 1
let g:sneak#textobject_z = 0
let g:sneak#use_ic_scs = 1

" ~~~ Text-Obj-Fold 
" ------------------------------------------------------------------------------
" let g:textobj_fold_no_default_key_mappings = 1


" Supertab
" ------------------------------------------------------------------------------
" let g:SuperTabDefaultCompletionType = 'context'
" let g:SuperTabDefaultCompletionType = <C-p>

" UltiSnips 
" ------------------------------------------------------------------------------
let g:UltiSnipsEditSplit = 'context'

" ~~~ YouCompleteMe 
" ------------------------------------------------------------------------------
" set omnifunc=syntaxcomplete#Complete
" let g:ycm_auto_trigger = 1
" let g:ycm_complete_in_comments = 1
" let g:ycm_complete_in_strings = 1
" let g:ycm_seed_identifiers_with_syntax = 1
" let g:ycm_filetype_blacklist = {
"       \ 'tagbar' : 1,
"       \ 'qf' : 1,
"       \ 'notes' : 1,
"       \ 'markdown' : 1,
"       \ 'unite' : 1,
"       \ 'text' : 1,
"       \ 'vimwiki' : 1,
"       \ 'pandoc' : 1,
"       \ 'infolog' : 1,
"       \ 'mail' : 1
"       \}
" if exists('youcompleteme#Enable()')
"   augroup load_us_ycm
"     autocmd!
"     autocmd InsertEnter * call plug#load('YouCompleteMe')
"           \| call you complete me#Enable() | AutoCAD! Load_us_cm
"   au group END
" end if
