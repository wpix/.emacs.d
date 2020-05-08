(use-package ebib
  :preface
  ;(autoload 'helm-bibtex "helm-bibtex" "" t)
  :bind
  (("C-c e" . 'ebib)
  :map org-mode-map
  ("C-c b" . 'ebib-insert-citation)
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
		ebib-keywords-file-save-on-exit 'always)

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

  (defun ebib-list-recent (days)
	"List entries created in the last DAYS days."
	(interactive "nNumber of days: ")
	;; Save the database's current filter, if there is one.
	(let ((filter (ebib-db-get-filter ebib--cur-db)))
	  (when filter (setq ebib--filters-last-filter filter)))
	(let*
		;; Calculate the from-date in Emacs' time format.
		((date (time-subtract (current-time) (days-to-time days)))
		 ;; Create a Lisp expression that will function as the filter.
		 (filter `(ebib--newer-than (quote ,date))))
	  ;; Install it as the current database's filter.
	  (ebib-db-set-filter filter ebib--cur-db)
	  ;; Update the current entry key.
	  (ebib-db-set-current-entry-key (ebib--get-key-at-point) ebib--cur-db)
	  ;; Update the display, so that only filtered entries are visible.
	  (ebib--update-buffers)))

  (defun ebib--newer-than (date)
	"Function for use in filters.
Return t if the entry being tested is newer than DATE.  DATE must
be a list of the format returned by `current-time' and is
compared to the timestamp of the entry being tested.  If the
entry has no timestamp, or a timestamp that cannot be converted
into a date representation, return nil."
	(let ((timestamp (cdr (assoc-string "timestamp" ebib-entry))))
	  (when (and timestamp
				 (setq timestamp (ignore-errors (date-to-time timestamp))))
		(time-less-p date timestamp))))

  )
(provide 'org-ebib)
