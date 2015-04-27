setlocal cc=80

" Set up the keybinds for headings
map <buffer> <C-j>- yypVr-o
map <buffer> <C-j>= yypVr=o
map <buffer> <C-j>_ yypVr_o

imap <buffer> <C-j>- <Esc>yypVr-o
imap <buffer> <C-j>= <Esc>yypVr=o
imap <buffer> <C-j>_ <Esc>yypVr_o

if has('gui_running')
    setlocal spell
endif

