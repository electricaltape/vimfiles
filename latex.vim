" latex.vim
" configuration file for latex!

" General Abbreviations
ab \i \item

"These are basic math abbreviations. More complex ones are snippets.
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
"vim:syntax=vim

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
    " use s- over highlighted text to surround with \bigg
    let b:surround_45 = "\\bigg(\r\\bigg)" 
endif
