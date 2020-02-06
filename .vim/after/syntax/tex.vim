syn match texInputFile "\\href\s*\(\[.*\]\)\={.\{-}}"
syn match texInputFile "\\includegraphics<.*>\s*\(\[.*\]\)\={.\{-}}"
syn match texInputFile "\\begin{darkframe}\s*\(\[.*\]\)\={.\{-}}"
     \ contains=texStatement,texInputCurlies,texInputFileOpt
syn match texInputFile "\\begin{sectionframe}\s*\(\[.*\]\)\={.\{-}}"
     \ contains=texStatement,texInputCurlies,texInputFileOpt
syn match texInputFile "\\begin{backgroundframe}\s*\(\[.*\]\)\={.\{-}}"
     \ contains=texStatement,texInputCurlies,texInputFileOpt
