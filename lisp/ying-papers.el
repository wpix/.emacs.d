;;======================== Org-ref setting ===========================
(require 'org-ref)
(key-chord-define-global "jj" 'org-ref-bibtex-hydra/body)
(setq org-latex-toc-command "\\tableofcontents \\clearpage")
;; org-ref citation management 
(setq bibtex-completion-bibliography "~/org/bibliography/mserefs.bib"
      bibtex-completion-library-path "~/Documents/Bookends/Attachment"
      bibtex-completion-notes-path "~/org/bibliography/helm-bibtex-notes/")

;; ;; open pdf with system pdf viewer (works on mac)
;; (setq bibtex-completion-pdf-open-function
;;   (lambda (fpath)
;;     (start-process "open" "*open*" "open" fpath)))

(setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f"))
(setq org-ref-bibtex-hydra-key-binding "\C-cj")

(setf (cdr (assoc 'org-mode bibtex-completion-format-citation-functions)) 'org-ref-format-citation)

(setq org-ref-show-citation-on-enter nil)
(setq org-ref-show-broken-links t)
;; m (setq bibtex-dialect 'biblatex)
(setq org-latex-prefer-user-labels t)
(add-hook 'org-ref-clean-bibtex-entry-hook 'org-ref-replace-nonascii)

;;org-ref-bibtex-generate-longtitles
;org-ref-bibtex-generate-shorttitles
(add-to-list 'org-ref-bibtex-journal-abbreviations
	     '("JIR" "Journal of Irreproducible Research" "J. Irrep. Res."))

(require 'doi-utils)
(require 'org-id)
(require 'org-ref-wos)
(require 'org-ref-scopus)
(require 'org-ref-isbn)
(require 'org-ref-pubmed)
(require 'org-ref-arxiv)
(require 'org-ref-sci-id)
(setq org-ref-completion-library 'org-ref-ivy-cite)

(add-to-list 'org-ref-nonascii-latex-replacements
	     '("æ" . "{\\\\ae}"))

;; Tell org-ref to let helm-bibtex find notes for it
(setq org-ref-notes-function
      (lambda (thekey)
	(let ((bibtex-completion-bibliography (org-ref-find-bibliography)))
	  (bibtex-completion-edit-notes
	   (list (car (org-ref-get-bibtex-key-and-file thekey)))))))

(key-chord-define-global "kk" 'org-ref-cite-hydra/body)



;;======================== Org-ref-pandoc setting ============================
(require 'ox-word)

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


;;======================== Org-LATEX setting ============================

(setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
	"bibtex %b"
	"pdflatex -interaction nonstopmode -output-directory %o %f"
	"pdflatex -interaction nonstopmode -output-directory %o %f"))


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

(defun my/org-ref-open-pdf-at-point ()
  "Open the pdf for bibtex key under point if it exists."
  (interactive)
  (let* ((results (org-ref-get-bibtex-key-and-file))
         (key (car results))
         (pdf-file (funcall org-ref-get-pdf-filename-function key)))
    (if (file-exists-p pdf-file)
        (find-file pdf-file)
      (message "No PDF found for %s" key))))

(setq org-ref-open-pdf-function 'my/org-ref-open-pdf-at-point)

;; (with-eval-after-load "pdf-tools"
;;   (use-package org-pdfview
;;     :config
;;     ;; https://lists.gnu.org/archive/html/emacs-orgmode/2016-11/msg00169.html
;;     ;; Before adding, remove it (to avoid clogging)
;;     (delete '("\\.pdf\\'" . default) org-file-apps)
;;     ;; https://lists.gnu.org/archive/html/emacs-orgmode/2016-11/msg00176.html
;;     (add-to-list 'org-file-apps
;; 		 '("\\.pdf\\'" . (lambda (file link)
;; 				   (org-pdfview-open link))))))



;;======================== Org-brain  setting ==========================
;; (require 'org-brain)
;; (setq org-brain-path "~/Documents/Brains/whiskers/")
;; (setq org-id-track-globally t)
;; (setq org-id-locations-file "~/.emacs.d/.org-id-locations")
;; (push '("b" "Brain" plain (function org-brain-goto-end)
;;           "* %i%?" :empty-lines 1)
;;         org-capture-templates)
;; (setq org-brain-visualize-default-choices 'all)
;; (setq org-brain-title-max-length 30)
;; (setq org-brain-show-resources nil)



;;=========================== pdf-tool setting=================




(require 'pdf-tools)
;; (require 'pdf-occur)
;; (require 'pdf-history)
;; (require 'pdf-links)
;; (require 'pdf-outline)
;; (require 'pdf-annot)
;; (require 'pdf-sync)

;;; Code:
;;; Install epdfinfo via 'brew install pdf-tools' and then install the
;;; pdf-tools elisp via the use-package below. To upgrade the epdfinfo
;;; server, just do 'brew upgrade pdf-tools' prior to upgrading to newest
;;; pdf-tools package using Emacs package system. If things get messed
;;; up, just do 'brew uninstall pdf-tools', wipe out the elpa
;;; pdf-tools package and reinstall both as at the start.
(setq pdf-info-epdfinfo-program "/usr/local/bin/epdfinfo")
(setenv "PKG_CONFIG_PATH" "/usr/local/lib/pkgconfig:/usr/local/Cellar/libffi/3.2.1/lib/pkgconfig")
(setenv "PKG_CONFIG_PATH" "/usr/local/lib/pkgconfig:/usr/local/Cellar/zlib/1.2.11/lib/pkgconfig")
(pdf-tools-install)

;; (use-package pdf-tools
;;   ;;https://emacs.stackexchange.com/questions/13314/install-pdf-tools-on-emacs-macosx
;;   :ensure t
;;   :config
;;   (custom-set-variables
;;     '(pdf-tools-handle-upgrades nil)) ; Use brew upgrade pdf-tools instead.
;;   (setq pdf-info-epdfinfo-program "/usr/local/bin/epdfinfo"))
;; (pdf-tools-install)

; This goes into your emacs config file
;; (use-package pdf-tools
;;   :ensure t
;;   :config
;;   (setq pdf-info-epdfinfo-program "/usr/local/bin/epdfinfo"))

;; this only has to be executed for the installation and can be removed/commented afterwards
;; I recommend commenting it out so that it can be found easily when reinstalling
;; (setenv "PKG_CONFIG_PATH" "/usr/local/Cellar/zlib/1.2.8/lib/pkgconfig:/usr/local/lib/pkgconfig:/opt/X11/lib/pkgconfig")
;; (pdf-tools-install)

(use-package org-pdftools
  :init (setq org-pdftools-root-dir "~/Documents/Bookends/Attachment"
                org-pdftools-search-string-separator "??")
  :after org
  :config
    (org-link-set-parameters "pdftools"
                             :follow #'org-pdftools-open
                             :complete #'org-pdftools-complete-link
                             :store #'org-pdftools-store-link
                             :export #'org-pdftools-export)
    (add-hook 'org-store-link-functions 'org-pdftools-store-link))

;; (use-package org-noter-pdftools
;;   :after org-noter)


;; ;;===================end=======================
(provide 'ying-papers)
