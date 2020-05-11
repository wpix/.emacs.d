(use-package ebib
  :preface
                                        ;(autoload 'helm-bibtex "helm-bibtex" "" t)
  :bind
  (("C-c e" . 'ebib)
                                        ;   :map org-mode-map
                                        ;   ("C-c b" . 'ebib-insert-citation)
   :map ebib-multiline-mode-map
   ("C-c C-c" . 'ebib-quit-multiline-buffer-and-save)
   ("C-c C-q" . 'ebib-cancel-multiline-buffer)
   ("C-c C-s" . 'ebib-save-from-multiline-buffer))
  :init
  :config
  (setq ebib-default-directory "~/Dropbox/y/org/bib/"
        ebib-preload-bib-file "~/Dropbox/y/org/bib/enerefs.bib"
        ebib-notes-directory "~/Dropbox/y/org/wiki/"
        ebib-file-search-directory "~/Dropbox/y/org/library/"
        ebib-use-timestamp t
        ebib-bibtex-dialect 'biblatex
        ebib-reading-list-file "~/Dropbox/y/org/wiki/readinglist.org"
        ebib-keywords-file-save-on-exit 'always))

;; (use-package org-ref
;;   :ensure t
;;   :after org
;;   :init
;;   ;;https://tex.stackexchange.com/questions/25701/bibtex-vs-biber-and-biblatex-vs-natbib
;;   (add-hook 'org-ref-clean-bibtex-entry-hook 'org-ref-replace-nonascii)
;;   :config
;;   (require 'doi-utils)
;;   (require 'org-id)
;;   (require 'org-ref-wos)
;;   (require 'org-ref-scopus)
;;   (require 'org-ref-isbn)
;;   (require 'org-ref-pubmed)
;;   (require 'org-ref-arxiv)
;;   (require 'org-ref-sci-id)
;;   (setq org-ref-completion-library 'org-ref-ivy-cite
;;         org-ref-show-citation-on-enter nil
;;         org-ref-show-broken-links t
;;         org-latex-prefer-user-labels t)
;;   (setf (cdr (assoc 'org-mode bibtex-completion-format-citation-functions)) 'org-ref-format-citation)
;;   ;;org-ref-bibtex-generate-longtitle
;;   ;;org-ref-bibtex-generate-shorttitles
;;   (add-to-list 'org-ref-bibtex-journal-abbreviations
;;                '("JIR" "Journal of Irreproducible Research" "J. Irrep. Res.")))



;;================= i v y b i b t e x =======================
(require 'doi-utils)
(use-package ivy-bibtex)
(autoload 'ivy-bibtex "ivy-bibtex" "" t)
;; ivy-bibtex requires ivy's `ivy--regex-ignore-order` regex builder, which
;; ignores the order of regexp tokens when searching for matching candidates.
;; Add something like this to your init file:
(setq ivy-re-builders-alist
      '((ivy-bibtex . ivy--regex-ignore-order)
        (t . ivy--regex-plus)))

(setq bibtex-completion-bibliography '("~/Dropbox/y/org/bib/enerefs.bib"
                                       "~/Dropbox/y/org/bib/mserefs.bib"
                                       "~/Dropbox/y/org/bib/ene-asee-motivation.bib"))
(setq bibtex-completion-library-path
      '("~/Dropbox/y/org/library")
      bibtex-completion-notes-path "~/Dropbox/y/org/wiki"
      bibtex-completion-pdf-filed "file"
      bibtex-completion-pdf-symbol "⌘"
      bibtex-completion-notes-symbol "✎")
(setq bibtex-completion-format-citation-functions
      '((org-mode      . bibtex-completion-format-citation-cite)
        (latex-mode    . bibtex-completion-format-citation-cite)
        (markdown-mode . bibtex-completion-format-citation-pandoc-citeproc)
        (default       . bibtex-completion-format-citation-default)))

(define-key ivy-mode-map (kbd "C-x C-d e") 'ivy-bibtex)
(define-key ivy-mode-map (kbd "C-x C-d l") 'ivy-bibtex-with-local-bibliography)
(define-key ivy-mode-map (kbd "C-x C-d n") 'ivy-bibtex-with-notes)

(setq ivy-bibtex-default-action 'ivy-bibtex-insert-citation)




(use-package org-roam
  :hook
  (after-init . org-roam-mode)
  :custom
  (org-roam-directory "~/Dropbox/y/org/wiki/")
  :bind (:map org-roam-mode-map
              (("C-c n r" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n b" . org-roam-switch-to-buffer)
               ("C-c n g" . org-roam-graph))
              :map org-mode-map
              (("C-c n i" . org-roam-insert)))
  :config
  (setq org-roam-capture-templates
        '(("d" "default" plain #'org-roam--capture-get-point "%?"
           :file-name "%<%Y%m%d>-${slug}"
           :head "#+TITLE: ${title}"
           :unnarrowed t)))
  (setq org-roam-link-title-format "%s")
  (defun my/org-roam--backlinks-list (file)
    (if (org-roam--org-roam-file-p file)
        (--reduce-from
         (concat acc (format "- [[file:%s][↩%s]]\n"
                             (file-relative-name (car it) org-roam-directory)
                             (org-roam--get-title-or-slug (car it))))
         "" (org-roam-db-query [:select [from] :from links :where (= to $s1)] file))
      ""))

  (defun my/org-export-preprocessor (backend)
    (let ((links (my/org-roam--backlinks-list (buffer-file-name))))
      (unless (string= links "")
        (save-excursion
          (goto-char (point-max))
          (insert (concat "\n* Backlinks\n") links)))))

  (add-hook 'org-export-before-processing-hook 'my/org-export-preprocessor)

  (use-package company-org-roam
    :config (push 'company-org-roam company-backends)))

(use-package deft
  :after org
  :bind
  ("C-c n d" . deft)
  :custom
  (deft-recursive t)
  (deft-use-filter-string-for-filename t)
  (deft-default-extension "org")
  (deft-directory "~/Dropbox/y/org/wiki/"))
(global-set-key (kbd "C-x C-g") 'deft-find-file)

(use-package org-download
  :after org
  :bind
  (:map org-mode-map
        (("s-Y" . org-download-screenshot)
         ("s-y" . org-download-yank))))


(provide 'ying-bib)
