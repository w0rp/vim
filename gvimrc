" See: :e $VIMRUNTIME/menu.vim

if has('gui_macvim')
    set guifont=Inconsolata-Regular:h24

    execute 'macmenu Edit.Copy<Tab>"+y key=<Nop>'
    inoremap <D-c> <Esc>
    cnoremap <D-c> <Esc>

    " For these keybinds:
    " System Preferences -> Keyboard -> Shortcuts -> App Shortcuts
    " Redefine common shortcuts to enable these keybinds.

    " Command + h goes to the tab to the left.
    noremap <D-h> :tabp <Return>
    " Command + l goes to the tab to the left.
    noremap <D-l> :tabn <Return>

    " Command + C is copy to the clipboard
    vnoremap <D-c> y
    snoremap <D-c> <ESC>gv"+y<ESC>

    " Map common Ctrl keybinds to Command
    imap <D-n> <C-n>
    imap <D-q> <C-q>
    imap <D-w> <C-w>
    map <D-o> <C-o>
    map <D-w> <C-w>
    vmap <D-Space> <C-Space>
endif
