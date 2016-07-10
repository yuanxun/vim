" ABBREVIATIONS
" ##############################################################################

cnoreabbrev <expr> h getcmdline() == 'h' ? 'tab help' : 'h'
" insert date
iab <expr> ddate strftime("%Y %b %d %H:%M")
" php function name, excluding function keyword and brackets
cabbr xfunc \s\zs[a-zA-Z_]*\ze(

" ABOLISH
" =============================================================================

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
