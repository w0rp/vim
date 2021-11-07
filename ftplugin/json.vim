" Use 2 space tabs for JSON
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

let b:ale_fix_on_save = 1
let b:ale_fixers = ['fixjson']
let b:ale_linters = ['jsonlint']
