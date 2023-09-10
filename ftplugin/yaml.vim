setlocal expandtab

" Use 2 space tabs for YAML.
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

let b:ale_linters = ['actionlint', 'yaml-language-server', 'spectral', 'yamllint']
