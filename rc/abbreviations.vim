" ABBREVIATIONS {{{
" ##############################################################################
" ------------------------------------------------------------------------------
" --- Open help in new tab
" ------------------------------------------------------------------------------
cnoreabbrev <expr> h getcmdtype() == ":" && getcmdline() == 'h' ? 'tab help' : 'h'
" ##############################################################################
" END ABBREVIATIONS }}}
" Abolish {{{
" ##############################################################################
if !exists(":Abolish")
    finish
endif
Abolish improvment{,s} improvement{}
Abolish persistan{ce,t,tly} persisten
Abolish {,ir}releven{ce,cy,t,tly} {}relevan{}
Abolish i{n,s}{s,n}t{all,lla,lal} install
Abolish res{,s}o{,u}rce{,s} resource{}
Abolish Tqbf The quick, brown fox jumps over the lazy dog
Abolish Lorem Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
" ##############################################################################
" END Abolish }}}