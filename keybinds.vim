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
command! -nargs=0 -bar Update if &modified
    \|    if empty(bufname('%'))
    \|        browse confirm write
    \|    else
    \|        confirm write
    \|    endif
    \|endif
noremap <silent> <C-S> :<C-u>Update<CR>
inoremap <c-s> <Esc><C-s>
cnoremap <c-s> <Esc>

" Bind Ctrl + Tab to switch tabs
noremap <C-tab> :tabn <Return>
inoremap <C-tab> <Esc> :tabn <Return>

" Ctrl + Shift + Tab to go back.
noremap <C-S-tab> :tabp <Return>
inoremap <C-S-tab> <Esc> :tabp <Return>

" Bind Ctrl + t to opening new tabs.
noremap <C-t> :tabnew <Return>

if has("syntax")
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

" Bind Ctrl + [ to captialising the previous word for cruise control.
inoremap <C-[> <Esc>gUiwwi
noremap <C-[> gUiww

" Disable Ex mode, because fuck Ex mode.
noremap Q <Nop>

" Bind keys for moving between warnings.
noremap <C-k> :PreviousError<Return>
noremap <C-j> :NextError<Return>

" Search for files in the project with Ctrl+H
noremap <C-h> :UniteWithProjectDir file_rec/async:<Return>:setlocal modifiable<Return>i
noremap <C-f> :UniteWithProjectDir grep<Return>
noremap <F3> :UniteResume<Return>

" Toggle the project NERD tree with F2
noremap <F2> :ToggleNERDTree<CR>

fun! CopyFilenameToClipboard()
    let l:current_filename = expand("%:p")

    " Look through a configured array of prefixes to remove, and remove
    " them from the filename if any match.
    for prefix in g:path_prefixes_to_trim
        if l:current_filename =~ '\V\^' . prefix
            let l:current_filename = l:current_filename[len(prefix):]
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