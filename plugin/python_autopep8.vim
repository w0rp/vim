" File: python_autopep8.vim
" Author: tell-k <ffk2005[at]gmail.com>, w0rp <devw0rp[at]gmail.com>
"
" This script is a modified version of the vim-autopep8 plugin which
" installs the command once globally, without any keybinds.

" Only do this when not done yet for this buffer
if exists("g:loaded_autopep8_ftplugin")
    finish
endif

let g:loaded_autopep8_ftplugin=1

function Autopep8(...)
    let l:args = get(a:, 1, '')

    if exists("g:autopep8_cmd")
        let autopep8_cmd=g:autopep8_cmd
    else
        let autopep8_cmd="autopep8"
    endif

    if !executable(autopep8_cmd)
        echoerr "File " . autopep8_cmd . " not found. Please install it first."
        return
    endif

    if exists("g:autopep8_ignore")
        let autopep8_ignores=" --ignore=".g:autopep8_ignore
    else
        let autopep8_ignores=""
    endif

    if exists("g:autopep8_select")
        let autopep8_selects=" --select=".g:autopep8_select
    else
        let autopep8_selects=""
    endif

    if exists("g:autopep8_pep8_passes")
        let autopep8_pep8_passes=" --pep8-passes=".g:autopep8_pep8_passes
    else
        let autopep8_pep8_passes=""
    endif

    if exists("g:autopep8_max_line_length")
        let autopep8_max_line_length=" --max-line-length=".g:autopep8_max_line_length
    else
        let autopep8_max_line_length=""
    endif

    if exists("g:autopep8_aggressive")
        let autopep8_aggressive=" --aggressive "
    else
        let autopep8_aggressive=""
    endif

    if exists("g:autopep8_indent_size")
        let autopep8_indent_size=" --indent-size=".g:autopep8_indent_size
    else
        let autopep8_indent_size=""
    endif

    let execmdline=autopep8_cmd.autopep8_pep8_passes.autopep8_selects.autopep8_ignores.autopep8_max_line_length.autopep8_aggressive.autopep8_indent_size.l:args

    " current cursor
    let current_cursor = getpos(".")
    " show diff if not explicitly disabled
    if !exists("g:autopep8_disable_show_diff")
        let tmpfile = tempname()
        try
            " write buffer contents to tmpfile because autopep8 --diff
            " does not work with standard input
            silent execute "0,$w! " . tmpfile
            let diff_cmd = execmdline . " --diff \"" . tmpfile . "\""
            let diff_output = system(diff_cmd)
        finally
            " file close
            if filewritable(tmpfile)
                call delete(tmpfile)
            endif
        endtry
    endif
    " execute autopep8 passing buffer contents as standard input
    silent execute "0,$!" . execmdline . " -"
    " restore cursor
    call setpos('.', current_cursor)

    " show diff
    if !exists("g:autopep8_disable_show_diff")
      botright new autopep8
      setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
      silent execute ':put =diff_output'
      setlocal nomodifiable
      setlocal nu
      setlocal filetype=diff
    endif

    hi Green ctermfg=green
    echohl Green
    echon "This file was fixed with autopep8."
    echohl
endfunction
