" Author: w0rp <dev@w0rp.com>
" Description: Simple file search with ripgrep and a buffer.
let s:search_timer = 0
let s:job = v:null

function! s:StopLastSearch() abort
    if s:job isnot v:null
        call job_stop(s:job)
        let s:job = v:null
    endif
endfunction

function! s:SetLines(buffer, lines) abort
    call setbufline(a:buffer, 1, a:lines)
    call deletebufline(a:buffer, len(a:lines) + 1, '$')
    redraw
endfunction

function! s:Search(dir, search_buffer, text) abort
    call s:StopLastSearch()

    let l:words = map(
    \   split(a:text, ' \+'),
    \   ''' | rg -- '' . escape(shellescape(v:val), ''#'')',
    \)
    let l:command = 'rg --files' . join(l:words, '') . ' | sort'

    let l:lines = []
    let s:job = job_start(['/bin/sh', '-c', l:command], {
    \   'cwd': a:dir,
    \   'out_mode': 'nl',
    \   'out_cb': {_, line -> add(l:lines, line)},
    \   'exit_cb': {-> s:SetLines(a:search_buffer, l:lines)},
    \})
endfunction

function! s:HighlightLine(search_buffer, line) abort
    for l:match in getmatches()
        if l:match.group is# 'FileSearchCurrent'
            call matchdelete(l:match.id)
        endif
    endfor

    call matchaddpos('FileSearchCurrent', [a:line])
endfunction

function! s:DebounceSearch(dir, search_buffer, text) abort
    call timer_stop(s:search_timer)
    let s:search_timer = timer_start(100, {-> s:Search(a:dir, a:search_buffer, a:text)})
endfunction

function! file_search#ReadChars(dir, search_buffer) abort
    let l:text = ''
    let l:highlighted = 1

    while 1
        redraw
        echoh MoreMsg
        echon '> ' . l:text
        echoh None

        let l:code = getchar()
        let l:char = nr2char(l:code)

        if l:code is# "\<BS>"
            let l:text = l:text[:-2]
        " Move up with up arrow or CTRL+k
        elseif l:code is# "\<Up>" || l:char is# "\<C-k>"
            let l:highlighted -= 1
            let l:highlighted = min([l:highlighted, line('$')])
            call s:HighlightLine(a:search_buffer, l:highlighted)
        " Move down with down arrow or CTRL+j
        elseif l:code is# "\<Down>" || l:char is# "\<C-j>"
            let l:highlighted += 1
            let l:highlighted = min([l:highlighted, line('$')])
            call s:HighlightLine(a:search_buffer, l:highlighted)
        " Exit the search buffer with various keybinds.
        elseif l:char =~# "\\v\<Esc>|\<C-c>|\<C-g>|\<C-u>|\<C-w>|\<C-[>"
            bdelete!
            redraw

            return
        elseif l:char is# "\<Enter>"
            let l:result = getbufline(a:search_buffer, l:highlighted)
            bdelete!
            redraw

            if !empty(l:result)
                let l:path = a:dir . '/' . l:result[0]
                execute 'tabnew ' . fnameescape(l:path)
            endif

            return
        else
            let l:text .= l:char
        endif

        if !empty(l:text)
            call s:DebounceSearch(a:dir, a:search_buffer, l:text)
        endif
    endwhile
endfunction

function! s:CreateFileSearchBuffer() abort
    if !hlexists('FileSearchCurrent')
        highlight FileSearchCurrent cterm=NONE ctermbg=DarkGray ctermfg=red guibg=DarkGray
    endif

    above new
    let l:buffer = bufnr()
    set filetype=file-search

    call s:HighlightLine(l:buffer, 1)

    return l:buffer
endfunction

function! file_search#OpenNewSearch() abort
    let l:dir = finddir('.git/..', expand('%:p:h').';')

    if empty(l:dir)
        let l:dir = getcwd()
    endif

    let l:buffer = s:CreateFileSearchBuffer()
    call timer_start(0, {-> file_search#ReadChars(l:dir, l:buffer)})
endfunction
