" vint: -ProhibitSetNoCompatible

" Set a variable to prevent some parts of vimrc from being run again
" when reloading it.
let g:vimrc_loaded = get(g:, 'vimrc_loaded', 0)

set encoding=utf-8
scriptencoding utf-8

" Make the VIM happen.
set nocompatible

if has('win32')
    let $VIMHOME = expand('~\vimfiles')
else
    let $VIMHOME = expand('~/.vim')
endif

" We must replace the runtimepath to make everything work.
if !g:vimrc_loaded
    set runtimepath=$VIMHOME,$VIM/vimfiles/,$VIMRUNTIME,$VIM/vimfiles/after
endif

" Set our after directory after everything.
if !g:vimrc_loaded
    let &runtimepath.=',' . $VIMHOME . '/after'
endif

filetype plugin on

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

    let s:colorscheme = ''
    redir => s:colorscheme
        silent colorscheme
    redir end

    if s:colorscheme !~# 'darkspectrum'
        " Set colour scheme
        colorscheme darkspectrum
    endif

    if has('osx') || has('win32')
        " Windows - http://levien.com/type/myfonts/inconsolata.html
        set guifont=Inconsolata:h16:cANSI:qDRAFT
    else
        set guifont=Inconsolata\ 16
    endif

    " Set guioptions
    " No 'm' removes the menu bar
    " No 'T' removes the toolbar
    " 'c' uses console dialogs instead of windows.
    " 'a' uses autoselect
    set guioptions=egirLtca

    if v:version > 703
        " This makes copy and paste also work better.
        set clipboard=unnamedplus
    endif

    " Always show the tab bar.
    set showtabline=2

    function! GetTabLabel() abort
        " TODO Detect if a NerdTree window is open split with a file, and show
        " the name of the file in the tab instead.
        let l:full_name = expand('%:p')

        if empty(l:full_name)
            return ''
        endif

        let l:buffer = bufnr('')
        " Get the buffer names for all windows.
        let l:name_list = map(
        \   filter(getwininfo(), 'v:val.bufnr isnot l:buffer'),
        \   'expand(''#'' . v:val.bufnr . '':p'')',
        \)
        let l:depth = 1

        while 1
            let l:dir = fnamemodify(l:full_name, repeat(':h', l:depth))
            let l:depth += 1
            let l:filename = l:full_name[len(l:dir) + 1:]
            let l:lower_filename = tolower(l:filename)

            if len(l:dir) <= 1
                break
            endif

            let l:match_found = 0

            for l:other_name in l:name_list
                if tolower(l:other_name)[-len(l:lower_filename):] is? l:lower_filename
                    let l:match_found = 1
                    break
                endif
            endfor

            if !l:match_found
                break
            endif
        endwhile

        return l:filename
    endfunction

    " Make only filenames appear in gvim tabs.
    set guitablabel=%{GetTabLabel()}

    " Set maximum number of tabs to 20.
    set tabpagemax=20

    " Use right click for showing a popup menu.
    set mousemodel=popup_setpos

    " Remove some menu items we don't want.
    silent! aunmenu PopUp.Select\ Word
    silent! aunmenu PopUp.Select\ Sentence
    silent! aunmenu PopUp.Select\ Paragraph
    silent! aunmenu PopUp.Select\ Line
    silent! aunmenu PopUp.Select\ Block
    silent! aunmenu PopUp.Select\ Blockwise
    silent! aunmenu PopUp.Select\ All
else
    " When the GUI is not running...

    " Use simple highlighting.
    set background=dark
endif

" Enable syntax highlighting by default.
if has('syntax')
    if !g:vimrc_loaded
        syntax on
    endif

    " Reduce processing for syntax highlighting to make it less of a pain.
    syntax sync minlines=2000
    syntax sync maxlines=5000
    set synmaxcol=400
    set redrawtime=4000
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
set backupdir=$VIMHOME/.backup//
set directory=$VIMHOME/.swp//

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
set undodir=$VIMHOME/.undo//
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" Automatically re-open files after they have changed without prompting.
" This can be a little more destructive, but a lot less annoying.
set autoread

" Set the right margin.
set colorcolumn=81
" Let long lines run on past the margin.
set nowrap

" Disable automatic wrapping.
set textwidth=0

" Make some capitalised commands work the same as their normal forms.
command! W w
command! Q q
command! -bang Qall qall<bang>

" Make completion smarter.
set ignorecase
set smartcase
set completeopt=menu,preview,noselect

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

" Keep buffers open after closing them, for the benefit of jumping.
set hidden

" Do not echo the mode, lightline will display it instead.
set noshowmode

set shortmess=filnxtToOc

" Find search matches as they are typed.
set incsearch

" Configure the delay for custom chained keybinds.
set timeoutlen=250

" --- syntax file settings ---

let g:c_syntax_for_h = 1
let g:go_highlight_trailing_whitespace_error = 0

" --- rainbow parens settings ---

let g:rainbow_conf = {
\   'guifgs': ['#3b81e7', '#dccb3e', '#de2020', '#0bff22'],
\   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\   'operators': '_,_'
\}
let g:rainbow_active = 1

" --- Vim grep settings ---

set grepprg=rg\ --vimgrep\ --smart-case\ --follow

" --- NERDTree settings ---

" Close NERDTree automatically after opening a file with it.
let g:NERDTreeQuitOnOpen = 1
" Use a single click for opening things in NERDTree
let g:NERDTreeMouseMode = 3
let g:NERDTreeMapActivateNode = '<Space>'
let g:NERDTreeIgnore = [
\   '\.pyc$',
\   '^junit\.xml$',
\   '^__pycache__$',
\]


" --- vim-lightline settings ---
let g:lightline = {
\   'mode_map': {
\       'n': 'N',
\       'i': 'I',
\       'R': 'R',
\       'v': 'V',
\       'V': 'V',
\       "\<C-v>": 'VV',
\       'c' : 'C',
\       's' : 'S',
\       'S' : 'S-LINE',
\       "\<C-s>": 'S-BLOCK',
\       't': 'TERMINAL',
\   },
\   'active': {
\       'left': [
\           ['mode', 'paste'],
\           ['readonly', 'filename', 'modified'],
\       ],
\       'right': [
\           ['lineinfo'],
\           ['python_status', 'javascript_status', 'filetype'],
\       ],
\   },
\   'component_function': {
\       'python_status': 'python_tools#statusline#GetStatus',
\       'javascript_status': 'js_tools#GetStatus',
\   },
\}


" --- ALE settings ---
"
" Disable ALE warnings about trailing whitespace.
highlight ALEErrorSign ctermfg=9 ctermbg=9 guifg=Red guibg=Red
highlight ALEWarningSign ctermfg=11 ctermbg=11 guifg=#FFD166 guibg=#FFD166
highlight ALEInfoSign ctermfg=4 ctermbg=4 guifg=#005f87 guibg=#005f87
highlight SignColumn term=standout ctermfg=11 ctermbg=8 guifg=#efefef guibg=#3A3A3A
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_maximum_file_size = 1024 * 1024
let g:ale_completion_enabled = 1
let g:ale_code_actions_enabled = 1
let g:ale_set_balloons_legacy_echo = 1
let g:ale_c_parse_compile_commands = 1
let g:ale_lsp_suggestions = 0
let g:ale_save_hidden = 1

" ALE options for specific file patterns.
let g:ale_pattern_options_enabled = 1
let g:ale_pattern_options = {
\   'ale/doc/.*.txt$': {
\       '&modifiable': 1,
\       '&readonly': 0,
\   },
\   'site-packages/.*$': {
\       'ale_enabled': 0,
\       '&modifiable': 0,
\   },
\   '\v\.min\.(js|css)$': {
\       'ale_linters': [],
\       'ale_fixers': [],
\   },
\   'node_modules': {
\       'ale_fixers': [],
\   },
\}

" Options for different linters.
let g:ale_python_mypy_ignore_invalid_syntax = 1
let g:ale_python_mypy_options = '--incremental'
let g:ale_typescript_tslint_ignore_empty_files = 1
let g:ale_set_balloons = has('gui_running') ? 'hover' : 0

" Use newer clang versions where available.
if executable('clang-10')
    let g:ale_c_cc_executable = 'clang-10'
    let g:ale_cpp_cc_executable = 'clang++-10'
endif

if executable('clangd-10')
    let g:ale_c_clangd_executable = 'clangd-10'
    let g:ale_cpp_clangd_executable = 'clangd-10'
endif

if executable('clang-17')
    let g:ale_c_cc_executable = 'clang-17'
    let g:ale_cpp_cc_executable = 'clang++-17'
endif

if executable('clangd-17')
    let g:ale_c_clangd_executable = 'clangd-17'
    let g:ale_cpp_clangd_executable = 'clangd-17'
endif

" --- python-tools settings ---

" Don't run migrations for pytest runs in python_tools
let g:python_tools_pytest_no_migrations = 1

" --- Extra custom settings ---
let g:path_prefixes_to_trim = []

" --- Snippet settings ---

" Left brace for snippets.
let g:left_brace = "\n{"

" --- vim-speech settings ---

let $GOOGLE_APPLICATION_CREDENTIALS = $HOME
\   . '/content/application/speech-to-text-key.json'
let g:vim_speech_recording_status = '◉ REC'

" --- neutral settings ---
let g:neural = {
\   'source': {
\       'openai': {
\           'api_key': $OPENAI_API_KEY,
\       },
\   },
\}

" --- splitjoin settings ---
" Default mappings are disabled, and configured in keybinds.vim instead.
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping  = ''
let g:splitjoin_curly_brace_padding = 0
let g:splitjoin_trailing_comma = 1

" --- autoloaded extra code ---

let g:path_remove_regex_list = [
\   '^.*/ale/',
\   '^.*/git/obp-dev/[^/]*/',
\   '^.*/git/[^/]*/',
\]

" Run mostly blank init functions for loading extra settings, which can
" be automatically reloaded when edited.
call startup#keybinds#Init()
call startup#autocmd#Init()
call startup#spelling_corrections#Init()
call startup#common#Init()
call startup#command_abbreviations#Init()

" --- finishing touches ---

" Warn about not being able to write to .viminfo, which messes up restoring
" the cursor position when editing.
let s:info_filename = expand('~/.viminfo')

if !empty(glob(s:info_filename)) && !filewritable(s:info_filename)
    echoerr 'The .viminfo file cannot be written to!'
endif

" Automatically reload vimrc on save
augroup ReloadVimrcGroup
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

if !g:vimrc_loaded
    execute 'packloadall'

    " Automatically regenerate help tags.
    silent! helptags ALL

    " Regenerate the spelling file on startup.
    execute 'silent mkspell!'
    \   ' ' . fnameescape($VIMHOME . '/spell/en.utf-8.add.spl')
    \   ' ' . fnameescape($VIMHOME . '/spell/en.utf-8.add')
endif

" Set tags by default to use HTML.
call jspretmpl#register_tag('/\* *html *\*/', 'html')

let g:vimrc_loaded = 1
