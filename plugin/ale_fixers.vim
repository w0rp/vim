" This file just lets g:ale_fixers be reloaded when it's changed here.
let g:ale_fixers = {
\   'help': [
\       'align_help_tags',
\   ],
\   'python': [
\       'remove_trailing_lines',
\       'isort',
\       'autopep8',
\   ],
\   'javascript': [
\       'eslint',
\   ],
\   'typescript': [
\       'eslint',
\   ],
\}
