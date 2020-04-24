;;======================== Org-ref setting ===========================
(use-package org-ref
  :ensure t
  :after org
  :init
  ;;https://tex.stackexchange.com/questions/25701/bibtex-vs-biber-and-biblatex-vs-natbib
  (setq org-ref-default-citation-link "cite"
        bibtex-dialect 'bibtex)
  (add-hook 'org-ref-clean-bibtex-entry-hook 'org-ref-replace-nonascii)
  :config
  (require 'doi-utils)
  (require 'org-id)
  (require 'org-ref-wos)
  (require 'org-ref-scopus)
  (require 'org-ref-isbn)
  (require 'ox-word)
                                        ;(require 'org-ref-pubmed)
                                        ;(require 'org-ref-arxiv)
                                        ;(require 'org-ref-sci-id)
  (setq org-ref-completion-library 'org-ref-ivy-cite
        org-ref-show-citation-on-enter nil
        org-ref-show-broken-links t
        org-latex-prefer-user-labels t)

  (setf (cdr (assoc 'org-mode bibtex-completion-format-citation-functions)) 'org-ref-format-citation)

  ;;org-ref-bibtex-generate-longtitle
  ;;org-ref-bibtex-generate-shorttitles
  (add-to-list 'org-ref-bibtex-journal-abbreviations
               '("JIR" "Journal of Irreproducible Research" "J. Irrep. Res."))
  (use-package helm-bibtex
	:preface
	(autoload 'helm-bibtex "helm-bibtex" "" t)
	:bind ("C-x c x" . 'helm-bibtex)
	:init 
	:config
	(setq bibtex-completion-bibliography
		  '("~/org/bib/mserefs.bib"
			"~/org/bib/enerefs.bib"))
	(setq bibtex-completion-library-path
		  '("~/Documents/Bookends/Attachments"
			"~/org/publications")
		  bibtex-completion-notes-path "~/org/bib/helm-bibtex-notes/"
		  bibtex-completion-notes-path "~/org/wiki"
		  bibtex-completion-pdf-symbol "⌘"
		  bibtex-completion-notes-symbol "✎")
	(setq bibtex-completion-format-citation-functions
		  '((org-mode      . bibtex-completion-format-citation-cite)
			(default       . bibtex-completion-format-citation-default))))
  ;=============== p d f v i e w  ========================
  ;; (with-eval-after-load "pdf-tools"
  ;; (use-package org-pdfview
  ;;   :config
  ;;   ;; https://lists.gnu.org/archive/html/emacs-orgmode/2016-11/msg00169.html
  ;;   ;; Before adding, remove it (to avoid clogging)
  ;;   (delete '("\\.pdf\\'" . default) org-file-apps)
  ;;   ;; https://lists.gnu.org/archive/html/emacs-orgmode/2016-11/msg00176.html
  ;;   (add-to-list 'org-file-apps
  ;;   	 '("\\.pdf\\'" . (lambda (file link)
  ;;                          (org-pdfview-open link))))))
  
  )

;;==================== l a t e x ========================
(setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
        "bibtex %b"
        "pdflatex -interaction nonstopmode -output-directory %o %f"
        "pdflatex -interaction nonstopmode -output-directory %o %f"))
;;(setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f"))

;;(setq org-latex-pdf-process '("latexmk -pdflatex='pdflatex -interaction nonstopmode' -f %f"))

(setq org-latex-toc-command "\\tableofcontents \\clearpage")
;; allow for export=>beamer by placing
;; #+LaTeX_CLASS: beamer in org files
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))

;; letter class, for formal letters
(add-to-list 'org-export-latex-classes
  '("letter"
     "\\documentclass[10pt]{letter}\n
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage{color}"
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\paragraph{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-export-latex-classes
 ;; beamer class, for presentations
  '("beamer"
     "\\documentclass[10pt]{beamer}\n
      \\mode<{{{beamermode}}}>\n
      \\usetheme{{{{beamertheme}}}}\n
      \\usecolortheme{{{{beamercolortheme}}}}\n
      \\beamertemplateballitem\n
      \\setbeameroption{show notes}
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage{hyperref}\n
      \\usepackage{color}
      \\usepackage{listings}
      \\lstset{numbers=none,language=[ISO]C++,tabsize=4,
  frame=single,
  basicstyle=\\small,
  showspaces=false,showstringspaces=false,
  showtabs=false,
  keywordstyle=\\color{blue}\\bfseries,
  commentstyle=\\color{red},
  }\n
      \\usepackage{verbatim}\n
      \\institute{{{{beamerinstitute}}}}\n          
       \\subject{{{{beamersubject}}}}\n"

     ("\\section{%s}" . "\\section*{%s}")
     
     ("\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}"
       "\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}")))

(add-to-list 'org-latex-classes
             '("koma-article"
               "\\documentclass{scrartcl}
                \\usepackage{microtype}
                \\usepackage{tgtermes}
                \\usepackage[scale=.9]{tgheros}
                \\usepackage{tgcursor}
                \\usepackage{paralist}
                \\newcommand{\\rc}{$^{14}C$}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
			 '("apa6"
			   "\\documentclass{apa6}"
			   ("\\section{%s}" . "\\section*{%s}")
			   ("\\subsection{%s}" . "\\subsection*{%s}")
			   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
			   ("\\paragraph{%s}" . "\\paragraph*{%s}")
			   ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;;=================== org pandoc ====================================
;; https://kitchingroup.cheme.cmu.edu/blog/2015/06/11/ox-pandoc-org-mode-+-org-ref-to-docx-with-bibliographies/
;; We have to undo that here to insert LaTeX style citations. We do that here so that the key binding for inserting references from org-ref inserts the LaTeX citations. This is necessary for pandoc to convert the reference citations to the bibliography in the docx format. 

;; (setq helm-bibtex-format-citation-functions      
;;       '((org-mode . (lambda (x) (insert (concat
;;                                          "\\cite{"
;;                                          (mapconcat 'identity x ",")
;;                                          "}")) ""))))

;; (defun helm-bibtex-format-pandoc-citation (keys)
;;   (concat "[" (mapconcat (lambda (key) (concat "@" key)) keys "; ") "]"))

;; ;; inform helm-bibtex how to format the citation in org-mode
;; (setf (cdr (assoc 'org-mode helm-bibtex-format-citation-functions))
;; 'helm-bibtex-format-pandoc-citation)

;; (require 'ox-pandoc)

;; ;; default options for all output formats
;; (setq org-pandoc-options '((standalone . t)))
;; ;; cancel above settings only for 'docx' format
;; (setq org-pandoc-options-for-docx '((standalone . nil)))
;; ;; special settings for beamer-pdf and latex-pdf exporters
;; (setq org-pandoc-options-for-beamer-pdf '((pdf-engine . "xelatex")))
;; (setq org-pandoc-options-for-latex-pdf '((pdf-engine . "pdflatex")))
;; ;; special extensions for markdown_github output
;; (setq org-pandoc-format-extensions '(markdown_github+pipe_tables+raw_html))
(provide 'org-paper)
