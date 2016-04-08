" ------------------------------------------------------------------------------
" --- Parts of this file were originally created by github.com/martin-svk
" ------------------------------------------------------------------------------
" Utility functions 
" ##############################################################################

" sources VimL under curser / selected line 
function! g:utils#sourceVimscript(type)
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

" yank&puts current line, replaces with '-'
function! g:utils#underline()
    :t.|s/[^/]/-/g|exe "normal! A-"|t-2
endfun

" build YouCompleteMe
function! g:utils#buildYCM(info)
    if a:info.status == 'installed' || a:info.force
        !./python install.py --tern-completer
    endif
endfunction

" takes a range and places content in the center
" based on # of columns
function! g:utils#centerLines(lines) abort
    let longest_line   = max(map(copy(a:lines), 'len(v:val)'))
    let centered_lines = map(copy(a:lines),
                \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
    return centered_lines
endfunction 

" Be aware of whether you are right or left vertical split
" so you can use arrows more naturally.
" Inspired by https://github.com/ethagnawl.
function! g:utils#intelligentVerticalResize(direction) abort
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

" toggle between RNU, NU and no numbers
function! g:utils#toggleRNU()
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


" ##############################################################################
" END Utility functions 
