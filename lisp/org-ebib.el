(use-package ebib
  :preface
  ;(autoload 'helm-bibtex "helm-bibtex" "" t)
  :bind
  (("C-c e" . 'ebib)
   :map org-mode-map
   ("C-c b" . 'ebib-insert-citation))
  :init 
  :config
  (setq ebib-default-directory '("~/org")
		ebib-preload-bib-file '("~/org/bib/ene-theory.bib")
		ebib-notes-directory '~/org/wiki
		ebib-use-timestamp t))

  (setq ebib-citation-commands
		(quote ((any (("cite" "\\cite%<[%A]%>{%K}")))
				(org-mode (("cite" "[[cite:%K][%A;%A;%A]]"))))))
  (org-add-link-type 
   "cite" 'ebib
   (lambda (path desc format)
	 (cond
	  ((eq format 'html)
	   (format "(<cite>%s</cite>)" path))
	  ((eq format 'latex)
	   (if (or (not desc) (equal 0 (search "cite:" desc)))
		   (format "\\cite{%s}" path)
		 (format "\\cite[%s][%s]{%s}"
				 (cadr (split-string desc ";"))
				 (car (split-string desc ";"))  path))))))

(provide 'org-ebib)
