" This script holds all keybinding settings.

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
vnoremap <C-C> "+y
snoremap <C-C> <ESC>gv"+y<ESC>

" CTRL-X is cut to the clipboard
vnoremap <C-X> "+x

" CTRL-V pastes from the clipboard
noremap <C-V> "+gPk$
inoremap <C-V> <Esc>"+gPk$
cnoremap <C-V> <C-R>+

" CTRL-S Saves the file.
noremap <silent> <C-S> :w<CR>
vnoremap <silent> <C-S> <C-C>:w<CR>
inoremap <silent> <C-S> <C-C>:w<CR>

" Quit files by typing fjfj quickly, which requires less stretching.
noremap fjfj :q<CR>

" Make using Ctrl+C do the same as Escape, to trigger autocmd commands
inoremap <C-c> <Esc>

" Bind gV so we can re-select pasted text.
nnoremap <expr> gV "`[".getregtype(v:register)[0]."`]"

" Bind Ctrl + Tab to switch tabs
noremap <C-tab> :tabn <Return>
noremap <Tab> :tabn <Return>
inoremap <C-tab> <Esc> :tabn <Return>
" Ctrl + l goes to the tab to the right.
noremap <C-l> :tabn <Return>

" Ctrl + Shift + Tab to go back.
noremap <C-S-tab> :tabp <Return>
inoremap <C-S-tab> <Esc> :tabp <Return>
" Ctrl + h goes to the tab to the left.
noremap <C-h> :tabp <Return>

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

" Bind F1 to showing details of ALE errors.
noremap <F1> :ALEDetail<CR>
" Toggle the project NERD tree with F2
noremap <F2> :ToggleNERDTree<CR>
" Search for files in the project with Ctrl+H
noremap <F3> :UniteResume<Return>:execute "normal \<Plug>(unite_redraw)"<Return>
" Map F4 to copying the current filename to the clipboard.
noremap <F4> :call startup#keybinds#CopyNameToClipboard()<CR>
noremap <F5> :UniteWithProjectDir grep -no-empty<Return>
noremap <C-f> :UniteWithProjectDir grep -no-empty<Return>
noremap <F6> :UniteWithProjectDir file_rec/async:<Return>:setlocal modifiable<Return>i

" Bind F8 to fixing problems with ALE
nmap <F8> <Plug>(ale_fix)

if has('syntax')
    " Use F12 to resync syntax from the start.
    noremap <F12> <Esc>:syntax sync fromstart<CR>
    inoremap <F12> <C-o>:syntax sync fromstart<CR>
endif

function! startup#keybinds#CopyNameToClipboard() abort
    let l:current_filename = expand('%:p')

    " Look through a configured array of prefixes to remove, and remove
    " them from the filename if any match.
    for l:prefix in g:path_prefixes_to_trim
        if l:current_filename =~ '\V\^' . l:prefix
            let l:current_filename = l:current_filename[len(l:prefix):]
            " Remove additional leading slashes if removing prefixes.
            let l:current_filename = substitute(l:current_filename, '^/*', '', '')

            break
        endif
    endfor

    let l:text = l:current_filename

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
        return "\<C-n>"
    endif

    return snipMate#TriggerSnippet()
endfunction

function! SmartShiftTab() abort
    if pumvisible()
        return "\<C-p>"
    endif

    return snipMate#BackwardsSnippet()
endfunction

inoremap <silent> <CR> <C-R>=SmartEnter()<CR>
inoremap <silent> <Tab> <C-R>=SmartTab()<CR>
inoremap <silent> <S-Tab> <C-R>=SmartShiftTab()<CR>

" Close split windows just by pressing 'q', but record macros if there is only
" one window open.
"
" I never record macros while working with split windows.
function! CloseSplitWindowsWithQ() abort
    let l:tab_info = gettabinfo(tabpagenr())[0]

    if len(l:tab_info.windows) > 1
        :q
    else
        call feedkeys('q', 'n')
    endif
endfunction

nnoremap <silent> q :call CloseSplitWindowsWithQ()<CR>

" Run macros with \, which is easier to press.
nnoremap \ @
" Repeat macros with \\ too.
nnoremap \\ @@

" Bind // so it sets up an expression for replacing the previous match.
noremap // :%s//

function! startup#keybinds#Init() abort
endfunction
