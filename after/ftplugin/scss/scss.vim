" No idea where this comes from
syn match cssBoxProp contained '\<padding\>'
syn match cssBoxProp contained '\<line-height\>'
" Vendorprefixes are intentionally not part of the css3 runtime files ... 
syn match cssBoxProp contained /-\(moz\|webkit\|o\|ms\)-[a-zA-Z-]\+/
" au FileType css match VendorPrefix /-\(moz\|webkit\|o\|ms\)-[a-zA-Z-]\+/
" au FileType scss match VendorPrefix /-\(moz\|webkit\|o\|ms\)-[a-zA-Z-]\+/
" font-smoothing Property missing
syn match cssFontProp contained "\<font-smoothing\>"
" grayscale Attribute missing
syn match cssFontAttr contained "\<\(subpixel-\)\=\grayscale\>"
" fix functionnames starting with a keyword
setlocal iskeyword+=-
