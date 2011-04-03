"""""Functions for Vim"""""

" This function deletes characters. It is useful for eating spaces in iab commands.
func Eatchar(pat)
	let c = nr2char(getchar(0))
	return (c =~ a:pat) ? '' : c
endfunc
"Reference eat and move example:
"iabbr <silent> if if ()<Left><C-R>=Eatchar('\s')<CR>

"""""General Settings"""""

function! HelloWorld()
python << endpython
import vim
vim.current.buffer[0] = 'Hello, World'
endpython
endfunction

" Really basic stuff. Should be universal.
set nocompatible
set mouse=a
set t_Co=256
filetype plugin on
filetype indent on
set ofu=syntaxcomplete#Complete
set hid " change buffer and move with out saving

" compiler settings
" compiler gcc

" fold settings
set foldmethod=indent
set foldnestmax=1
set nofoldenable
set foldlevel=1

" Menu settings
set wildmenu
set wildmode=list:longest,full

" Changing the display. No editing functionality, but makes it nicer.
set incsearch " highlights what you search for as you type
set scrolloff=4 " keeps text around current position
set number
syntax on
set ruler
set showmatch " show matching braces
set mat=2 " blink for that many tenths of seconds!
set showcmd " shows what you type

" Now get indentation right.
set cinwords=if,else,while,do,for,switch,case,function,elif,class
set textwidth=79
set tabstop=4
set shiftwidth=4
set smarttab " will move by 4 spaces, as set above
set expandtab
set autoindent

""""""More Exciting Settings""""""
" save the file position
autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"""""Auto Commands; only execute once!"""""
if !exists("autocommands_loaded")
    let autocommands_loaded = 1
    autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
    " check the folder ~/.vim/skel/ for templates
    autocmd BufNewFile * silent! 0r ~/.vim/skel/tmpl.%:e
    " set correct mode
    autocmd BufRead,BufNewFile,FileReadPost *.py source ~/.vim/python.vim
    autocmd BufRead,BufNewFile,FileReadPost *.tex source ~/.vim/latex.vim
    autocmd BufRead,BufNewFile,FileReadPost *.gnuplot source ~/.vim/gnuplot.vim
    autocmd BufRead,BufNewFile,FileReadPost *.hs source ~/.vim/haskell.vim
    " omni complete settings. Also remaps omnicomplete to control-space
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    inoremap <Nul> <C-x><C-o>
endif

""""""LaTeX Settings"""""" 
let g:tex_flavor='latex'

"""""Fortran Settings"""""" 
" Fix the default formatting. I almost never used fixed source.
" Also. This needs to go before the syntax on blurb, so it is out of place. Oh
" well.
let s:extfname = expand("%:e")
if s:extfname ==? "f90" || "f95" || "f03" || "f08" || "F90" || "F95" || "F03"
    let fortran_free_source=1
    unlet! fortran_fixed_source
else
    let fortran_fixed_source=0
    unlet! fortran_free_source
endif
