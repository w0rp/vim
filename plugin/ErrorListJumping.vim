" Author: w0rp <devw0rp[at]gmail.com>
" Copyright: Public Domain
"
" This script lets you jump to the next and previous lines in both the
" quickfix and loation lists. This can be used with a tool like Syntastic
" for jumping through error lines.

if exists("g:loaded_error_list_jumping")
    finish
endif

let g:loaded_error_list_jumping = 1

" A function to find all current line numbers for quickfix and loclist
" together in one list of lines.
function g:ErrorListJumping#AllLineNumbers()
    let numberList = []

    for result in getloclist(winnr()) + getqflist()
        let lineNumber = get(result, "lnum")

        if index(numberList, lineNumber) < 0
            call add(numberList, lineNumber)
        endif
    endfor

    call sort(numberList, "n")

    return numberList
endfunction

" Search for the nearest line either up or down the list.
" If there are no lines in the quickfix list or loclist, then -1 will
" be returned.
function g:ErrorListJumping#FindNearest(direction)
    let numberList = g:ErrorListJumping#AllLineNumbers()

    if len(numberList) == 0
        return -1
    endif

    let currentLine = line(".")
    let nearest = -1

    if a:direction == "up"
        " Search upwards in the list to find a line above this one.
        for lineNumber in reverse(copy(numberList))
            if lineNumber < currentLine
                let nearest = lineNumber
                break
            endif
        endfor
    else
        " Search downwards in the list to find a line below this one.
        for lineNumber in numberList
            if lineNumber > currentLine
                let nearest = lineNumber
                break
            endif
        endfor
    endif

    " If we couldn't find any matches, then wrap around the list.
    if nearest == -1
        if a:direction == "up"
            let nearest = get(numberList, len(numberList) - 1)
        else
            let nearest = get(numberList, 0)
        endif
    endif

    return nearest
endfunction

function g:ErrorListJumping#JumpToNextLine()
    let nearest = g:ErrorListJumping#FindNearest("down")

    if nearest >= 0
        execute nearest
    endif
endfunction

function g:ErrorListJumping#JumpToPreviousLine()
    let nearest = g:ErrorListJumping#FindNearest("up")

    if nearest >= 0
        execute nearest
    endif
endfunction

command NextError :call g:ErrorListJumping#JumpToNextLine()
command PreviousError :call g:ErrorListJumping#JumpToPreviousLine()
