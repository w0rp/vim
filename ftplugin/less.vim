setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal formatoptions-=t formatoptions+=croql

setlocal comments=:// commentstring=//\ %s

setlocal omnifunc=csscomplete#CompleteCSS
setlocal suffixesadd=.less

" Include - for completion.
setlocal iskeyword+=-

if expand('%:p') =~# 'spotlight/static/app/components'
    let b:ale_less_lessc_options = join(map(
    \   [
    \       ['screen-xs-max', '120px'],
    \       ['border-radius-base', '2px'],
    \       ['font-size-base', '12pt'],
    \       ['brand-primary', 'black'],
    \       ['brand-secondary', 'black'],
    \       ['brand-danger', 'red'],
    \       ['gray-lightest', 'red'],
    \   ],
    \   '''--global-var='' . ale#Escape(v:val[0] . ''='' . v:val[1])'
    \), ' ')
else
    let b:ale_less_lessc_options = ''
endif
