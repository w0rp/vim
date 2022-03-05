" Kill the buffer on Ctrl+C, which isn't captured by getchar()
noremap <buffer> <C-c> :bdelete!<Return>
