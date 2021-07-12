function! startup#keybinds#TryToOpenLink() abort
    let l:pos = getcurpos()
    let l:lnum = l:pos[1]
    let l:col = l:pos[2]
    let l:line = getline(l:lnum)

    " TODO: handle multiple lines on a single line better.
    let l:index = match(l:line[0 : l:col + len('https://')], '\vhttps?://')

    if l:index >= 0 && l:index < l:col
        let l:link = matchstr(l:line[l:index :], '\v[^ ]+')
        " Remove CR characters from links.
        let l:link = substitute(l:link, '\r', '', 'g')

        call job_start(['xdg-open', l:link])
        return 1
    endif

    return 0
endfunction

" This script holds all keybinding settings.

nnoremap <silent> <C-LeftMouse> <LeftMouse> :call startup#keybinds#TryToOpenLink()<CR>
nnoremap <C-RightMouse> <Nop>

" Disable replace mode, which turns on in bad terminals for some reason.
nnoremap R <Nop>

" CTRL-A is Select all
" This works better than the default Windows script.
noremap <C-A> ggVG
inoremap <C-A> <Esc>ggvG
vnoremap <C-A> <Esc>ggVG

" Make double-tapping ESC in normal mode quit a file.
nnoremap <ESC><ESC> :q<CR>
" Triple-tapping ESC forces quitting.
nnoremap <ESC><ESC> :q!<CR>

" Make Shift+V switch from selection to visual line mode on Windows, etc.
snoremap V <ESC>gvV

" CTRL-C is copy to the clipboard
vnoremap <C-C> y
snoremap <C-C> <ESC>gv"+y<ESC>

" CTRL-X is cut to the clipboard
vnoremap <C-X> "+x

" CTRL-V pastes from the clipboard
noremap <C-V> p
inoremap <C-V> <C-R>*
cnoremap <C-V> <C-R>+

" CTRL-P replaces the current line with the buffer without cutting it.
noremap <C-p> "_ddP
" p in visual mode shouldn't cut the text we replace.
vnoremap <p> "_dP

" CTRL-S Saves the file.
noremap <silent> <C-S> :w<CR>
vnoremap <silent> <C-S> <C-C>:w<CR>
inoremap <silent> <C-S> <C-C>:w<CR>

" SHIFT-S Saves the file.
noremap <silent> S :w<CR>

" Quit files by typing fjfj quickly, which requires less stretching.
noremap fjfj :q<CR>

" Make using Ctrl+C do the same as Escape, to trigger autocmd commands
inoremap <C-c> <Esc>

" Bind gV so we can re-select pasted text.
nnoremap <expr> gV "`[".getregtype(v:register)[0]."`]"

" Bind Ctrl + Tab goes forward
noremap <C-Tab> :tabn <Return>
tnoremap <C-Tab> <C-w>N:tabn<Return>
" Bind Ctrl + Shift + Tab goes back
noremap <C-S-Tab> :tabp <Return>
tnoremap <C-S-Tab> <C-w>N:tabp<Return>

" Ctrl + h goes to the tab to the left.
noremap <C-h> :tabp <Return>
" Ctrl + l goes to the tab to the right.
noremap <C-l> :tabn <Return>

" Bind Ctrl + t to opening new tabs.
noremap <C-t> :tabnew <Return>

" Ctrl + j goes down a window.
noremap <C-j> <C-w>j
" Ctrl + k goes up a window.
noremap <C-k> <C-w>k

" Make Ctrl+B do exactly the same thing as Ctrl+U.
nnoremap <C-B> <C-U>

" Map Ctrl-B to delete to the end of line in insert mode.
inoremap <C-b> <Esc>lDa

" Movement left and right in insert mode with Ctrl.
inoremap <C-l> <Esc>la
inoremap <C-h> <Esc>i

" Disable Ex mode, because fuck Ex mode.
noremap Q <Nop>
" Use semicolons for what colon does.
noremap ; :

" Bind keys for moving between warnings.
nmap <silent> , <Plug>(ale_previous_wrap)
nmap <silent> m <Plug>(ale_next_wrap)

" --- Function key bindings in order ---

function! startup#keybinds#RedrawSearch() abort
    if get(g:, 'f3_redraw') is# 'ale'
        ALERepeatSelection
    else
        copen
    endif
endfunction

function! startup#keybinds#SwitchToProjectRoot() abort
    let s:old_search_cwd = getcwd()
    let l:dir = finddir('.git/..', expand('%:p:h').';')

    if !empty(l:dir)
        execute 'cd ' . fnameescape(l:dir)
    endif
endfunction

function! startup#keybinds#SwitchBackToOldCwd() abort
    execute 'cd ' . fnameescape(s:old_search_cwd)
endfunction

command! -nargs=+ Grep let g:f3_redraw = 'grep' | call startup#keybinds#SwitchToProjectRoot() | execute 'silent grep! <args>' | cwindow | call startup#keybinds#SwitchBackToOldCwd()

" Bind F1 to showing details of ALE errors.
noremap <F1> :ALEDetail<CR>
" Toggle the project NERD tree with F2
noremap <F2> :ToggleNERDTree<CR>
" Search for files in the project with Ctrl+H
noremap <F3> :call startup#keybinds#RedrawSearch()<CR>
" Map F4 to copying the current filename to the clipboard.
noremap <F4> :call startup#keybinds#CopyNameToClipboard()<CR>
nmap <F5> <Plug>(ale_find_references)
" Use Vim's built in grep with ripgrep to search in files.
noremap <C-f> :Grep<Space>
" Use ctrlp to fuzzy find files.
noremap <C-p> :CtrlP<Return>
" Bind F7 To recording speech with vim-speech.
" noremap <silent> <F7> :SpeechToggle<CR>
" Bind F8 to fixing problems with ALE
nmap <F8> <Plug>(ale_fix)
inoremap <F8> <C-c><Plug>(ale_fix)

" Use Ctrl+y to go to the definition of something.
nmap <C-y> <Plug>(ale_go_to_definition)

if has('syntax')
    " Use F12 to resync syntax from the start.
    noremap <F12> <Esc>:syntax sync fromstart<CR>
    inoremap <F12> <C-o>:syntax sync fromstart<CR>
endif

function! startup#keybinds#CopyNameToClipboard() abort
    let l:filename = expand('%:p')

    " Look through a configured array of prefixes to remove, and remove
    " them from the filename if any match.
    for l:regex in g:path_remove_regex_list
        let [l:match, l:start, l:end] = matchstrpos(l:filename, l:regex)

        if !empty(l:match)
            let l:filename = l:start > 0
            \   ? l:filename[: l:start - 1] . l:filename[l:end :]
            \   : l:filename[l:end :]

            break
        endif
    endfor

    let l:text = l:filename

    if &filetype =~# 'python'
        let l:info = python_tools#cursor_info#GetInfo()

        if !empty(get(l:info, 'class', ''))
            let l:text .= '::' . l:info.class
        endif

        if !empty(get(l:info, 'def', ''))
            let l:text .= '::' . l:info.def
        endif
    endif


    let @+ = l:text
    echo 'Filename and function name copied to clipboard'
endfunction

" Make pressing Enter accept a completion entry.
function! SmartEnter()
    if pumvisible()
        return "\<C-y>"
    endif

    return "\<CR>"
endfunction

" Use Tab and Shift+Tab for either completion or SnipMate.
function! SmartTab() abort
    if pumvisible()
        let l:keys = "\<C-n>"

        if get(b:, 'ale_last_completion_count') is 1
            let l:keys .= "\<Left>\<Right>"
        endif

        return l:keys
    endif

    return snipMate#TriggerSnippet()
endfunction

function! SmartShiftTab() abort
    if pumvisible()
        return "\<C-p>"
    endif

    return snipMate#BackwardsSnippet()
endfunction

function! SmartInsertCompletion() abort
    if pumvisible()
        return "\<C-n>"
    endif

    return "\<C-c>a\<C-n>"
endfunction

inoremap <silent> <CR> <C-R>=SmartEnter()<CR>
inoremap <silent> <Tab> <C-R>=SmartTab()<CR>
inoremap <silent> <S-Tab> <C-R>=SmartShiftTab()<CR>
inoremap <silent> <C-n> <C-R>=SmartInsertCompletion()<CR>

" Close split windows just by pressing 'q', but record macros if there is only
" one window open.
"
" I never record macros while working with split windows.
function! startup#keybinds#CloseSplitWindowsWithQ() abort
    let l:tab_info = gettabinfo(tabpagenr())[0]

    if len(l:tab_info.windows) > 1
        " Close the terminal window instead of the current one.
        for l:win_id in l:tab_info.windows
            let l:bufnr = getwininfo(l:win_id)[0].bufnr
            let l:bufname = expand('#' . l:bufnr . ':p')

            if l:bufname =~# '^!/bin'
                execute 'bwipeout ' . l:bufnr
                return
            endif
        endfor

        :q
    else
        call feedkeys('q', 'n')
    endif
endfunction

nnoremap <silent> q :call startup#keybinds#CloseSplitWindowsWithQ()<CR>

" Run macros with \, which is easier to press.
nnoremap \ @
" Repeat macros with \\ too.
nnoremap \\ @@

" Bind // so it sets up an expression for replacing the previous match.
noremap // :%s//

noremap <silent> gs :SplitjoinSplit<CR>:ALEFix<CR>
noremap <silent> gj :SplitjoinJoin<CR>

" Quit terminals with just 'q'
tnoremap q <C-w>N:q!<CR>

function! startup#keybinds#Init() abort
endfunction
