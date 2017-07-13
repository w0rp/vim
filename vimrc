" vint: -ProhibitSetNoCompatible
scriptencoding utf-8

" Make the VIM happen.
set nocompatible

" We must replace the runtimepath to make everything work.
set runtimepath=~/.vim,$VIM/vimfiles/,$VIMRUNTIME,$VIM/vimfiles/after

" Add a command for loading .vimrc completely.
command! ReloadVimrc source $MYVIMRC

let s:ag_opts='--nocolor --nogroup --hidden'
let s:ag_opts.=' --ignore=.git --ignore=.svn --ignore=.hg --ignore=.bzr'
let g:unite_source_rec_async_command=['ag'] + split(s:ag_opts) + ['-g', '']

let &runtimepath.=',~/.vim/bundle/vim-misc'
let &runtimepath.=',~/.vim/bundle/vim-reload'
let &runtimepath.=',~/.vim/bundle/unite'
let &runtimepath.=',~/.vim/bundle/nerdtree'
let &runtimepath.=',~/.vim/bundle/nerdtree-project'
let &runtimepath.=',~/.vim/bundle/vim-pug'
let &runtimepath.=',~/.vim/bundle/typescript-vim'
let &runtimepath.=',~/.vim/bundle/vim-autopep8'
let &runtimepath.=',~/.vim/bundle/vim-addon-mw-utils'
let &runtimepath.=',~/.vim/bundle/tlib_vim'
let &runtimepath.=',~/.vim/bundle/snipmate'
let &runtimepath.=',~/.vim/bundle/vim-airline'
let &runtimepath.=',~/.vim/bundle/vim-airline-themes'
let &runtimepath.=',~/.vim/bundle/typescript-vim'
let &runtimepath.=',~/.vim/bundle/ale'
let &runtimepath.=',~/.vim/bundle/vader'
let &runtimepath.=',~/.vim/bundle/python-tools'
" Set our after directory after everything.
let &runtimepath.=',~/.vim/after'

filetype plugin on

" Automatically regenerate help tags.
silent! helptags ALL

" Prefer unix format for files.
set fileformats=unix,dos

if has('unix')
    if !has('gui_running')
        " Reset the terminal to work around stupid bullshit
        set term=linux
        set t_Co=256
    endif
else
    " Windows fun times!

    " set the 'cpoptions' to its Vim default
    if 1 " only do this when compiled with expression evaluation
      let s:save_cpo = &cpoptions
    endif
    set cpoptions&vim

    " set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for MS-Windows
    behave mswin

    " backspace and cursor keys wrap to previous/next line
    set backspace=indent,eol,start whichwrap+=<,>,[,]
endif

set nospell

if has('gui_running')
    " gvim specific settings.

    " Set colour scheme
    colorscheme darkspectrum

    if has('osx')
        set guifont=Inconsolata\ for\ Powerline:h18
    else
        set guifont=Inconsolata\ for\ Powerline\ Medium\ 18
    endif

    " remove menu bar from gvim
    set guioptions-=m

    " remove toolbar from gvim
    set guioptions-=T

    " Use console dialogs instead of dialog windows.
    set guioptions+=c

    if has('unix')
        " Add autoselect so copy and paste will work.
        set guioptions+=a
    else
        " Remove autoselect on other OSes.
        set guioptions+=a
    endif

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
    set background=dark
endif

" Enable syntax highlighting by default.
if has('syntax')
    syntax on

    " Reduce processing for syntax highlighting to make it less of a pain.
    syntax sync minlines=200
    syntax sync maxlines=500
    set synmaxcol=400
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
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

" Draw tabs and trailing spaces.
set listchars=tab:>~
set list

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" Automatically set the title to the full path.
set titlestring=%(\ %{expand(\"%:p\")}\ %a%)

" Use Blowfish for encryption, because it's awesome.
set cryptmethod=blowfish

" Enable persistent undo
set undodir=~/.vim/.undo//
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" Automatically re-open files after they have changed without prompting.
" This can be a little more destructive, but a lot less annoying.
set autoread

" Set the right margin.
set colorcolumn=80
" Automatically split words at the margin.
set wrap

" Disable automatic wrapping.
set textwidth=0

" Make :Q and :W work like :q and :w
command! W w
command! Q q

" viminfo settings
" '100 : Remember marks for 100 previously edited files.
" <50  : ???
" s10  : ???
" h    : ???
" "100 : Save 100 lines for each register
" :50  : Remember 50 lines of command history
set viminfo='100,<50,s10,h,\"100,:50

fun! OpenHpp()
    if expand('%:e') ==# 'cpp'
        " Open hpp files in a split view when opening cpp files.
        new +res\ 12 %:r.hpp
    endif
endf

" Disable folding because it's annoying.
set nofoldenable

" Switch to the directory files are in automatically.
set autochdir

" Do not echo the mode, airline will display it instead.
set noshowmode

set shortmess=filnxtToOc

" --- rainbow parens settings ---

let g:rainbow_conf = {
\   'guifgs': ['#3b81e7', '#dccb3e', '#de2020', '#0bff22'],
\   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\   'operators': '_,_'
\}
let g:rainbow_active = 1

" --- Unite.vim settings ---

" Use ag for search inside files.
let g:unite_source_grep_command=expand('<sfile>:p:h') . '/ag-search-command'
let g:unite_source_grep_default_opts=''
let g:unite_source_grep_recursive_opt=''

" Allow up to 2000 results to be displayed for grep.
:call unite#custom#source('grep', 'max_candidates', 2000)

" Who the fuck knows what this does, but it makes things less slow.
let g:unite_redraw_hold_candidates = 50000

" --- NERDTree settings ---

" Close NERDTree automatically after opening a file with it.
let g:NERDTreeQuitOnOpen = 1
" Use a single click for opening things in NERDTree
let g:NERDTreeMouseMode = 3
let g:NERDTreeMapActivateNode = '<Space>'
let g:NERDTreeIgnore = [
\   '\.pyc$',
\   '^__pycache__$',
\]

" --- vim-airline settings ---

" Disable the spelling marker for airline.
let g:airline_detect_spell = 0
let g:airline_theme = 'luna'

if has('gui_running')
    " Use fancy separators for airline in GVim
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
else
    " Don't use fancy symbols, which render like shit in terminals
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
endif

let g:airline_powerline_fonts = 1
" Disable the airline section which shows the file encoding mode.
let g:airline_section_y = '%{python_tools#statusline#GetStatus()}'
" Show just the line and column number in section z
let g:airline_section_z = '%l:%v'
let g:airline#extensions#ale#enabled = 1

" Use single characters for modes.
let g:airline_mode_map = {
\   '__' : '-',
\   'n'  : 'N',
\   'i'  : 'I',
\   'R'  : 'R',
\   'c'  : 'C',
\   'v'  : 'V',
\   'V'  : 'V',
\   '' : 'V',
\   's'  : 'S',
\   'S'  : 'S',
\   '' : 'S',
\}

" --- ALE settings ---
"
" Disable ALE warnings about trailing whitespace.
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_maximum_file_size = 1024 * 1024
let g:ale_completion_enabled = 1
let g:ale_linters = {
\   'html': [],
\   'javascript': ['eslint'],
\   'python': ['flake8'],
\}

" --- python-tools settings ---

" Don't run migrations for pytest runs in python_tools
let g:python_tools_pytest_no_migrations = 1

" --- Extra custom settings ---
let g:path_prefixes_to_trim = []

source ~/.vim/keybinds.vim
source ~/.vim/autocmd.vim

" Warn about not being able to write to .viminfo, which messes up restoring
" the cursor position when editing.
let s:info_filename = expand('~/.viminfo')

if !empty(glob(s:info_filename)) && !filewritable(s:info_filename)
    echoerr 'The .viminfo file cannot be written to!'
endif
