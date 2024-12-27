;; -*- lexical-binding: t; -*-

(TeX-add-style-hook
 "02_analise_algoritmo"
 (lambda ()
   (TeX-run-style-hooks
    "chapters/02_sections/02_funcao_iterativa"
    "chapters/02_sections/03_funcao_recursiva"
    "chapters/02_sections/04_implementacao_ordenacao"
    "chapters/02_sections/05_performance_ordenacao")
   (LaTeX-add-labels
    "ch:anal_de_alg"))
 :latex)

