"------------------------------------------------------------------------------
" Set up the hack that lets me use screen/csi with vim
"------------------------------------------------------------------------------
nmap <silent> <leader>es :call Scheme_eval_defun()<cr>
nmap <silent> <leader>ef  :call Scheme_send_sexp("(load \"" . expand("%:p") . "\")\n")<cr>

fun! Scheme_send_sexp(sexp)
    let ss = escape(a:sexp, '\"')
    call system("screen -p csi -X stuff \"" . ss . "\n\"")
endfun

fun! Scheme_eval_defun()
    let pos = getpos('.')
    silent! exec "normal! 99[(yab"
    call Scheme_send_sexp(@")
    call setpos('.', pos)
endfun

"------------------------------------------------------------------------------
" disable the single quote.
"------------------------------------------------------------------------------
let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"'} 
