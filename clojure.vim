"------------------------------------------------------------------------------
" Set up the hack that lets me use screen/clj with vim
"------------------------------------------------------------------------------
nmap <silent> <leader>es :call Clojure_eval_defun()<cr>
nmap <silent> <leader>ef  :call Clojure_send_sexp("(load \"" . expand("%:p") . "\")\n")<cr>

fun! Clojure_send_sexp(sexp)
    let ss = escape(a:sexp, '\"')
    call system("screen -p clojure -X stuff \"" . ss . "\n\"")
endfun

fun! Clojure_eval_defun()
    let pos = getpos('.')
    silent! exec "normal! 99[(yab"
    call Clojure_send_sexp(@")
    call setpos('.', pos)
endfun

"------------------------------------------------------------------------------
" disable the single quote from autoclosing and make it not a keyword.
"------------------------------------------------------------------------------
let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"'} 
set iskeyword=33,35-38,42-58,60-90,94,95,97-122,126,_
