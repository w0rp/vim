let b:ale_lua_language_server_executable = $HOME . '/git/lua-language-server/bin/lua-language-server'

let b:ale_linters = ['luac', 'luacheck', 'lua-language-server']
let b:ale_completion_excluded_words = [
\   'elseif',
\   'else',
\]

if expand('%:p') =~# '^/usr/share/nvim'
    let b:ale_lua_luacheck_options = '--globals vim'
endif

if expand('%:p') =~# 'ale/test/lua'
    let b:ale_lua_luacheck_options = '--globals vim --std'

    let s:conf = ale#path#FindNearestFile(bufnr(''), '.luarc.json')
    let s:dir = ale#path#Dirname(s:conf)

    let b:test_command = ale#command#CdString(s:dir)
    \   . ale#Escape($HOME . '/.luarocks/bin/busted')
    \   . ' -m ''../../lua/?.lua;../../lua/?/init.lua'''
    \   . ' ' . ale#Escape(substitute(expand('%:p'), '^' . s:dir . '/', '', ''))
endif
