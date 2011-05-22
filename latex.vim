" latex.vim
" configuration file for latex!
" of course, the most important setting:
let g:tex_flavor='latex'

"These are basic math abbreviations. More complex ones are snippets.
ab \i \item
ab a= &=
ab \d \delta
ab dde \dfrac{d}{d\epsilon}
ab ddt \dfrac{\partial}{\partial t}
ab ddt2 \dfrac{\partial^2}{\partial t^2}
ab ddx \dfrac{\partial}{\partial x}
ab ddx2 \dfrac{\partial^2}{\partial x^2}
ab utt u_{tt}
ab uxx u_{xx}
ab vtt v_{tt}
ab vxx v_{xx}
ab wtt w_{tt}
ab wxx w_{xx}
ab gelt2 \cos \bigg( \dfrac{(2n-1)}{2}\pi x \bigg)
ab gelt3 \sin \bigg( \dfrac{(2n-1)}{2}\pi x \bigg)
ab wi w_i
ab yi y_i
ab ti t_i

" Greek and other math symbols. I have shamelessly copied this idea from what
" Erich showed me
ab .n \nabla
" ab .n2 \nabla\^2
ab .O \Omega
ab .G \Gamma
ab .. \cdot
ab .x \xi
ab .X \Xi
ab .r \rho
ab .R \Rho

" Special Commands
func! WriteLatex()
    w | !pdflatex %
    if !exists("loaded_new_pdf")
        let loaded_new_pdf = 1
        !evince %:t:r.pdf &
    endif
endfu

" special autocommands
if !exists("latex_autocommands_loaded")
    let latex_autocommands_loaded = 1
    " use s- over highlighted text to surround with \left(, \right)
    let b:surround_45 = "\\left(\r\\right)" 
endif
