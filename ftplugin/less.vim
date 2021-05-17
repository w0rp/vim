setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal formatoptions-=t formatoptions+=croql

setlocal comments=:// commentstring=//\ %s

setlocal omnifunc=csscomplete#CompleteCSS
setlocal suffixesadd=.less

" Include - for completion.
setlocal iskeyword+=-

if expand('%:p') =~# 'spotlight/static'
    let s:path_to_base = split(expand('%:p'), '/spotlight/static')[0]
    \   . '/spotlight/static/main/styles/clients/base/'

    let b:ale_less_lessc_options = join(map(
    \   [
    \       ['line-height-computed', '20px'],
    \       ['screen-xs-max', '120px'],
    \       ['screen-sm-max', '120px'],
    \       ['screen-md-max', '120px'],
    \       ['border-radius-base', '2px'],
    \       ['font-size-base', '12pt'],
    \       ['brand-primary', 'black'],
    \       ['brand-secondary', 'black'],
    \       ['brand-danger', 'red'],
    \       ['gray-lightest', 'red'],
    \       ['gray-lighter', 'gray'],
    \       ['gray-light', 'gray'],
    \       ['disco-card-width', '2px'],
    \       ['font-size-h6', '2px'],
    \       ['padding-xs-vertical', '2px'],
    \       ['padding-base-horizontal', '2px'],
    \       ['path-to-base', s:path_to_base],
    \       ['fa-var-pencil-square-o', ''],
    \   ],
    \   '''--global-var='' . ale#Escape(v:val[0] . ''='' . v:val[1])'
    \), ' ')
else
    let b:ale_less_lessc_options = ''
endif
