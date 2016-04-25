function! VimFolds()
    let thisline = getline(v:lnum)
    let prevline = getline(v:lnum-1)
    let nextline = getline(v:lnum+1)
    if match(nextline, '^"\s---') >= 0 && match(prevline, '^$') >= 0
        return ">2"
    elseif match(nextline, '^"\s###') >= 0
        return ">1"
    elseif match(thisline, '^" vim:') >= 0
        return "0"
    else
        return "="
    endif
endfunction

setlocal foldmethod=expr
setlocal foldexpr=VimFolds()

" function! VimFoldText()
"     let foldsize = (v:foldend-v:foldstart)
"     return getline(v:foldstart).' ('.foldsize.' lines)'
" endfunction

" setlocal foldtext=VimFoldText()

