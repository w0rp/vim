" Make the VIM happen.
set nocompatible

" We must replace the runtimepath to make everything work.
set runtimepath=~/.vim,$VIM/vimfiles/,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after

" Add a command for loading .vimrc completely.
command! ReloadVimrc source $MYVIMRC

let s:ag_opts='--nocolor --nogroup --hidden'
let s:ag_opts.=' --ignore=.git --ignore=.svn --ignore=.hg --ignore=.bzr'
" Use ag for searching for files themselves.
let g:unite_source_rec_async_command=['ag'] + split(s:ag_opts) + ['-g', '']

let &runtimepath.=',~/.vim/bundle/unite'
let &runtimepath.=',~/.vim/bundle/nerdtree'
let &runtimepath.=',~/.vim/bundle/nerdtree-project'
let &runtimepath.=',~/.vim/bundle/vim-pug'
let &runtimepath.=',~/.vim/bundle/vim-autopep8'
let &runtimepath.=',~/.vim/bundle/vim-addon-mw-utils'
let &runtimepath.=',~/.vim/bundle/tlib_vim'
let &runtimepath.=',~/.vim/bundle/snipmate'
let &runtimepath.=',~/.vim/bundle/ale'

filetype plugin on

" Prefer unix format for files.
set ffs=unix,dos

if has("unix")
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
    set cpo&vim

    " set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for MS-Windows
    behave mswin

    " backspace and cursor keys wrap to previous/next line
    set backspace=indent,eol,start whichwrap+=<,>,[,]
endif

if has('gui_running')
    " gvim specific settings.

    " Set colour scheme
    colorscheme darkspectrum

    " remove menu bar from gvim
    set guioptions-=m

    " remove toolbar from gvim
    set guioptions-=T

    " Use console dialogs instead of dialog windows.
    set guioptions+=c

    if has("unix")
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
    set bg=dark

    set nospell
endif

" Enable syntax highlighting by default.
if has("syntax")
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
set backupdir=~/.vimcrap/backup//
set directory=~/.vimcrap/swp//

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
set undodir=~/.vimcrap/undo//
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" Automatically re-open files after they have changed without prompting.
" This can be a little more destructive, but a lot less annoying.
set autoread

" Set the right margin.
set cc=80
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
" %    : Save and restore the buffer list.
set viminfo='100,<50,s10,h,\"100,:50,%

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

" Disable the sass syntax checker, because it's slow and crap.
let g:syntastic_enable_scss_sass_checker = 0

" Use pep8 to check Python files.
let g:syntastic_python_checkers = ['flake8']

let g:rainbow_conf = {
\   'guifgs': ['#3b81e7', '#dccb3e', '#de2020', '#0bff22'],
\   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\   'operators': '_,_'
\}

let g:rainbow_active = 1

" Make :lprev and :lnext work in Syntastic
let g:syntastic_always_populate_loc_list = 1
" Don't use a diff for pep8 auto-formatting, just do it.
let g:autopep8_disable_show_diff = 1

let g:syntastic_d_automatic_dub_include_dirs = 1
let g:syntastic_javascript_checkers = ['eslint']

" Tell Syntastic not to bother with Java files.
let g:syntastic_java_checkers=['']

" Use ag for search inside files.
let g:unite_source_grep_command='ag'
let g:unite_source_grep_default_opts=s:ag_opts . ' --line-numbers'
let g:unite_source_grep_recursive_opt=''

" Allow up to 2000 results to be displayed for grep.
:call unite#custom#source('grep', 'max_candidates', 2000)

" Who the fuck knows what this does, but it makes things less slow.
let g:unite_redraw_hold_candidates = 50000

set autochdir

" Close NERDTree automatically after opening a file with it.
let NERDTreeQuitOnOpen=1
let NERDTreeMapActivateNode='<Space>'

let NERDTreeIgnore = [
\   '\.pyc$',
\   '^__pycache__$',
\]

let g:path_prefixes_to_trim = []

source ~/.vim/keybinds.vim
source ~/.vim/autocmd.vim
