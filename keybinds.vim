" This script holds all keybinding settings.

" CTRL-A is Select all
" This works better than the default Windows script.
noremap <C-A> ggVG
inoremap <C-A> <Esc>ggvG
vnoremap <C-A> <Esc>ggVG

" CTRL-C is copy to the clipboard
vnoremap <C-C> "+y

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

" Make using Ctrl+C to exit insert mode also send a keybind to switch back
" to latin mode in Anthy.
" inoremap <silent> <C-c> <C-c>:silent !xdotool key Ctrl+8<Return>

" Bind gV so we can re-select pasted text.
nnoremap <expr> gV "`[".getregtype(v:register)[0]."`]"

" Bind Ctrl + Tab to switch tabs
noremap <C-tab> :tabn <Return>
inoremap <C-tab> <Esc> :tabn <Return>

" Ctrl + Shift + Tab to go back.
noremap <C-S-tab> :tabp <Return>
inoremap <C-S-tab> <Esc> :tabp <Return>

" Bind Ctrl + t to opening new tabs.
noremap <C-t> :tabnew <Return>

if has('syntax')
    " Use F12 to resync syntax from the start.
    noremap <F12> <Esc>:syntax sync fromstart<CR>
    inoremap <F12> <C-o>:syntax sync fromstart<CR>
endif

" Make Ctrl+B do exactly the same thing as Ctrl+U.
nnoremap <C-B> <C-U>

" Map Ctrl-B to delete to the end of line in insert mode.
inoremap <C-b> <Esc>lDa

" Movement left and right in insert mode with Ctrl.
inoremap <C-l> <Esc>la
inoremap <C-h> <Esc>i

if has('gui_running')
    " Bind Ctrl + [ to captialising the previous word for cruise control.
    inoremap <C-[> <Esc>gUiwea
    noremap <C-[> gUiwe
endif

" Disable Ex mode, because fuck Ex mode.
noremap Q <Nop>

" Bind keys for moving between warnings.
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Search for files in the project with Ctrl+H
noremap <C-h> :UniteWithProjectDir file_rec/async:<Return>:setlocal modifiable<Return>i
noremap <C-f> :UniteWithProjectDir grep -no-empty<Return>
noremap <F3> :UniteResume<Return>:execute "normal \<Plug>(unite_redraw)"<Return>

" Toggle the project NERD tree with F2
noremap <F2> :ToggleNERDTree<CR>

fun! CopyFilenameToClipboard()
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

    let @+ = l:current_filename
    echo 'Filename copied to clipboard'
endf

" Map F4 to copying the current filename to the clipboard.
noremap <F4> :call CopyFilenameToClipboard()<CR>

" Set up keybinds for Snipmate, which doesn't work by itself for some reason.
inoremap <silent> <Tab> <C-R>=snipMate#TriggerSnippet()<CR>
inoremap <silent> <S-Tab> <C-R>=snipMate#BackwardsSnippet()<CR>
