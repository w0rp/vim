# w0rp's Vim files

This repository contains w0rp's Vim files. They aren't for everyone, but he sure likes them.

## Installation on Linux

Assuming you are using Ubuntu/Debian.

```bash
sudo apt install vim git
git clone --recursive https://github.com/w0rp/vim.git ~/.vim
```

That's it. Now you are using Vim like w0rp on Linux.

## Installation on Windows

1. Install git: https://git-scm.com/download/win
2. Install vim: https://www.vim.org/download.php#pc
3. Do this:

```bash
git clone --recursive https://github.com/w0rp/vim.git ~/vimfiles
```

That's it. Now you are using Vim like w0rp on Windows.

## Installation on Mac OSX

1. Install git: https://git-scm.com/download/mac
2. Install MacVim: https://macvim-dev.github.io/macvim/
3. Do this:

```bash
git clone --recursive https://github.com/w0rp/vim.git ~/.vim
```

Open System Preferences > Keyboard > Shortcuts > App Shortcuts

Add MacVim as an application, and you want to redefine ridiculous keybinds
for at least the following menu items.

```
Close
Close Window
Find...
Hide MacVim
List Errors
Make
New Window
Open...
Print
Quit MacVim
```

`gvimrc` in the Vim configuration files maps Command keys to Ctrl keys in Vim,
so you can treat Command keybinds as if they are Ctrl keybinds.
