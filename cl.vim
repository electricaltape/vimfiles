"------------------------------------------------------------------------------
" Set up the hack that lets me use screen/csi with vim
"------------------------------------------------------------------------------
nmap <silent> <leader>es :call CL_eval_defun()<cr>
nmap <silent> <leader>ef  :call CL_send_sexp("(load \"" . expand("%:p") . "\")\n")<cr>

fun! CL_send_sexp(sexp)
    let ss = escape(a:sexp, '\"')
    call system("screen -p csi -X stuff \"" . ss . "\n\"")
endfun

fun! CL_eval_defun()
    let pos = getpos('.')
    silent! exec "normal! 99[(yab"
    call CL_send_sexp(@")
    call setpos('.', pos)
endfun

"------------------------------------------------------------------------------
" disable the single quote from autoclosing and make it not a keyword.
"------------------------------------------------------------------------------
let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"'} 
set iskeyword=33,35-38,42-58,60-90,94,95,97-122,126,_
