" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" FIXME: This file is far from complete.

" Strings
syn region pekString start=+'+ end=+'+ contains=pekEscape
syn region pekString start=+"+ end=+"+ contains=pekEscape

" String Escapes
syn match pekEscape +\\[abfnrtv'"\\]+ contained

" Single line comments.
syn match pekComment +#.*$+ contains=pekTodo,@Spell
syn match pekComment +//.*$+ contains=pekTodo,@Spell

" Multi-line comments
syn region pekComment start=+/\*+ end=+\*/+ contains=pekTodo,@Spell

syn keyword pekTodo FIXME NOTE NOTES TODO XXX contained

" Rules for all
syn keyword pekRule INCLUDE

" Key groups
syn keyword pekGroup Global MoveResize InputDialog Menu

" autoproperties groups
syn keyword pekGroup Require Property
" autoproperties rules
syn keyword pekRule Sticky Shaded MaximizedVertical MaximizedHorizontal Iconified Border Titlebar FrameGeometry
syn keyword pekRule ClientGeometry Layer Workspace Skip Fullscreen PlaceNew FocusNew Focusable CfgDeny
syn keyword pekRule ApplyOn Title Role Group Templates

" menu rules
syn keyword pekRule Submenu Entry Actions Icon Separator

hi def link pekString String
hi def link pekComment Comment
hi def link pekTodo Todo
hi def link pekGroup Function
hi def link pekRule Keyword

let b:current_syntax = "pekwm"

" vim: ts=8
