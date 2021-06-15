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
endif
