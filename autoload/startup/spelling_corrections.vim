" This file lists some settings for automatically fixing common spelling
" mistakes.

iab mighht might
iab notifidationc notifications
iab notificaitons notifications
iab meail email
iab mesage message
iab templatse templates
iab suppport support
iab supprot support
iab getitng getting

function! startup#spelling_corrections#FixCurrentMistakes() abort
    let l:output = ''
    redir => l:output
        silent iab
    redir END
    let l:output_list = split(l:output, "\n")

    let l:replacements = {}

    for l:line in l:output_list
        let l:match = matchlist(l:line, '\v^i *([a-zA-Z]+) *([a-zA-Z]+) *$')

        if !empty(l:match)
           let l:replacements[l:match[1]] = l:match[2]
        endif
    endfor

    let l:regex = '\V\(' . join(keys(l:replacements), '\|') . '\)'

    try
        execute '%s/' . l:regex . '/\=l:replacements[submatch(1)]/gc'
    catch /E486/
        " Shut up about finding no matches.
    endtry
endfunction

command! -bar FixSpellingMistakes :call startup#spelling_corrections#FixCurrentMistakes()

function! startup#spelling_corrections#Init() abort
endfunction
