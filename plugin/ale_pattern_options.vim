let g:ale_pattern_options_enabled = 1
let g:ale_pattern_options = {
\   'python-to-typescript/python_to_typescript/.*$': {
\       'ale_linters': {'python': ['flake8', 'pylint']},
\   },
\   'site-packages/.*$': {
\       'ale_enabled': 0,
\       '&modifiable': 0,
\   },
\   '\.pyi$': {
\       'ale_linters': ['mypy'],
\   },
\   '\v\.min\.(js|css)$': {
\       'ale_linters': [],
\       'ale_fixers': [],
\   },
\   'node_modules': {
\       'ale_fixers': [],
\   },
\   '/python-ls-project/': {
\       'ale_linters': {'python': ['pyls', 'flake8']},
\   },
\}
