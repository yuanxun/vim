" ------------------------------------------------------------------------------
" --- Zeitwerk vimrc
" ------------------------------------------------------------------------------
"  TODO fix autocomplete
"  STARTUP {{{
" ##############################################################################
" check for compatible mode and stomp it
if &compatible
    set nocompatible
endif
" reset autocommands
if has ('vim_starting')
    au!
endif
" variable to check if is windows version of vim
let s:is_windows = has('win32') || has('win64')
if s:is_windows
    set shell=cmd.exe
    let $rtp = fnamemodify(resolve($HOME).'\vimfiles', ':p:gs?/?\\?')
    let $rc = resolve($rtp).'rc\'
else " linux or mac
    let $rtp = fnamemodify(resolve($HOME.'/.vim'), ':p')
    let $rc = resolve($rtp).'/rc'
endif
" ##############################################################################
" END STARTUP }}}
" PLUGINS {{{
" ##############################################################################
" Pre-plugin {{{
" ------------------------------------------------------------------------------
set runtimepath+=$rtp
call plug#begin($rtp.'plugged')
" }}}
" Plugin list {{{
" ------------------------------------------------------------------------------
" PLUGINS MARKED WITH TODO ARE NEW TO ME AND NOT YET FULLY EXPLORED
" ------------------------------------------------------------------------------
" --- Inhouse!
" ------------------------------------------------------------------------------
" ------------------------------------------------------------------------------
" --- Colorscheme
" ------------------------------------------------------------------------------
Plug 'chriskempson/base16-vim'             " base16 vim port
Plug 'docapotamus/jellybeans.vim'          " jellybeans
" ------------------------------------------------------------------------------
" --- Interface / File management
" ------------------------------------------------------------------------------
Plug 'scrooloose/nerdtree',                " file browser
            \ { 'on' : ['NERDTreeFind', 'NERDTreeToggle'] }
Plug 'itchyny/lightline.vim'               " simple statusline
Plug 'mhinz/vim-startify'                  " startup screen
Plug 'ctrlpvim/ctrlp.vim',                 " complex fuzzy-finder (buffer, file, mru)
            \ { 'on', ['CtrlP', 'CtrlPMRU', 'CtrlPBuffer', 'CtrlPLine'] }
Plug 'Shougo/unite.vim'                    " creates _uniting_ interfaces
Plug 'Shougo/neoyank.vim'                  " yank buffer
Plug 'junegunn/goyo.vim'                   " removes UI elements for distraction free editing
Plug 'vim-scripts/Tabmerge'                " merge tabs
if s:is_windows
    Plug 'kkoenig/wimproved.vim',          " Windows specific fullscreen mode
endif
" ------------------------------------------------------------------------------
" --- Filetype
" ------------------------------------------------------------------------------
" Plug 'sheerun/vim-polyglot'              " multi lang
Plug 'JulesWang/css.vim'                   " css (vim runtime)
Plug 'hail2u/vim-css3-syntax'              " css3
Plug 'cakebaker/scss-syntax.vim'           " sass
Plug 'pangloss/vim-javascript'             " javascript
Plug 'othree/html5.vim'                    " html5
" ------------------------------------------------------------------------------
" --- Syntax formatting
" ------------------------------------------------------------------------------
Plug 'maksimr/vim-jsbeautify'              " js-beautify integration
" ------------------------------------------------------------------------------
" --- Syntax
" ------------------------------------------------------------------------------
Plug 'scrooloose/syntastic',               " syntax integration (requires external tools)
            \ { 'for' : ['scss','html','javascript','css'] }
" ------------------------------------------------------------------------------
" --- Autocompletion
" ------------------------------------------------------------------------------
Plug 'ervandew/supertab'                   " insert completion TODO
" Plug 'Shougo/neocomplete.vim'              " completion engine
Plug 'cohama/lexima.vim',                  " auto close parentheses TODO
            \ { 'for' : ['hmtl','css','scss','javascript'] }
" Plug 'Valloric/YouCompleteMe',             " completion engine, requires compilation
"             \ { 'do' : function('g:utils#buildYCM'), } 
" ------------------------------------------------------------------------------
" --- Git
" ------------------------------------------------------------------------------
" Plug 'airblade/vim-gitgutter' " adds diff status column
Plug 'tpope/vim-fugitive'                  " git wrapper TODO
Plug 'junegunn/gv.vim',                    " git commit browser TODO
            \ { 'on' : 'GV' }
" ------------------------------------------------------------------------------
" --- Language agnostic utility
" ------------------------------------------------------------------------------
Plug 'sirver/ultisnips'                    " snippet integration
            \ | Plug 'honza/vim-snippets'  " snippets
Plug 'tpope/vim-commentary'                " fileType specific comment creation mappings
Plug 'junegunn/vim-easy-align'             " text align
Plug 'lilydjwg/colorizer'                  " hex, rgb and named color highlighting
" ------------------------------------------------------------------------------
" --- Language specific utility
" ------------------------------------------------------------------------------
Plug 'mattn/emmet-vim',                    " emmet integration TODO
            \ { 'for' : ['html', 'xml', 'xhtml', 'php'] }
" ------------------------------------------------------------------------------
" --- Vanilla improvements
" ------------------------------------------------------------------------------
Plug 'thinca/vim-visualstar'               " improves * and #
Plug 'Konfekt/FastFold'                    " improves Folds TODO
Plug 'tpope/vim-speeddating'               " improves number in-/decementation (C-X/C-A)
Plug 'tpope/vim-repeat'                    " makes lots of commands repeatable with .
Plug 'tpope/vim-abolish'                   " improves abbrev functionality
Plug 'mhinz/vim-sayonara',                 " essentially :qw
            \ { 'on' : 'Sayonara' }
Plug 'amix/open_file_under_cursor.vim'     " read its name ...
Plug 'terryma/vim-expand-region'           " expands visual selection TODO
Plug 'edsono/vim-matchit'                  " improves % behaviour
Plug 'unblevable/quick-scope'              " visual help with left and right motions
Plug 'mbbill/undotree',                    " visualizes vims undotree TODO
            \ { 'on' : 'UndotreeToggle' }
Plug 'haya14busa/incsearch.vim'            " improve incsearch
Plug 'haya14busa/incsearch-fuzzy.vim'      " fuzzy-incsearch
" Plug 'vim-scripts/YankRing.vim'        " easier yank / put register management
" ------------------------------------------------------------------------------
" --- Additional text-object funtionality
" ------------------------------------------------------------------------------
Plug 'tpope/vim-surround'                  " surround text-objects
Plug 'wellle/targets.vim'                  " more objects
Plug 'kana/vim-textobj-user'               " new custom textobjects
Plug 'glts/vim-textobj-comment'            " adds comments as textobject
Plug 'kana/vim-textobj-fold'               " adds folds as textobjects
Plug 'kana/vim-textobj-indent'             " adds indents as textobjects

" }}}
" Post-plugin {{{
" ------------------------------------------------------------------------------
call plug#end()
filetype plugin indent on
" }}}
" ##############################################################################
" END PLUGINS }}}
" SETTINGS {{{
" ##############################################################################
" get patched fonts for powerline at github.com/powerline/fonts
if s:is_windows
    set guifont=Consolas:h10:cANSI " Font fallback
    try
        set guifont=Fira_Mono:h10:cANSI
        let s:patchedFont = 0               " is the font powerline patched?
    catch
    endtry
else
    set guifont=Monospace\ 10 " Font fallback
    try
        set guifont==Fira\ Mono\ Medium\ 10
        let s:patchedFont = 0               " is the font powerline patched?
    catch
    endtry
endif
if has("gui_running")                   " gui specific options
    set guioptions-=m " disable the menu
    set guioptions-=t " disable tear-off menus
    set guioptions-=T " disable toolbar
    set guioptions-=r " disable righthand scrollbar
    set guioptions-=L " disable lefthand scrollbar
    set guitablabel=%M\ %t              " tab title
endif
set encoding=utf-8                      " vim encoding
scriptencoding utf-8                    " script encoding
set termencoding=utf-8                  " terminal encoding
set fileencoding=utf-8                  " file encoding
set fileencodings=ucs-bom,utf8,prc      " encoding
set langmenu=en helplang=en             " set menu and help language
set modelines=1 noshowmode              " allows filespefic vim options
set virtualedit=block                   " allows blockwise visualmode over EOL
set wrapscan                            " search wraps around at EOF
set nojoinspaces                        " remove spaces when joining lines
set shortmess=atI                       " shortens some hit-enter prompts
set ffs=unix,dos                        " default fileformats
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
set hlsearch                          " disable search highlighting
set incsearch                           " incremental search
set showmatch                           " jumps to a matching bracket
set lazyredraw                          " avoids unnessesarily redraws
set magic                               " regex magic
set mat=2                               " time in s/10 of blinking match
set noerrorbells novisualbell t_vb=     " disable audible and visual notice
set ttimeout                            " set tm=500
set timeoutlen=1000                     " timeout length
set ttimeoutlen=1000                    " mapping timeout
set foldmethod=marker " use markers for folding
set foldlevel=0                         " depth of autoopening folds
try
    set switchbuf=useopen,usetab,newtab " rules for new buffers
catch
endtry
set t_Co=256                            " terminal number of colors
set background=dark                     " use dark colorscheme
colorscheme desert                      " colorscheme fallback
try
    colorscheme jellybeans
    " colorscheme base16-monokai          " set colorscheme
catch
endtry
let base16colorspace = 256              " terminal fix
set showtabline=2                       " show tabline with > 1 tabs

set number relativenumber               " enable number gutter
:au WinEnter * :setlocal relativenumber
:au WinLeave * :setlocal norelativenumber
set numberwidth=3                       " width of numbergutter
set so=5                                " lines at which vim starts scrolling
set wildmenu                            " enhance commandline-completion
set laststatus=2                        " always show statusline
if s:is_windows                         " files to ignore
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store 
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif
set cmdheight=1                         " height of commandline in lines
set expandtab                           " converts <tab> to spaces
set shiftwidth=4                        " number of spaces converted to <tab>
set tabstop=4                           " number of spaces that count as <tab>
set smarttab                            " improves vims treatment of <tab>s
set linebreak                           " soft breaks lines according to breakat
set breakat=80                          " sets softwrap
set textwidth=500                       " maximum amount of text til EOL
set autoindent smartindent              " Auto indention
" ##############################################################################
" END SETTINGS }}}
" SOURCE {{{
" ##############################################################################
" --- utility functions
" ------------------------------------------------------------------------------
source $rc/utils.vim
" ------------------------------------------------------------------------------
" --- Sorts folded text without hickups
" ------------------------------------------------------------------------------
source $rc/sortUnfolded.vim
" ------------------------------------------------------------------------------
" --- Collection of abbreviations
" ------------------------------------------------------------------------------
source $rc/abbreviations.vim

" ##############################################################################
" END SOURCE }}}
" SYNTAX & HIGHLIGHTING {{{
" ##############################################################################
let s:colorAA = "#181818"
" base16 {{{
" ------------------------------------------------------------------------------
if g:colors_name == 'base16-monokai'
    let s:color00 = "#272822"
    let s:color01 = "#383830"
    let s:color02 = "#49483e"
    let s:color03 = "#75715e"
    let s:color04 = "#a59f85"
    let s:color05 = "#f8f8f2"
    let s:color06 = "#f5f4f1"
    let s:color07 = "#f9f8f5"
    let s:color08 = "#f92672"
    let s:color09 = "#fd971f"
    let s:color0A = "#f4bf75"
    let s:color0B = "#a6e22e"
    let s:color0C = "#a1efe4"
    let s:color0D = "#66d9ef"
    let s:color0E = "#ae81ff"
    let s:color0F = "#cc6633"
endif
if g:colors_name == 'base16-tomorrow'
    let s:color00 = "#1d1f21"
    let s:color0A = "#f0c674"
    let s:color0C = "#202020"
endif
if g:colors_name == 'base16-tomorrow' || g:colors_name == 'base16-monokai'
    " Folds
    exe 'highlight Folded guibg = '.s:color00
    exe 'highlight Folded guifg = '.s:color04
    exe 'highlight FoldColumn guibg = '.s:colorAA
    " GUI
    exe 'highlight Todo gui = bold'
    exe 'highlight Todo guifg = '.s:color07
    exe 'highlight Todo guibg = '.s:colorAA
    exe 'highlight CursorLineNr guibg = '.s:colorAA
    exe 'highlight CursorLineNr guifg = '.s:color04
    exe 'highlight Normal guibg = '.s:colorAA
    exe 'highlight LineNr guibg = '.s:colorAA
    exe 'highlight SignColumn guibg = '.s:colorAA
    " Gitgutter
    exe 'highlight GitGutterAdd guibg = '.s:colorAA
    exe 'highlight GitGutterChange guibg = '.s:colorAA
    exe 'highlight GitGutterDelete guibg = '.s:colorAA
    exe 'highlight GitGutterChangeDelete guibg = '.s:colorAA
    " CSS
    " exe 'highlight VendorPrefix guifg = '.s:color0A
    exe 'highlight Number guifg = '.s:color0B
    exe 'highlight cssUnitDecorators guifg = '.s:color0E
endif
" }}}
" Jellybeans {{{
" ------------------------------------------------------------------------------
let g:jellybeans_overrides = {
            \ 'background' : { 'guibg' : '101010' },
            \}
" }}}
" CSS3 Fixes {{{
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
" }}}
" ------------------------------------------------------------------------------
" --- Remove vertical split column
" ------------------------------------------------------------------------------
hi VertSplit guibg = NONE

" ##############################################################################
" END SYNTAX & HIGHLIGHTING }}}
" MAPPINGS {{{
" ##############################################################################
" ------------------------------------------------------------------------------
" --- Choose Leader
" ------------------------------------------------------------------------------
let mapleader   = "\<Space>"
let g:mapleader = "\<Space>"
" Unmap {{{
" ------------------------------------------------------------------------------
map K         <Nop>
map <M-Right> <Nop>
map <M-Left>  <Nop>
map <M-Down>  <Nop>
map <M-Up>    <Nop>
" }}}
" Default remap {{{
" ------------------------------------------------------------------------------
"  default <C-c> breaks stuff
inoremap <C-c> <esc>
xnoremap <C-c> <esc>
" Keep the cursor in place while joining lines
nnoremap J mzJ`z
" Don't yank to default register when changing something
nnoremap c "xc
xnoremap c "xc
" go to end of inserted text after yank and put
xnoremap <silent> y y`]
xnoremap <silent> p p`]
nnoremap <silent> p p`]
" Yank until end of line with <S-y> as expected
nnoremap Y y$
" smart way to move between windows
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
" goto start of fold
noremap gk [z
noremap gj ]z
" treat long lines as break lines
noremap  j g<down>
noremap  k g<up>
" center screen after next & prev search
nnoremap n nzz
nnoremap N Nzz
xnoremap n nzz
xnoremap N Nzz
" don't cancel selection after indenting in visual
xnoremap < <gv
xnoremap > >gv
" center screen when moving screenwise
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz
xnoremap <C-u> <C-u>zz
xnoremap <C-d> <C-d>zz
xnoremap <C-f> <C-f>zz
xnoremap <C-b> <C-b>zz
" delete with Ctrl-D in insertmode
inoremap <C-D>       <backspace>
" lower- and uppercase under cursor in normalmode
" nnoremap gu  vgu
" nnoremap gU  vgU
nnoremap gwu viwgu
nnoremap gwU viwgU
" }}}
" Custom {{{
" ------------------------------------------------------------------------------
" Join upwards
nnoremap K kJ
" start makro with alt-q instead of @
noremap Q @q
" searchmode with shift-space
noremap <S-space> /
" Jump to mark {a-zA-Z}
nnoremap ä '
nnoremap Ä `
" treat jk as <esc> in insertmode and commandmode
noremap! jk <esc>
" fold with ö instead of z 
xnoremap öf mzzf`zzz
noremap öF zF
noremap öo zo
noremap öd zd
noremap öD zD
noremap öC zC
noremap öc zc
noremap öa za
noremap öA zA
noremap öA zA
noremap öM zM
noremap öm zm
noremap öR zR
"resize viewport
nnoremap <silent> <Right> :call g:utils#IntelligentVerticalResize('right')<CR>
nnoremap <silent> <Left> :call g:utils#IntelligentVerticalResize('left')<CR>
nnoremap <silent> <Up> :resize -5<CR>
nnoremap <silent> <Down> :resize +5<CR>
" source local stuff
xmap <silent> g: :<c-U>call SourceVimscript("visual")<cr>
nmap <silent> g: :call SourceVimscript("currentline")<cr>
" move a line of text using ALT+[jk] (TODO: credit, forgot who ...)
nmap <A-k> :let fdm_sav=&fdm\|:set fdm=manual\|:m-2<CR>:let &fdm=fdm_sav<CR>==
nmap <A-j> :let fdm_sav=&fdm\|:set fdm=manual\|:m+<CR>:let &fdm=fdm_sav<CR>==
xmap <A-k> :<C-U>let fdm_sav=&fdm\|:set fdm=manual\|:'<,'>m'<-2<CR>gv=:let &fdm=fdm_sav<CR>gv
xmap <A-j> :<C-U>let fdm_sav=&fdm\|:set fdm=manual\|:'<,'>m'>+<CR>gv=:let &fdm=fdm_sav<CR>gv
" quick fold toggeling
nnoremap <tab> za
" mappings for trailing spaces function
nmap <F12> :ShowSpaces 1<CR>
nmap <S-F12> m`:TrimSpaces<CR>``
xmap <S-F12> :TrimSpaces<CR>
" newlines without insertmode
map <A-o> o<ESC>
map <A-S-o> <S-o><ESC>
" highlight last inserted text
nnoremap gV                 `[v`]
" %% refers to directory of current file
cnoremap %% <C-R>=expand('%:h').'/'<C-R>
" Start substitute on current word under the cursor
" nnoremap ,s :%s///gc<Left><Left><Left> TODO
" manage tabs
noremap  <silent><leader>tn :tabnew<cr>
noremap  <silent><leader>to :tabonly<cr>
noremap  <silent><leader>tl :tabnext<cr>
noremap  <silent><leader>th :tabprevious<cr>
noremap  <silent><leader>tj :tabfirst<cr>
noremap  <silent><leader>tk :tablast<cr>

noremap  <silent><leader>t<S-h> :tabmove -<CR>
noremap  <silent><leader>t<S-l> :tabmove +<CR>
noremap  <silent><leader>t<S-j> :tabmove 0<CR>
noremap  <silent><leader>t<S-k> :tabmove $<CR>
" Switch CWD to the directory of the open buffer
noremap  <leader>cd :cd %:p:h<cr>:pwd<cr>
" quickly write
nnoremap <leader>w  :update<CR>
nnoremap <leader>W  :update!<CR>
" Quickly open a buffer for scribble
noremap  <leader>e  :tabnew $vimpath/temp/tempbuffer<cr>
" toggle numbers and relative numbers
nmap <silent><leader>n  :call utils#toggleRNU()<cr>
" edit and source vimrc
nnoremap <silent><leader>ve :cd $rtp<cr>:tabnew $MYVIMRC<CR>
nnoremap <silent><leader>vs :source $MYVIMRC<CR>
" disable highlight when <leader><cr> is pressed
noremap  <silent> <leader><cr> :let @/ = ""<cr>
" save current session & close all buffers
nnoremap <silent><leader>Q :SSave last<CR>y<CR>:wqa<CR>
" }}}
" ##############################################################################
" END MAPPINGS }}}
" PLUGIN SETTINGS & MAPPINGS{{{
" ##############################################################################
" Colorizer {{{
" ------------------------------------------------------------------------------
let g:colorizer_startup = 0
nmap <leader>pc <Plug>Colorizer
"  }}}
" Commentary {{{
" ------------------------------------------------------------------------------
nmap gC <Plug>CommentaryLine
" }}}
" CtrlP"{{{
" ------------------------------------------------------------------------------
let g:ctrlp_reuse_window = 'startify'
let g:ctrlp_max_depth = 15
let g:ctrlp_max_height = 20
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']

map <leader>f :CtrlP<cr>
map <leader>b :CtrlPBuffer<cr>
map <leader>m :CtrlPMRU<cr>
"}}}
" Easyalign {{{
" ------------------------------------------------------------------------------
xmap gl <Plug>(EasyAlign)
nmap gl <Plug>(EasyAlign)
" }}}
" Emmet {{{
" ------------------------------------------------------------------------------
let g:user_emmet_mode='a'
let g:user_emmet_leader_key='<C-m>'
" }}}
" Expandregion {{{
" ------------------------------------------------------------------------------
xmap v <Plug>(expand_region_expand)
xmap <C-v> <Plug>(expand_region_shrink)

" }}}
" Fugitive {{{
" ------------------------------------------------------------------------------
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit --verbose<CR>
nnoremap <leader>gc :Gcommit --verbose<CR>
nnoremap <leader>gd :Gvdiff<CR>

" }}}
" ~~~ Gitgutter {{{
" ------------------------------------------------------------------------------
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_column_always = 0
"  }}}
" Goyo {{{
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

nnoremap <silent>           <leader>pz :Goyo<CR>
"  }}}
" GV {{{
" ------------------------------------------------------------------------------
nmap <leader>gv :GV<cr>
nmap <leader>gG :GV!<cr>
" }}}
" Js-Beautify {{{
" ------------------------------------------------------------------------------
autocmd  FileType javascript nnoremap <buffer> <leader>pb :call JsBeautify()<cr>
autocmd  FileType json nnoremap <buffer>       <leader>pb :call JsonBeautify()<cr>
autocmd  FileType jsx nnoremap <buffer>        <leader>pb :call JsxBeautify()<cr>
autocmd  FileType html nnoremap <buffer>       <leader>pb :call HtmlBeautify()<cr>
autocmd  FileType css nnoremap <buffer>        <leader>pb :call CSSBeautify()<cr>
autocmd  FileType javascript xnoremap <buffer> <leader>pb :call RangeJsBeautify()<cr>
autocmd  FileType json xnoremap <buffer>       <leader>pb :call RangeJsonBeautify()<cr>
autocmd  FileType jsx xnoremap <buffer>        <leader>pb :call RangeJsxBeautify()<cr>
autocmd  FileType html xnoremap <buffer>       <leader>pb :call RangeHtmlBeautify()<cr>
autocmd  FileType css xnoremap <buffer>        <leader>pb :call RangeCSSBeautify()<cr>

" }}}
" Lexima {{{
" ------------------------------------------------------------------------------
let g:lexima_enable_newline_rules = 1
let g:lexima_enable_endwise_rules = 1
" }}}
" Lightline {{{
" ------------------------------------------------------------------------------
if s:patchedFont == 1
    let g:lightline = {
                \ 'colorscheme' : 'jellybeans',
                \ 'active': {
                \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
                \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
                \ },
                \ 'component_function': {
                \   'fugitive': 'LightLineFugitive',
                \   'readonly': 'LightLineReadonly',
                \   'modified': 'LightLineModified',
                \   'filename': 'LightLineFilename',
                \   'fileformat': 'LightLineFileformat',
                \   'filetype': 'LightLineFiletype',
                \   'fileencoding': 'LightLineFileencoding',
                \   'mode': 'LightLineMode',
                \   'ctrlpmark': 'CtrlPMark',
                \ },
                \ 'component_expand': {
                \   'syntastic': 'SyntasticStatuslineFlag',
                \ },
                \ 'component_type': {
                \   'syntastic': 'error',
                \ },
                \ 'separator': { 'left': '', 'right': '' },
                \ 'subseparator': { 'left': '', 'right': '' }
                \ }
else
    let g:lightline = {
                \ 'colorscheme' : 'jellybeans',
                \ 'active': {
                \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
                \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
                \ },
                \ 'component_function': {
                \   'fugitive': 'LightLineFugitive',
                \   'readonly': 'LightLineReadonly',
                \   'modified': 'LightLineModified',
                \   'filename': 'LightLineFilename',
                \   'fileformat': 'LightLineFileformat',
                \   'filetype': 'LightLineFiletype',
                \   'fileencoding': 'LightLineFileencoding',
                \   'mode': 'LightLineMode',
                \   'ctrlpmark': 'CtrlPMark',
                \ },
                \ 'component_expand': {
                \   'syntastic': 'SyntasticStatuslineFlag',
                \ },
                \ 'component_type': {
                \   'syntastic': 'error',
                \ },
                \ 'subseparator': { 'left': '>', 'right': '<' }
                \ }
endif
function! LightLineModified()
    if &filetype == "help"
        return ""
    elseif &modified
        return "+"
    elseif &modifiable
        return ""
    else
        return ""
    endif
endfunction
if s:patchedFont == 1
    function! LightLineReadonly()
        if &filetype == "help"
            return ""
        elseif &readonly
            return ""
        else
            return ""
        endif
    endfunction
    function! LightLineFugitive()
        if exists("*fugitive#head")
            let _ = fugitive#head()
            return strlen(_) ? ' '._ : ''
        endif
        return ''
    endfunction
else
    function! LightLineReadonly()
        if &filetype == "help"
            return ""
        elseif &readonly
            return "⌧"
        else
            return ""
        endif
    endfunction
    function! LightLineFugitive()
        if exists("*fugitive#head")
            let _ = fugitive#head()
            return strlen(_) ? '∫ '._ : ''
        endif
        return ''
    endfunction
endif

function! LightLineFilename()
    let fname = expand('%:t')
    return fname == 'ControlP' ? g:lightline.ctrlp_item :
                \ fname =~ 'NERD_tree' ? '' :
                \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
                \ ('' != fname ? fname : '[No Name]') .
                \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction
function! LightLineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction
function! LightLineMode()
    let fname = expand('%:t')
    return fname == 'ControlP' ? 'CtrlP' :
                \ fname =~ 'NERD_tree' ? 'NERDTree' :
                \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
function! CtrlPMark()
    if expand('%:t') =~ 'ControlP'
        call lightline#link('iR'[g:lightline.ctrlp_regex])
        return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
                    \ , g:lightline.ctrlp_next], 0)
    else
        return ''
    endif
endfunction

let g:ctrlp_status_func = {
            \ 'main': 'CtrlPStatusFunc_1',
            \ 'prog': 'CtrlPStatusFunc_2',
            \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
    let g:lightline.ctrlp_regex = a:regex
    let g:lightline.ctrlp_prev = a:prev
    let g:lightline.ctrlp_item = a:item
    let g:lightline.ctrlp_next = a:next
    return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
    return lightline#statusline(0)
endfunction
augroup AutoSyntastic
    autocmd!
    autocmd BufWritePost *.scss,*.css call s:syntastic()
augroup END
function! s:syntastic()
    SyntasticCheck
    call lightline#update()
endfunction
" end Lightline
"}}}
" Incsearch {{{
" ------------------------------------------------------------------------------
let g:incsearch#auto_nohlsearch = 1
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n <Plug>(incsearch-nohl-n)
map N <Plug>(incsearch-nohl-N)
map * <Plug>(incsearch-nohl-*)
map # <Plug>(incsearch-nohl-#)
map <leader>/ <Plug>(incsearch-fuzzy-/)
map <leader>? <Plug>(incsearch-fuzzy-?)
" }}}
" NERDTree {{{
" ------------------------------------------------------------------------------
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeAutoCenter = 1
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeBookmarksFile = $rtp.'temp/.NERDTreeBookmarks'
let g:NERDTreeMinimalUI = 0
let g:NERDTreeWinPos = "left"
let g:NERDTreeShowHidden = 1
" let g:NERDTreeSortHiddenFirst = 1 " breaks on windows for some reason
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeWinSize = 35

noremap  <leader>nn         :NERDTreeToggle<cr>
noremap  <leader>nh         :NERDTreeToggle ~/<cr>
noremap  <silent>           <leader>nf :NERDTreeFind<cr>cd
nnoremap <leader>nb         :Bookmark<space>

let NERDTreeMapOpenVSplit='v'
"}}}
" ~~~ Neocomplete {{{
" ------------------------------------------------------------------------------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

if !empty(glob("plugged/neocomplete"))
    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
        " For no inserting <CR> key.
        "return pumvisible() ? "\<C-y>" : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
endif
" }}}
" Plug {{{
" ------------------------------------------------------------------------------
let g:plug_timeout = 240
" }}}
" QuickScope {{{
" ------------------------------------------------------------------------------
let g:qs_highlight_on_keys=['f', 'F', 't', 'T']

nnoremap <leader>pq :QuickScopeToggle<CR>
"  }}}
" Sayonara {{{
" ------------------------------------------------------------------------------
nnoremap <leader>q          :Sayonara<CR>
" }}}
" Startify {{{
" ------------------------------------------------------------------------------
let g:startify_session_delete_buffers = 1
let g:startify_files_number = 7
let g:startify_change_to_dir = 1
let g:startify_relative_path = 1
let g:startify_use_env = 1
let g:startify_enable_special = 0
let g:startify_custom_indices = ['1', '2', '3', '4', '5', '6', '7', 'r', 'g', 't', 'd', 'l']
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
                \ '\.txt',
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
            \ '                                                                               ',
            \ '    ______      _  _ __          __          _     __      __ _____  __  __    ',
            \ '   |___  /     (_)| |\ \        / /         | |    \ \    / /|_   _||  \/  |   ',
            \ '      / /  ___  _ | |_\ \  /\  / /___  _ __ | | __  \ \  / /   | |  | \  / |   ',
            \ '     / /  / _ \| || __|\ \/  \/ // _ \|  __|| |/ /   \ \/ /    | |  | |\/| |   ',
            \ '    / /__|  __/| || |_  \  /\  /|  __/| |   |   <     \  /    _| |_ | |  | |   ',
            \ '   /_____|\___||_| \__|  \/  \/  \___||_|   |_|\_\     \/    |_____||_|  |_|   ',
            \ ])
let g:startify_custom_footer = g:utils#centerLines([
            \ '         __   __  _        _                            _ ',
            \ '        / _| / _|(_)      (_)                          | |',
            \ '   ___ | |_ | |_  _   ___  _   ___  _ __    ___  _   _ | |',
            \ '  / _ \|  _||  _|| | / __|| | / _ \|  _ \  / __|| | | || |',
            \ ' |  __/| |  | |  | || (__ | ||  __/| | | || (__ | |_| ||_|',
            \ '  \___||_|  |_|  |_| \___||_| \___||_| |_| \___| \__, |(_)',
            \ '                                                  __/ |   ',
            \ '                                                 |___/    ',
            \ ])


augroup Startify
    au!
    au User Startified file Startify
    au User Startified setlocal buftype=
    au User Startified setlocal nowrap
augroup END

nnoremap <leader>sm :SSave default<CR>y<CR>
nnoremap <leader>sl :SLoad default<CR>
"  }}}
" Surround {{{
" ------------------------------------------------------------------------------
nmap ms  ys
nmap mS  ysiW
nmap mss yss
nmap mSS ySS
" }}}
" Supertab {{{
" ------------------------------------------------------------------------------
let g:SuperTabDefaultCompletionType = '<C-n>'
" }}}
" Syntastic {{{
" ------------------------------------------------------------------------------
let g:syntastic_loc_list_height = 2
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_HTML_checkers = ['jshint']
" let g:syntastic_CSS_checkers = ['']
let g:syntastic_BEMHTML_checkers = ['bemhtmllint']
let g:syntastic_SASS_checkers = ['sass']
let g:syntastic_SCSS_checkers = ['sass']
"}}}
" Tabmerge {{{
" ------------------------------------------------------------------------------
noremap  <silent><leader>tm     :Tabmerge<CR>
noremap  <silent><leader>t<C-h> :Tabmerge left<CR>
noremap  <silent><leader>t<C-l> :Tabmerge right<CR>
" }}}
" Text-Obj-Fold {{{
" ------------------------------------------------------------------------------
let g:textobj_fold_no_default_key_mappings = 1

xmap aö <Plug>(textobj-fold-a)
xmap iö <Plug>(textobj-fold-i)
" }}}
" UltiSnips {{{
" ------------------------------------------------------------------------------
" if !empty(glob('plugged/UltiSnips'))
"     function! UltiSnips_Complete()
"         call UltiSnips#ExpandSnippet()
"         if g:ulti_expand_res == 0
"             if pumvisible()
"                 return '\<C-n>'
"             else
"                 call UltiSnips#JumpForwards()
"                 if g:ulti_jump_forwards_res == 0
"                     return '\<TAB>'
"                 endif
"             endif
"         endif
"         return ''
"     endfunction
"     function! g:UltiSnips_Reverse()
"         call UltiSnips#JumpBackwards()
"         if g:ulti_jump_backwards_res == 0
"             return '\<C-P>'
"         endif
"         return ''
"     endfunction
" endif

let g:UltiSnipsEditSplit = 'context'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

nmap <silent><leader>ps :UltiSnipsEdit<cr>
"
" au InsertEnter * exec 'inoremap <buffer> <silent> ' . g:UltiSnipsExpandTrigger     . ' <C-R>=g:UltiSnips_Complete()<cr>'
" au InsertEnter * exec 'inoremap <buffer> <silent> ' .     g:UltiSnipsJumpBackwardTrigger . ' <C-R>=g:UltiSnips_Reverse()<cr>'
"  }}}
" Undotree {{{
" ------------------------------------------------------------------------------
" TODO change mapping
nnoremap <leader>pu :UndotreeToggle<cr>

" }}}
" Unite {{{
" ------------------------------------------------------------------------------
if executable('ag')
  let g:unite_source_grep_command='ag'
  let g:unite_source_grep_default_opts='--nocolor --line-numbers --nogroup -S -C0'
  let g:unite_source_grep_recursive_opt=''
  let g:unite_source_rec_async_command = ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']
endif
let g:unite_source_menu_menus = {}
" Plug menu
let g:unite_source_menu_menus.plug = {
      \     'description' : 'Plugin management commands',
      \ }
let g:unite_source_menu_menus.plug.command_candidates = [
      \       ['Install plugins', 'PlugInstall'],
      \       ['Update plugins', 'PlugUpdate'],
      \       ['Clean plugins', 'PlugClean'],
      \       ['Upgrade vim-plug', 'PlugUpgrade'],
      \     ]
" My unite menu
let g:unite_source_menu_menus.unite = {
      \     'description' : 'My Unite sources',
      \ }
let g:unite_source_menu_menus.unite.command_candidates = [
      \       ['Unite MRUs', 'call utils#uniteMRUs()'],
      \       ['Unite buffers', 'call utils#uniteBuffers()'],
      \       ['Unite file browse', 'call utils#uniteFileBrowse()'],
      \       ['Unite file search', 'call utils#uniteFileRec()'],
      \       ['Unite history', 'call utils#uniteHistory()'],
      \       ['Unite menu', 'call utils#uniteCustomMenu()'],
      \       ['Unite registers', 'call utils#uniteRegisters()'],
      \       ['Unite sources', 'call utils#uniteSources()'],
      \       ['Unite yank history', 'call utils#uniteYankHistory()'],
      \       ['Unite jump history', 'call utils#uniteJumps()'],
      \     ]
" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Enable navigation with control-j and control-k in insert mode
  imap <silent> <buffer> <C-j> <Plug>(unite_select_next_line)
  imap <silent> <buffer> <C-k> <Plug>(unite_select_previous_line)
  " Runs 'splits' action by <C-s> and <C-v>
  imap <silent> <buffer> <expr> <C-s> unite#do_action('split')
  imap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
  " Exit with escape
  nmap <silent> <buffer> <ESC> <Plug>(unite_exit)
  " Mark candidates
  xmap <silent> <buffer> m <Plug>(unite_toggle_mark_selected_candidates)
  nmap <silent> <buffer> m <Plug>(unite_toggle_mark_current_candidate)
endfunction
" Search files recursively ([o]pen file)
nnoremap <silent> <leader>uo :call utils#uniteFileRec()<CR>
" Browse [f]iles in CWD
nnoremap <silent> <leader>uf :call utils#uniteFileBrowse()<CR>
" [U]nite sources
nnoremap <silent> <leader>ur :call utils#uniteSources()<CR>
" Search between open files - [b]uffers
nnoremap <silent> <leader>ub :call utils#uniteBuffers()<CR>
" Search in current file ou[t]line (tags in current file)
nnoremap <silent> <leader>ut :call utils#uniteTags()<CR>
" Search in [l]ines on current buffer
nnoremap <silent> <leader>ul :call utils#uniteLineSearch()<CR>
" Search in [y]ank history
nnoremap <silent> <leader>up :call utils#uniteYankHistory()<CR>
" Search in [r]egisters
nnoremap <silent> <leader>ur :call utils#uniteRegisters()<CR>
" Search in opened [w]indow splits
nnoremap <silent> <leader>uw :call utils#uniteWindows()<CR>
" Search in ultisnips [s]nippets
nnoremap <silent> <leader>us :call utils#uniteSnippets()<CR>
" Search in latest [j]ump positions
nnoremap <silent> <leader>uj :call utils#uniteJumps()<CR>
" Search in my custom unite [m]enu with my commands
nnoremap <silent> <leader>uu :call utils#uniteCustomMenu()<CR>
" Seach in help menu for commands
nnoremap <silent> <leader>uc :call utils#uniteCommands()<CR>
" Seach in help menu for mappings
nnoremap <silent> <leader>um :call utils#uniteMappings()<CR>
" }}}
" Wimproved.vim {{{
" ------------------------------------------------------------------------------
if s:is_windows
    autocmd GUIEnter * silent! WToggleClean
endif

noremap <F11> :WToggleFullscreen<CR>
" }}}
" ~~~ YankRing {{{
"" ------------------------------------------------------------------------------
"let g:yankring_window_height = 4
"let g:yankring_map_dot = 0
"let g:yankring_max_history = 50
"let g:yankring_history_dir = $rtp.'temp'
"let g:yankring_history_file = 'yankringHistory'
"let g:yankring_zap_keys = ''
"let g:yankring_n_keys = 'X x'
"let g:yankring_replace_n_pkey = ''
"let g:yankring_replace_n_nkey = ''
"nnoremap <silent> <leader>u :YRShow<CR>
"}}}
" ~~~ Yankstack {{{
" ------------------------------------------------------------------------------
" nmap <leader>u :Yanks<cr>
" nmap <A-p> :<Plug>yankstack_subsitute_older_paste
" nmap <A-P> :<Plug>yankstack_subsitute_older_paste
" }}}
" ~~~ YouCompleteMe {{{
" ------------------------------------------------------------------------------
let g:ycm_complete_in_comments = 1
let g:ycm_key_list_select_completion = ['<C-n>', '<down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<up>']

autocmd! User YouCompleteMe call youcompleteme#Enable()
" }}}
" ##############################################################################
" END CONFIG PLUGINS }}}
" vim:foldmethod=marker
