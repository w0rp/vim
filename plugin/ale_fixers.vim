" This file just lets g:ale_fixers be reloaded when it's changed here.
let g:ale_fixers = {
\   'help': [
\       'align_help_tags',
\   ],
\   'javascript': [
\       'eslint',
\   ],
\   'typescript': [
\       'eslint',
\       'extra_ale_fixers#FixWeirdImportCommas',
\   ],
\   'ruby': [
\       'rubocop',
\   ],
\}
