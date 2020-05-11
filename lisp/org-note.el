;;=========================== pdf-tool setting=================
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


;=================== h e l m b i b t e x ===================
(use-package helm-bibtex
	:preface
	(autoload 'helm-bibtex "helm-bibtex" "" t)
	:bind ("C-c C-x" . 'helm-bibtex)
	:init 
	:config
	(setq bibtex-completion-bibliography
		  '("~/Dropbox/y/org/bib/mserefs.bib"
			"~/Dropbox/y/org/bib/enerefs.bib"))
	(setq bibtex-completion-library-path
		  '("~/Dropbox/y/org/library")
		  bibtex-completion-notes-path '"~/Dropbox/y/org/wiki"
		  bibtex-completion-pdf-symbol "⌘"
		  bibtex-completion-notes-symbol "✎")
	(setq bibtex-completion-format-citation-functions
		  '((org-mode      . bibtex-completion-format-citation-cite)
			(default       . bibtex-completion-format-citation-default))))

;;============== r o a m b i b t e x ===================
;; (use-package org-roam-bibtex
;;   :hook (org-roam-mode . org-roam-bibtex-mode)
;;   :bind (:map org-mode-map
;;          (("C-c n a" . orb-note-actions))))

;;===================== d e f t ========================
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

;================= other ecosystem =====================
(use-package org-download
  :after org
  :bind
  (:map org-mode-map
        (("s-Y" . org-download-screenshot)
         ("s-y" . org-download-yank))))

;;================= p d f v i e w =========================
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

;;=========================== pdf-tool setting=================
(use-package pdf-tools
  :ensure t
  :init 
  (setq pdf-info-epdfinfo-program "/usr/local/bin/epdfinfo")
  (setenv "PKG_CONFIG_PATH" "/usr/local/lib/pkgconfig:/usr/local/Cellar/libffi/3.2.1/lib/pkgconfig")
  (setenv "PKG_CONFIG_PATH" "/usr/local/lib/pkgconfig:/usr/local/Cellar/zlib/1.2.11/lib/pkgconfig")
  (pdf-tools-install))
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
  :init (setq org-pdftools-root-dir "~/Dropbox/y/library"
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


;;================= comment exporter ================
;; remove comments from org document for use with export hook
;; https://emacs.stackexchange.com/questions/22574/orgmode-export-how-to-prevent-a-new-line-for-comment-lines
(defun delete-org-comments (backend)
  (loop for comment in (reverse (org-element-map (org-element-parse-buffer)
                    'comment 'identity))
    do
    (setf (buffer-substring (org-element-property :begin comment)
                (org-element-property :end comment))
          "")))

;; add to export hook
(add-hook 'org-export-before-processing-hook 'delete-org-comments)


(provide 'org-note)
