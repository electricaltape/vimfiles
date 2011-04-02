" Vim indent file
" Language:     Haskell
" Author:       motemen <motemen@gmail.com>
" Version:      0.1
" Last Change:  2007-07-25
"
" Modify g:haskell_indent_if and g:haskell_indent_case to
" change indentation for `if'(default 3) and `case'(default 5).
" Example (in .vimrc):
" > let g:haskell_indent_if = 2

if exists('b:did_indent')
    finish
endif

let b:did_indent = 1

if !exists('g:haskell_indent_if')
    " if bool
    " >>>then ...
    " >>>else ...
    let g:haskell_indent_if = 3
endif

if !exists('g:haskell_indent_case')
    " case xs of
    " >>>>>[] -> ...
    " >>>>>(y:ys) -> ...
    let g:haskell_indent_case = 5
endif

setlocal indentexpr=GetHaskellIndent()
setlocal indentkeys=!^F,o,O

function! GetHaskellIndent()
    let line = substitute(getline(getpos('.')[1] - 1), '\t', repeat(' ', &tabstop), 'g')

    if line =~ '[!#$%&*+./<=>?@\\^|~-]$\|\<do$'
        return match(line, '\s*where \zs\|\S') + &shiftwidth
    endif

    if line =~ '{$'
        return match(line, '\s*where \zs\|\S') + &shiftwidth
    endif

    if line =~ '^\(instance\|class\).*\&.*where$'
        return &shiftwidth
    endif

    if line =~ ')$'
        let pos = getpos('.')
        normal k$
        let paren_end   = getpos('.')
        normal %
        let paren_begin = getpos('.')
        call setpos('.', pos)
        if paren_begin[1] != paren_end[1]
            return paren_begin[2] - 1
        endif
    endif

    if line !~ '\<else\>'
        let s = match(line, '\<if\>.*\&.*\zs\<then\>')
        if s > 0
            return s
        endif

        let s = match(line, '\<if\>')
        if s > 0
            return s + g:haskell_indent_if
        endif
    endif

    let s = match(line, '\<do\s\+\zs[^{]\|\<where\s\+\zs\w\|\<let\s\+\zs\S\|^\s*\zs|\s')
    if s > 0
        return s
    endif

    let s = match(line, '\<case\>')
    if s > 0
        return s + g:haskell_indent_case
    endif
    return match(line, '\S')
endfunction

" Haskell Coloring Enhancements - Make all the Prelude functions Functions.
" This is from an old list.
syntax keyword Function abs all and any atan break ceiling chr compare
syntax keyword Function concat concatMap const cos digitToInt div drop
syntax keyword Function dropWhile elem error even exp filter flip floor
syntax keyword Function foldl foldl1 foldr foldr1 fromInt fromInteger fst
syntax keyword Function gcd head id init isAlpha isDigit isLower isSpace
syntax keyword Function isUpper iterate last lcm length lines log map max
syntax keyword Function maximum min minimum mod not notElem null odd or ord
syntax keyword Function pi pred putStr product quot rem repeat replicate
syntax keyword Function reverse round show sin snd sort span splitAt sqrt
syntax keyword Function substract succ sum tail take takeWhile tan toLower
syntax keyword Function toUpper truncate undefined unlines until unwords
syntax keyword Function words zip zipWith fromIntegral
" newer stuff.
syntax keyword Function curry uncurry toEnum fromEnum enumFrom enumFromThen
syntax keyword Function enumFromTo enumFromThenTo minBound maxBound negate
syntax keyword Function signum toRational toInteger recip logBase asin
syntax keyword Function acos sinh tanh cosh asinh atanh acosh properFraction
syntax keyword Function floatRadix floatDigits floatRange decodeFloat 
syntax keyword Function encodeFloat exponent significand scaleFloat isNaN
syntax keyword Function isInfinite isDenormalized isNegativeZero isIEEE
syntax keyword Function atan2 subtract realToFrac mapM mapM_ sequence asTypeOf
syntax keyword Function scanl scanl1 scanr scanr1 cycle splitAt lookup zip3
syntax keyword Function unzip unzip3 showsPrec showList showChar shows showString
syntax keyword Function showParen reads readParen lex catch userError ioError
syntax keyword Function readLn readIO appendFile writeFile readFile putChar 
syntax keyword Function putStrLn print getContents interact

" set as green for the default theme
syntax keyword Type Integer Double Float Int Enum Ord Integral
" set booleans as redish, like letters"
syntax keyword Boolean True False
" set as the same color as let, in, etc
syntax keyword Keyword where
