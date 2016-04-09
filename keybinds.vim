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

" Disable Ex mode, because fuck Ex mode.
noremap Q <Nop>

" Bind keys for moving between warnings.
noremap <C-S-k> :lprev <Return>
noremap <C-S-j> :lnext <Return>

" Search for files in the project with Ctrl+H
noremap <C-h> :UniteWithProjectDir file_rec/async:<Return>:setlocal modifiable<Return>i
noremap <C-f> :UniteWithProjectDir grep<Return>

" Toggle the project NERD tree with F2
noremap <F2> :ToggleNERDTree<CR>
