" Make the VIM happen.
set nocompatible

" We must replace the runtimepath to make everything work.
set runtimepath=~/.vim,$VIM/vimfiles/,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after

" Prefer unix format for files.
set ffs=unix,dos

if has("unix")
    " Reset the terminal to work around stupid bullshit
    set term=linux
    set t_Co=256
else
    " Windows fun times!

    " set the 'cpoptions' to its Vim default
    if 1 " only do this when compiled with expression evaluation
      let s:save_cpo = &cpoptions
    endif
    set cpo&vim

    " set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for MS-Windows
    behave mswin

    " backspace and cursor keys wrap to previous/next line
    set backspace=indent,eol,start whichwrap+=<,>,[,]

    if has('gui_running')
        " For CTRL-V to work autoselect must be off.
        set guioptions-=a
    endif
endif

if has('gui_running')
    " gvim specific settings.
    "
    " CTRL-A is Select all
    " This works better than the default Windows script.
    noremap <C-A> ggVG
    inoremap <C-A> <Esc>ggVG
    cnoremap <C-A> <Esc>ggVG
    onoremap <C-A> <Esc>ggVG
    snoremap <C-A> <Esc>ggVG
    xnoremap <C-A> <Esc>ggVG

    " CTRL-C and CTRL-Insert are Copy
    vnoremap <C-C> "+y
    vnoremap <C-Insert> "+y

    " CTRL-X and SHIFT-Del are Cut
    vnoremap <C-X> "+x
    vnoremap <S-Del> "+x

    " CTRL-V and SHIFT-Insert are Paste
    imap <C-V> <Esc> "+gPi
    imap <S-Insert> <C-V>

    " Set colour scheme
    colorscheme darkspectrum

    " remove menu bar from gvim
    set guioptions-=m

    " remove toolbar from gvim
    set guioptions-=T

    " Use console dialogs instead of dialog windows.
    set guioptions+=c

    " Make copy and paste work and not be shit.
    set guioptions+=a

    if v:version > 703
        " This makes copy and paste also work better.
        set clipboard=unnamedplus
    endif

    " Always show the tab bar.
    set showtabline=2

    " Make only filenames appear in gvim tabs.
    set guitablabel=%!expand(\"\%:t\")

    " Set maximum number of tabs to 20.
    set tabpagemax=20
else
    " When the GUI is not running...

    " Use simple highlighting.
    set bg=dark

    set nospell
endif

" Bind Ctrl + Tab to switch tabs
map <C-tab> :tabn <Return>
imap <C-tab> <Esc> :tabn <Return>

" Ctrl + Shift + Tab to go back.
map <C-S-tab> :tabp <Return>
imap <C-S-tab> <Esc> :tabp <Return>

map <C-E> d?[A-Z]<Return>
imap <C-E> <Esc> d?[A-Z]<Return>i

" Bind Ctrl + t to opening new tabs.
noremap <C-t> :tabnew <Return>

" Enable plugins.
filetype plugin on

" Enable syntax highlighting by default.
if has("syntax")
    syntax on
endif

" Enable the status line at all times
set laststatus=2

" Enable 50 lines of command history
set history=50

" Enable the ruler
set ruler

" Set backspaces
set backspace=indent,eol,start

" Avoids updating the screen before commands are completed
" set lazyredraw

set scrolloff=999

" Make Ctrl+B do exactly the same thing as Ctrl+U.
nnoremap <C-B> <C-U>

" Default to spaces instead of tabs
set expandtab

" Set tab width to 4.
set tabstop=4
set shiftwidth=4
" Setting this will make backspace delete space indents
set softtabstop=4

" Autoindent
set autoindent

" Make the relative path automatic.
set autochdir

" Put all special files in the right place
set backupdir=~/.vimcrap/backup//
set directory=~/.vimcrap/swp//

" Draw tabs and trailing spaces.
set listchars=tab:>~
set list

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" Map Ctrl-B to delete to the end of line in insert mode.
imap <C-b> <Esc>lDa

" Movement left and right in insert mode with Ctrl.
inoremap <C-l> <Esc>la
inoremap <C-h> <Esc>i

inoremap <C-n> <C-x><C-o>
inoremap <C-p> <C-x><C-o>

" Change the status based on mode
au InsertEnter * hi StatusLine term=reverse ctermbg=5 guisp=Magenta
au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse

" Automatically set the title to the full path.
au BufEnter * set titlestring=%{expand(\"%:p\")}

" Use Blowfish for encryption, because it's awesome.
set cryptmethod=blowfish

" Enable persistent undo
set undodir=~/.vimcrap/undo//
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" Set the right margin.
set cc=80
" Automatically split words at the margin.
set wrap

" Disable automatic wrapping.
set textwidth=0

" Make shift-insert work like in Xterm (Nicked from archlinux.vim)
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Disable Ex mode, because fuck Ex mode.
map Q <Nop>

" Make :Q and :W work like :q and :w
command W w
command Q q

" viminfo settings
" '100 : Remember marks for 100 previously edited files.
" <50  : ???
" s10  : ???
" h    : ???
" "100 : Save 100 lines for each register
" :50  : Remember 50 lines of command history
" %    : Save and restore the buffer list.
set viminfo='100,<50,s10,h,\"100,:50,%

" Restore cursor positions for edited files.
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END


" Create directories if needed.
fun! RequireDirectory(directory)
    if !isdirectory(a:directory)
        call mkdir(a:directory)
    endif
endf

" Make the needed directories
call RequireDirectory(expand("~") . "/.vimcrap")
call RequireDirectory(expand("~") . "/.vimcrap/swp")
call RequireDirectory(expand("~") . "/.vimcrap/backup")
call RequireDirectory(expand("~") . "/.vimcrap/undo")

fun! OpenHpp()
    if expand("%:e") == "cpp"
        " Open hpp files in a split view when opening cpp files.
        new +res\ 12 %:r.hpp
    endif
endf

" Disable folding because it's annoying.
set nofoldenable

" Treat lzz files like cpp files.
au BufNewFile,BufRead *.lzz set filetype=cpp
" Treat JSON files like JavaScript files.
au BufNewFile,BufRead *.json set filetype=javascript

" .md is a markdown file.
au BufNewFile,BufRead *.md set filetype=markdown

"au VimEnter * RainbowParenthesesToggle
"au Syntax * RainbowParenthesesLoadRound
"au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces

" Use MySQL as the filetype for sql files.
au BufRead *.sql set filetype=mysql

" Disable the sass syntax checker, because it's slow and crap.
let g:syntastic_enable_scss_sass_checker=0

" Use pep8 to check Python files.
let g:syntastic_python_checkers=['flake8']

" Disable syntax for large files.
autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | endif

let g:rainbow_conf = {
\   'guifgs': ['#3b81e7', '#dccb3e', '#de2020', '#0bff22'],
\   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\   'operators': '_,_'
\}

let g:rainbow_active = 1

" Make :lprev and :lnext work in Syntastic
let g:syntastic_always_populate_loc_list = 1

let g:syntastic_d_include_dirs = glob('~/.dub/packages/*/source', 1, 1) + glob('~/.dub/packages/*/src', 1, 1) + ['./source', './src']

