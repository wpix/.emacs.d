
                                        ;======================== Org-ref setting ===========================
(use-package org-ref
  :ensure t
  :after org
  :init
  ;;https://tex.stackexchange.com/questions/25701/bibtex-vs-biber-and-biblatex-vs-natbib
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
               '("JIR" "Journal of Irreproducible Research" "J. Irrep. Res.")))
;;   ;=============== p d f v i e w  ========================
;;   ;; (with-eval-after-load "pdf-tools"
;;   ;; (use-package org-pdfview
;;   ;;   :config
;;   ;;   ;; https://lists.gnu.org/archive/html/emacs-orgmode/2016-11/msg00169.html
;;   ;;   ;; Before adding, remove it (to avoid clogging)
;;   ;;   (delete '("\\.pdf\\'" . default) org-file-apps)
;;   ;;   ;; https://lists.gnu.org/archive/html/emacs-orgmode/2016-11/msg00176.html
;;   ;;   (add-to-list 'org-file-apps
;;   ;;   	 '("\\.pdf\\'" . (lambda (file link)
;;   ;;                          (org-pdfview-open link))))))

;;   )

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
