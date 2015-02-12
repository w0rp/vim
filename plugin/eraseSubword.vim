" Description:  Erases one sub word before the cursor.
" Author:       Ilya Bobir <ilya@po4ta.com>
" Date:         18.09.2005 6:23:25
" Version:      4
"
" Makes <C-H> in insert mode delete one subword from a camel case word or one
" _ delimited subword before the cursor.
"
" Default mapping could be changed by setting g:EraseSubword_insertMap to the
" desired key.  Setting s:EraseSubword_insertMap to an empty string would
" remove default mapping at all.  Mapping could be changed later (for example
" in file type plugin or in some auto commands) using
" EraseSubword_setInsertMap function that takes one argument - new value for
" the g:EraseSubword_insertMap.  Empty value would disable plugin and any
" other value would add new mapping (old mapping would be removed).
"
" There is also a possibility to use buffer local mapping.  Than you probably
" want to set g:EraseSubword_insertMap to an empty string (so that there would
" be no global mapping) and then use EraseSubword_setlocalInsertMap in
" FileType auto command or BufNew, BufCreate and a like to set buffer local
" mapping.  EraseSubword_setlocalInsertMap uses same syntax as
" EraseSubword_insertMap - one argument that is a desired mapping or empty
" string to remove existing mapping.
"
"
" Work as follows:
"
" 1. If cursor is in the first column then if 'backspace' contains eol and
" current line is not the first line of the buffer current line is joined with
" the previous one.  Stop.
"
" 2. If a character to the left of the cursor is not in 'iskeyword' then all
" characters up to the start of the current line that is not in 'iskeyword'
" are deleted.  Stop.
"
" 3. If a character to the left of the cursor is in 'iskeyword' then
"
"   3.1. If there is one or more "_" characters to the left of the cursor then
"   remove them all.
"
"   3.2. If a character to the left of the cursor is an uppercase one then all
"   the uppercase characters that is in 'iskeyword' up to the start of the
"   current line is deleted.  Stop.
"
"   3.3. If a character to the left of the cursor is not an uppercase one then
"   erase all the 'iskeyword' characters up to the uppercase one or up to the
"   _.  If erasing was stopped on an uppercase character then erase one more
"   character.  Stop.
"
"
" Copyright (c) 2005
" Ilya Bobir <ilya@po4ta.com>
"
" We grant permission to use, copy modify, distribute, and sell this software
" for any purpose without fee, provided that the above copyright notice and
" this text are not removed.  We make no guarantee about the suitability of
" this software for any purpose and we are not liable for any damages
" resulting from its use.  Further, we are under no obligation to maintain or
" extend this software. It is provided on an "as is" basis without any
" expressed or implied warranty.
"

if exists("loaded_eraseSubword")
  finish
endif

let loaded_eraseSubword = 1

let s:cpo_save = &cpo
set cpo&vim

function s:Erase()
  let l = getline(".")
  let pos = col("'^") - 1

  " If we are at the start of the line this is a special case.
  if pos == 0
    if &backspace =~ 'eol' && line(".") > 1
      normal kgJ
      if l == ""
        startinsert!
      else
        startinsert
      endif
      return
    endif
    startinsert
    return
  endif

  " Start from character to the left of the cursor.
  let c = strpart(l, pos - 1, 1)
  " i would be a count of the characters that sould be erased.  From this
  " point on, one would be removed in any case.
  let i = 1
  if c !~ '\k'
    " Delete all the non word characters to the left
    while pos - i - 1 >= 0 && strpart(l, pos - i - 1, 1) !~ '\k'
      let i = i + 1
    endwhile
  else
    " Remove all the _
    if c == '_'
      while pos - i - 1 >= 0 && strpart(l, pos - i - 1, 1) == '_'
        let i = i + 1
      endwhile
    endif

    if pos - i - 1 >= 0 && strpart(l, pos - i - 1, 1) =~ '\k'
      let c = strpart(l, pos - i - 1, 1)
      " Regexps do not have a Unicode uppercase class, don't they?
      if tolower(c) !=# c
        while pos - i - 1 >= 0
          let c = strpart(l, pos - i - 1, 1)
          if c !~ '\k' || tolower(c) ==# c
            break
          endif
          let i = i + 1
        endwhile
      else
        while pos - i - 1 >= 0
          let c = strpart(l, pos - i - 1, 1)
          if c !~ '\k' || c == '_'
            break
          endif
          if tolower(c) !=# c
            let i = i + 1
            break
          endif
          let i = i + 1
        endwhile
      endif
    endif
  endif

  if i > 1
    let i = i - 1
    exec "normal " . i . "Xx"
  else
    exec "normal x"
  endif

  if pos == strlen(l)
    startinsert!
  else
    startinsert
  endif

endfunction


if !exists("g:EraseSubword_insertMap")
  let g:EraseSubword_insertMap = "<C-J>"
endif

if g:EraseSubword_insertMap != ""
  execute "inoremap <silent> <unique> " . g:EraseSubword_insertMap . " <Esc>:call <SID>Erase()<CR>"
endif

function EraseSubword_setInsertMap(arg)
  if g:EraseSubword_insertMap != ""
    execute "iunmap " . g:EraseSubword_insertMap
  endif

  let g:EraseSubword_insertMap = a:arg

  if g:EraseSubword_insertMap != ""
    execute "inoremap <silent> <unique> " . g:EraseSubword_insertMap . " <Esc>:call <SID>Erase()<CR>"
  endif
endfunction

function EraseSubword_setlocalInsertMap(arg)
  if exists("b:EraseSubword_localInsertMap") && b:EraseSubword_localInsertMap != ""
    execute "iunmap <buffer> " . b:EraseSubword_localInsertMap
  endif

  let b:EraseSubword_localInsertMap = a:arg

  if b:EraseSubword_localInsertMap != ""
    execute "inoremap <buffer> <silent> <unique> " . b:EraseSubword_localInsertMap . " <Esc>:call <SID>Erase()<CR>"
  endif
endfunction

" restore 'cpo'
let &cpo = s:cpo_save
unlet s:cpo_save

