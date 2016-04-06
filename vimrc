" ------------------------------------------------------------------------------
" --- Zeitwerk vimrc
" ------------------------------------------------------------------------------
"  STARTUP {{{
" ##############################################################################
" variable to check if is windows version of vim
let s:is_windows = has('win32') || has('win64')
if s:is_windows
    set shell=C:\Windows\system32\cmd.exe
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
" --- Colorscheme
" ------------------------------------------------------------------------------
Plug 'chriskempson/base16-vim'             " base16 vim port
" ------------------------------------------------------------------------------
" --- Interface / File management
" ------------------------------------------------------------------------------
Plug 'scrooloose/nerdtree',                " file browser
            \ {
            \ 'on' : ['NERDTreeFind', 'NERDTreeToggle'] 
            \ }
Plug 'itchyny/lightline.vim'               " simple statusline
Plug 'mhinz/vim-startify'                  " startup screen
Plug 'ctrlpvim/ctrlp.vim'                  " complex fuzzy-finder (buffer, file, mru)
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
Plug 'maksimr/vim-jsbeautify',             " js-beautify integration
            \ {
            \ 'for' : ['javascript', 'css', 'html', 'php', 'scss']
            \ }
"
" ------------------------------------------------------------------------------
" --- Syntax
" ------------------------------------------------------------------------------
Plug 'scrooloose/syntastic',               " syntax integration (requires external tools)
            \ {
            \ 'for' : ['scss','html','javascript','css']
            \ }
" ------------------------------------------------------------------------------
" --- Autocompletion
" ------------------------------------------------------------------------------
" Plug 'ervandew/supertab'                   " insert completion
" Plug 'Shougo/neocomplete.vim'              " completion engine
Plug 'cohama/lexima.vim',                  " auto close parentheses TODO
            \ {
            \ 'for' : ['hmtl','css','scss','javascript']
            \ }
Plug 'Valloric/YouCompleteMe',             " completion engine, requires compilation
            \ {
            \ 'for' : ['scss','sass','css','javascript']
            \ }
au! User YouCompleteMe if !has('vim_starting') | call youcompleteme#Enable() | endif
" ------------------------------------------------------------------------------
" --- Git
" ------------------------------------------------------------------------------
Plug 'airblade/vim-gitgutter'              " adds diff status column
Plug 'tpope/vim-fugitive'                  " git wrapper TODO
Plug 'junegunn/gv.vim'                     " git commit browser TODO
" ------------------------------------------------------------------------------
" --- Language agnostic utility
" ------------------------------------------------------------------------------
Plug 'sirver/ultisnips'                    " snippet integration
            \ | Plug 'honza/vim-snippets'  " snippets
Plug 'tpope/vim-commentary'                " fileType specific comment creation mappings
Plug 'vim-scripts/yankring.vim'            " easier yank / put register management
Plug 'junegunn/vim-easy-align'             " text align
Plug 'lilydjwg/colorizer'                  " hex, rgb and named color highlighting
" ------------------------------------------------------------------------------
" --- Language specific utility
" ------------------------------------------------------------------------------
Plug 'mattn/emmet-vim',                    " emmet integration TODO
            \ {
            \ 'for' : ['html', 'xml', 'xhtml', 'php']
            \ }
" ------------------------------------------------------------------------------
" --- Vanilla improvements
" ------------------------------------------------------------------------------
Plug 'thinca/vim-visualstar'               " improves * and #
Plug 'Konfekt/FastFold'                    " improves Folds TODO
Plug 'tpope/vim-speeddating'               " improves number in-/decementation (C-X/C-A)
Plug 'tpope/vim-repeat'                    " makes lots of commands repeatable with .
Plug 'mhinz/vim-sayonara',                 " essentially :qw
            \ {
            \ 'on' : 'Sayonara'
            \ }
Plug 'amix/open_file_under_cursor.vim'     " read its name ...
Plug 'terryma/vim-expand-region'           " expands visual selection TODO
Plug 'edsono/vim-matchit'                  " improves % behaviour
" Plug 'unblevable/quick-scope'              " visual help with left and right motions TODO
" ------------------------------------------------------------------------------
" --- Additional text-object funtionality
" ------------------------------------------------------------------------------
Plug 'tpope/vim-surround'                  " surround text-objects
Plug 'wellle/targets.vim'                  " more objects
Plug 'kana/vim-textobj-user'               " new custom textobjects TODO
Plug 'glts/vim-textobj-comment'            " adds comments as textobject TODO
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
    set guioptions-=m
    set guioptions-=t
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
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
set nohlsearch                          " disable search highlighting
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
    colorscheme base16-monokai          " set colorscheme
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
" VIM-SCRIPTS {{{
" ##############################################################################
" Sourced Scripts {{{
" ------------------------------------------------------------------------------
" --- Sorts folded text without hickups
" ------------------------------------------------------------------------------
source $rc/SortUnfolded.vim
" }}}
" Custom Functions {{{
" ------------------------------------------------------------------------------
" Position-away window resizing {{{
" ------------------------------------------------------------------------------

function! IntelligentVerticalResize(direction) abort
  let l:window_resize_count = 5
  let l:current_window_is_last_window = (winnr() == winnr('$'))

  if (a:direction ==# 'left')
    let [l:modifier_1, l:modifier_2] = ['+', '-']
  else
    let [l:modifier_1, l:modifier_2] = ['-', '+']
  endif

  let l:modifier = l:current_window_is_last_window ? l:modifier_1 : l:modifier_2
  let l:command = 'vertical resize ' . l:modifier . l:window_resize_count . '<CR>'
  execute l:command
endfunction
" }}}
" Center lines on screen {{{
" ------------------------------------------------------------------------------

function! s:filter_header(lines) abort
    let longest_line   = max(map(copy(a:lines), 'len(v:val)'))
    let centered_lines = map(copy(a:lines),
                \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
    return centered_lines
endfunction 
" }}}
" Current line becomes underlined {{{
" ------------------------------------------------------------------------------
function! ZWUnderlineComments()
    :t.|s/[^/]/-/g|exe "normal! A-"|t-2
endfun
" }}}
" Source lines (TODO credit, I forgot ...) {{{
" ------------------------------------------------------------------------------
function! SourceVimscript(type)
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @"
    if a:type == 'line'
        silent execute "normal! '[V']y"
    elseif a:type == 'char'
        silent execute "normal! `[v`]y"
    elseif a:type == "visual"
        silent execute "normal! gvy"
    elseif a:type == "currentline"
        silent execute "normal! yy"
    endif
    let @" = substitute(@", '\n\s*\\', '', 'g')
    " source the content
    @"
    let &selection = sel_save
    let @" = reg_save
endfunction
" }}}
" Find trailing spaces {{{
" ------------------------------------------------------------------------------
function! ShowSpaces(...)
    let @/='\v(\s+$)|( +\ze\t)'
    let oldhlsearch=&hlsearch
    if !a:0
        let &hlsearch=!&hlsearch
    else
        let &hlsearch=a:1
    end
    return oldhlsearch
endfunction
" }}}
" Trim spaces before EOL {{{
" ------------------------------------------------------------------------------
function! TrimSpaces() range
    let oldhlsearch=ShowSpaces(1)
    execute a:firstline.",".a:lastline."substitute ///gec"
    let &hlsearch=oldhlsearch
endfunction
command! -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command! -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
" }}}
" Toggle relativenumber {{{
" ------------------------------------------------------------------------------
function! ZWToggleRNU()
    if !&nu && !&rnu
        set rnu nu
    elseif &nu && &rnu
        set nornu
    elseif &nu && !&rnu
        set nornu nonu
    else
        set nonu nornu
    endif
endfun
" }}}
" Treat tab as Snip-Completion mapping (github.com/netsmertia) {{{
" ------------------------------------------------------------------------------
if !empty(glob("plugged/UltiSnips"))
    function! UltiSnips_Complete()
        call UltiSnips#ExpandSnippet()
        if g:ulti_expand_res == 0
            if pumvisible()
                return "\<C-n>"
            else
                call UltiSnips#JumpForwards()
                if g:ulti_jump_forwards_res == 0
                   return "\<TAB>"
                endif
            endif
        endif
        return ""
    endfunction
    function! g:UltiSnips_Reverse()
      call UltiSnips#JumpBackwards()
      if g:ulti_jump_backwards_res == 0
        return "\<C-P>"
      endif
      return ""
    endfunction
endif
" }}}
" }}}
" Autocommands {{{
" ------------------------------------------------------------------------------
" --- Filetype specific autocommands
" ------------------------------------------------------------------------------
augroup FileSpecific
    au!
    au BufEnter *.html|*.htm setlocal nowrap
augroup END
" ------------------------------------------------------------------------------
" --- Startify options
" ------------------------------------------------------------------------------
augroup Startify
    au!
    au User Startified file Startify
    au User Startified setlocal nowrap
augroup END
" ------------------------------------------------------------------------------
" --- Resize splits when resizing window
" ------------------------------------------------------------------------------
autocmd VimResized * :wincmd =
" }}}
" Syntax Highlighting fixes {{{
" ------------------------------------------------------------------------------
"  TODO subsections
let s:colorAA = "#181818"
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

augroup CSS3Fix
    au!
    if g:colors_name == 'base16-tomorrow' || g:colors_name == 'base16-monokai'
        " No idea where this comes from
        " au FileType scss syn match cssBoxProp contained '\<padding\>'
        " au FileType css syn match cssBoxProp contained '\<padding\>'
        au FileType scss syn match cssBoxProp contained '\<line-height\>'
        au FileType css syn match cssBoxProp contained '\<line-height\>'
        au FileType scss syn match cssBoxProp contained /-\(moz\|webkit\|o\|ms\)-[a-zA-Z-]\+/
        au FileType css syn match cssBoxProp contained /-\(moz\|webkit\|o\|ms\)-[a-zA-Z-]\+/
    endif
    " fix vendorprefixes
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
" remove the styling for the splitseperator
hi VertSplit guibg = NONE
" }}}
" ##############################################################################
" END VIM-SCRIPTS }}}
" MAPPINGS {{{
" ##############################################################################
" ------------------------------------------------------------------------------
" --- Choose Leader
" ------------------------------------------------------------------------------
let mapleader   = "\<Space>"
let g:mapleader = "\<Space>"
" Unmap {{{
" ------------------------------------------------------------------------------
nmap <S-k>     <Nop>
nmap <M-Right> <Nop>
nmap <M-Left>  <Nop>
nmap <M-Down>  <Nop>
nmap <M-Up>    <Nop>
" }}}
" Default remap {{{
" ------------------------------------------------------------------------------
" Keep the cursor in place while joining lines
nnoremap J mzJ`z
" Don't yank to default register when changing something
nnoremap c "xc
xnoremap c "xc
" go to end of inserted text after yank and put
vnoremap <silent> y y`]
vnoremap <silent> p p`]
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
vnoremap n nzz
vnoremap N Nzz
" center screen when moving screenwise
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz
vnoremap <C-u> <C-u>zz
vnoremap <C-d> <C-d>zz
vnoremap <C-f> <C-f>zz
vnoremap <C-b> <C-b>zz
" delete with Ctrl-D in insertmode
inoremap <C-D>       <backspace>
" lower- and uppercase under cursor in normalmode
nnoremap gu  vgu
nnoremap gU  vgU
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
vnoremap öf mzzf`zzz
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
nnoremap <silent> <Right> :call IntelligentVerticalResize('right')<CR>
nnoremap <silent> <Left> :call IntelligentVerticalResize('left')<CR>
nnoremap <silent> <Up> :resize -5<CR>
nnoremap <silent> <Down> :resize +5<CR>
" source local stuff
vmap <silent> g: :<c-U>call SourceVimscript("visual")<cr>
nmap <silent> g: :call SourceVimscript("currentline")<cr>
" move a line of text using ALT+[jk] (TODO: credit, forgot who ...)
nmap <A-k> :let fdm_sav=&fdm\|:set fdm=manual\|:m-2<CR>:let &fdm=fdm_sav<CR>==
nmap <A-j> :let fdm_sav=&fdm\|:set fdm=manual\|:m+<CR>:let &fdm=fdm_sav<CR>==
vmap <A-k> :<C-U>let fdm_sav=&fdm\|:set fdm=manual\|:'<,'>m'<-2<CR>gv=:let &fdm=fdm_sav<CR>gv
vmap <A-j> :<C-U>let fdm_sav=&fdm\|:set fdm=manual\|:'<,'>m'>+<CR>gv=:let &fdm=fdm_sav<CR>gv
" quick fold toggeling
nnoremap <tab> za
" mappings for trailing spaces function
nmap <F12> :ShowSpaces 1<CR>
nmap <S-F12> m`:TrimSpaces<CR>``
vmap <S-F12> :TrimSpaces<CR>
" newlines without insertmode
map <A-o> o<ESC>
map <A-S-o> <S-o><ESC>
" highlight last inserted text
nnoremap gV                 `[v`]
" put from sysclipboard
nnoremap <A-p> "+p
" yank to sysclipboard
nnoremap <A-y> "*y
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
nmap <silent><leader>n  :call ZWToggleRNU()<cr>
" edit and source vimrc
nnoremap <silent><leader>ve :cd $rtp<cr>:tabnew $MYVIMRC<CR>
nnoremap <silent><leader>vs :source $MYVIMRC<CR>
" disable highlight when <leader><cr> is pressed
noremap  <silent> <leader><cr> :let @/ = ""<cr>
" save current session & close all buffers
nnoremap <silent><leader>Q :SSave last<CR>y<CR>:wqa<CR>
" }}}
" Plugin {{{
" ------------------------------------------------------------------------------
" Gitgutter {{{
" ------------------------------------------------------------------------------
nnoremap <leader>gN :GitGutterPrevHunk<CR>
nnoremap <leader>gn :GitGutterNextHunk<CR>
nnoremap <leader>gs :GitGutterStageHunk<CR>
nnoremap <leader>gr :GitGutterRevertHunk<CR>
" }}}
" UltiSnips {{{
" ------------------------------------------------------------------------------
nmap <silent><leader>pu :UltiSnipsEdit<cr>
if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif
if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif
au InsertEnter * exec "inoremap <buffer> <silent> " . g:UltiSnipsExpandTrigger     . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <buffer> <silent> " .     g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"
" }}}
" CtrlP {{{
" ------------------------------------------------------------------------------
map <leader>f :CtrlP<cr>
map <leader>b :CtrlPBuffer<cr>
map <leader>m :CtrlPMRU<cr>
" }}}
" Vim-Commentary {{{
" ------------------------------------------------------------------------------
nmap gC <Plug>CommentaryLine
" }}}
" Goyo {{{
" ------------------------------------------------------------------------------
nnoremap <silent>           <leader>pz :Goyo<CR>
" }}}
" NERDTree {{{
" ------------------------------------------------------------------------------
noremap  <leader>nn         :NERDTreeToggle<cr>
noremap  <leader>nh         :NERDTreeToggle ~/<cr>
noremap  <silent>           <leader>nf :NERDTreeFind<cr>cd
nnoremap <leader>nb         :Bookmark<space>
" }}}
" Vim-Surround {{{
" ------------------------------------------------------------------------------
nmap ms  ys
nmap mS  ysiW
nmap mss yss
nmap mSS ySS
" }}}
" Yankring {{{
" ------------------------------------------------------------------------------
nnoremap <silent>           <leader>u :YRShow<CR>
" }}}
" Colorizer {{{
" ------------------------------------------------------------------------------
nmap <leader>pc <Plug>Colorizer
" }}}
" EasyAlign {{{
" ------------------------------------------------------------------------------
xmap gl <Plug>(EasyAlign)
nmap gl <Plug>(EasyAlign)
" }}}
" Emmet {{{
" ------------------------------------------------------------------------------
let g:user_emmet_leader_key='<C-m>'
" }}}
" ExpandRegion {{{
" ------------------------------------------------------------------------------
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
" }}}
" Vim-Fugitive {{{
" ------------------------------------------------------------------------------
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit --verbose<CR>
nnoremap <leader>gc :Gcommit --verbose<CR>
nnoremap <leader>gd :Gvdiff<CR>
" }}}
" Neocomplete {{{
" ------------------------------------------------------------------------------
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
" Vim-JsBeautify {{{
" ------------------------------------------------------------------------------
autocmd  FileType javascript nnoremap <buffer> <leader>pb :call JsBeautify()<cr>
autocmd  FileType json nnoremap <buffer>       <leader>pb :call JsonBeautify()<cr>
autocmd  FileType jsx nnoremap <buffer>        <leader>pb :call JsxBeautify()<cr>
autocmd  FileType html nnoremap <buffer>       <leader>pb :call HtmlBeautify()<cr>
autocmd  FileType css nnoremap <buffer>        <leader>pb :call CSSBeautify()<cr>
autocmd  FileType javascript vnoremap <buffer> <leader>pb :call RangeJsBeautify()<cr>
autocmd  FileType json vnoremap <buffer>       <leader>pb :call RangeJsonBeautify()<cr>
autocmd  FileType jsx vnoremap <buffer>        <leader>pb :call RangeJsxBeautify()<cr>
autocmd  FileType html vnoremap <buffer>       <leader>pb :call RangeHtmlBeautify()<cr>
autocmd  FileType css vnoremap <buffer>        <leader>pb :call RangeCSSBeautify()<cr>
" }}}
" Sayonara {{{
" ------------------------------------------------------------------------------
nnoremap <leader>q          :Sayonara<CR>
" }}}
" Startify {{{
" ------------------------------------------------------------------------------
nnoremap <leader>ps :Startify<CR>
nnoremap <leader>sm :SSave default<CR>y<CR>
nnoremap <leader>sl :SLoad default<CR>
" }}}
" Tabmerge {{{
" ------------------------------------------------------------------------------
noremap  <silent><leader>tm     :Tabmerge<CR>
noremap  <silent><leader>t<C-h> :Tabmerge left<CR>
noremap  <silent><leader>t<C-l> :Tabmerge right<CR>
" }}}
" QuickScope {{{
" ------------------------------------------------------------------------------
nnoremap <leader>pq :QuickScopeToggle<CR>
" }}}
" Wimproved {{{
" ------------------------------------------------------------------------------
noremap <F11> :WToggleFullscreen<CR>
" }}}
" }}}
" ##############################################################################
" END MAPPINGS }}}
" CONFIG PLUGINS {{{
" ##############################################################################
" Colorizer {{{
" ------------------------------------------------------------------------------
let g:colorizer_startup = 0
"  }}}
" CtrlP"{{{
" ------------------------------------------------------------------------------
" ignore .git folders to speed up searches
let g:ctrlp_reuse_window = 'startify'
let g:ctrlp_max_depth = 15
let g:ctrlp_max_height = 20
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
"}}}
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
"  }}}
" NERDTree {{{
" ------------------------------------------------------------------------------
" fix NERDTree opening a split in startify
autocmd User Startified setlocal buftype=
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeAutoCenter = 1
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeBookmarksFile = $rtp.'temp/.NERDTreeBookmarks'
let g:NERDTreeMinimalUI = 0
let g:NERDTreeWinPos = "left"
let g:NERDTreeShowHidden = 1
let g:NERDTreeSortHiddenFirst = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeWinSize = 35
"}}}
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
" YankRing {{{
" ------------------------------------------------------------------------------
let g:yankring_history_dir = $rtp.'temp'
"}}}
" Emmet {{{
" ------------------------------------------------------------------------------
let g:user_emmet_mode='a'
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
" Neoplete {{{
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
" }}}
" Vim-Plug {{{
" ------------------------------------------------------------------------------
let g:plug_timeout = 240
" }}}
" Startify {{{
" ------------------------------------------------------------------------------
let g:startify_session_delete_buffers = 1
let g:startify_files_number = 7
let g:startify_change_to_dir = 1
let g:startify_relative_path = 1
let g:startify_use_env = 1
let g:startify_enable_special = 0
let g:startify_custom_indices = ['1', '2', '3', '4', '5', '6', '7', 'r', 'g', 'd', 'l']
if s:is_windows
    let g:startify_bookmarks = [
                \ $rtp,
                \ '~/Google Drive/'
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
let g:startify_custom_header = s:filter_header([
                \ '                                                                               ',
                \ '    ______      _  _ __          __          _     __      __ _____  __  __    ',
                \ '   |___  /     (_)| |\ \        / /         | |    \ \    / /|_   _||  \/  |   ',
                \ '      / /  ___  _ | |_\ \  /\  / /___  _ __ | | __  \ \  / /   | |  | \  / |   ',
                \ '     / /  / _ \| || __|\ \/  \/ // _ \|  __|| |/ /   \ \/ /    | |  | |\/| |   ',
                \ '    / /__|  __/| || |_  \  /\  /|  __/| |   |   <     \  /    _| |_ | |  | |   ',
                \ '   /_____|\___||_| \__|  \/  \/  \___||_|   |_|\_\     \/    |_____||_|  |_|   ',
                \ ])
let g:startify_custom_footer = s:filter_header([
            \ '         __   __  _        _                            _ ',
            \ '        / _| / _|(_)      (_)                          | |',
            \ '   ___ | |_ | |_  _   ___  _   ___  _ __    ___  _   _ | |',
            \ '  / _ \|  _||  _|| | / __|| | / _ \|  _ \  / __|| | | || |',
            \ ' |  __/| |  | |  | || (__ | ||  __/| | | || (__ | |_| ||_|',
            \ '  \___||_|  |_|  |_| \___||_| \___||_| |_| \___| \__, |(_)',
            \ '                                                  __/ |   ',
            \ '                                                 |___/    ',
            \ ])
"  }}}
" UltiSnips {{{
" ------------------------------------------------------------------------------
let g:UltiSnipsEditSplit = 'context'
"  }}}
" Vim-Gitgutter {{{
" ------------------------------------------------------------------------------
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_column_always = 0
" let g:gitgutter_realtime = 0
"  }}}
" QuickScope {{{
" ------------------------------------------------------------------------------
" Trigger a highlight in the appropriate direction when pressing these keys:
" let g:qs_highlight_on_keys=['f', 'F', 't', 'T']
"  }}}
" Wimproved.vim {{{
" ------------------------------------------------------------------------------
if s:is_windows
    autocmd GUIEnter * silent! WToggleClean
endif
" }}}
" ##############################################################################
" END CONFIG PLUGINS }}}
" ABBREVIATIONS {{{
" ##############################################################################
" ------------------------------------------------------------------------------
" --- Open help in new tab
" ------------------------------------------------------------------------------
cnoreabbrev <expr> h getcmdtype() == ":" && getcmdline() == 'h' ? 'tab help' : 'h'
" ##############################################################################
" END ABBREVIATIONS }}}
" vim:foldmethod=marker
