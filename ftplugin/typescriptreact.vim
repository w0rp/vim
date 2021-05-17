let b:ale_completion_excluded_words = [
\   'it',
\   'describe',
\   'beforeEach',
\   'import',
\   'importScripts',
\   'implements',
\]
let b:ale_fixers = ['eslint', 'extra_ale_fixers#FixWeirdImportCommas']
let b:ale_fix_on_save = 1
