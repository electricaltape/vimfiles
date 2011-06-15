" The magical turn-Vim-into-a-Python-IDE vim resource file!
"
" Mostly taken from http://www.sontek.net/category/Vim.aspx
" Other bits culled from various sources, Canonical guys, or made up by me.
"
" Julian Edwards 2008-05-30

" More syntax highlighting.
" let python_highlight_all = 1
" Rather than that, I am going to turn on a few things manually:
if !exists("python_highlight_indent_errors")
    let python_highlight_indent_errors = 1
endif
if !exists("python_highlight_doctests")
    let python_highlight_doctests = 1
endif

" Smart indenting
set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
" FIX THE STUPID COMMENT ALIGN PROBLEM
inoremap # X#

" Auto completion via ctrl-space (instead of the nasty ctrl-x ctrl-o)
" set omnifunc=pythoncomplete#Complete
" inoremap <Nul> <C-x><C-o>

" Wrap at 72 chars for comments.
" set formatoptions=cq textwidth=72 foldignore= wildignore+=*.py[co]

" `gf` jumps to the filename under the cursor.  Point at an import statement
" and jump to it!
python << EOF
import os
import sys
import vim
for p in sys.path:
    if os.path.isdir(p):
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF

" Use :make to see syntax errors. (:cn and :cp to move around, :dist to see
" all errors)
set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

" Execute a selection of code (very cool!)
" Use VISUAL to select a range and then hit ctrl-h to execute it.
python << endpython
import vim
def EvaluateCurrentRange():
    eval(compile('\n'.join(vim.current.range),'','exec'),globals())
endpython
map <C-h> :py EvaluateCurrentRange() <CR>

" Use F7/Shift-F7 to add/remove a breakpoint (pdb.set_trace)
" Totally cool.
python << EOF
def SetBreakpoint():
    import re
    nLine = int( vim.eval( 'line(".")'))

    strLine = vim.current.line
    strWhite = re.search( '^(\s*)', strLine).group(1)

    vim.current.buffer.append(
       "%(space)spdb.set_trace() %(mark)s Breakpoint %(mark)s" %
         {'space':strWhite, 'mark': '#' * 30}, nLine - 1)

    for strLine in vim.current.buffer:
        if strLine == "import pdb":
            break
    else:
        vim.current.buffer.append( 'import pdb', 0)
        vim.command( 'normal j1')

vim.command( 'map <f12> :py SetBreakpoint()<cr>')

def RemoveBreakpoints():
    import re

    nCurrentLine = int( vim.eval( 'line(".")'))

    nLines = []
    nLine = 1
    for strLine in vim.current.buffer:
        if strLine == "import pdb" or strLine.lstrip()[:15] == "pdb.set_trace()":
            nLines.append( nLine)
        nLine += 1

    nLines.reverse()

    for nLine in nLines:
        vim.command( "normal %dG" % nLine)
        vim.command( "normal dd")
        if nLine < nCurrentLine:
            nCurrentLine -= 1

    vim.command( "normal %dG" % nCurrentLine)

vim.command( "map <s-f12> :py RemoveBreakpoints()<cr>")
EOF
"------------------------------------------------------------------------------
" Set up the hack that lets me use screen/ipython with vim
"------------------------------------------------------------------------------
" nmap <silent> <leader>es :call Python_eval_defun()<cr> " doesn't work.
nmap <silent> <leader>ef :call Python_send_sexp("run " . expand("%:p"))<cr>

fun! Python_send_sexp(sexp)
    let ss = escape(a:sexp, '\"')
    call system("screen -p ipython -X stuff \"" . ss . "\n\"")
endfun

fun! Python_eval_defun()
    let pos = getpos('.')
    silent! exec "normal! 99[(yab"
    call Python_send_sexp(@")
    call setpos('.', pos)
endfun

"vim:syntax=vim
