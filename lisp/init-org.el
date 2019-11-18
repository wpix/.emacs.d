;; org
(setq load-path (cons "~/org-mode/lisp" load-path))
(setq load-path (cons "~/org-mode/contrib/lisp" load-path))
(require 'org-install)
(require 'ox-extra)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(add-to-list 'load-path "~/.emacs.d/site-lisp")

(with-eval-after-load 'org       
  (setq org-startup-indented t) ; Enable `org-indent-mode' by default
  (add-hook 'org-mode-hook #'visual-line-mode))

;;====================== Keybindings ===============================
(global-set-key (kbd "<f7>") 'org-mark-ring-push)
(global-set-key (kbd "C-<f7>") 'org-mark-ring-goto)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-iswitchb)

;;====================== Org-Notmuch ===============================
(require 'org-notmuch)
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/org-tracktable")
;;(load "org-tracktable.el")

;;===================== Org-TODO/Capture setting ===================
(setq org-agenda-file-regexp "\\`\\\([^.].*\\.org\\\|[0-9]\\\{8\\\}\\\(\\.gpg\\\)?\\\)\\'")
(setq org-agenda-files '(
			 "/Users/Ying/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org"
			 "/Users/Ying/Documents/Publications"
			 "~/org-notes/journal"))

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "InProgress(i)" "TBS(s)" "|" "DONE(d)")
	      (sequence "WAIT(w)" "PAUSED(p)" "|" "CANCELED(x!)")
	      (sequence "1st(a)"  "2nd(b)"  "3rd(c)"  "STAGED(g!)"  "|"  "REVIEW(v!)")
	      )))

;; (setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)
(setq org-capture-templates
      '(("t" "todo" entry (file+headline "/Users/Ying/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/inbox.org" "tasks")
         "* TODO %?\n  %i\n  %a")
	("i" "ideas" entry (file+headline "/Users/Ying/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/research.org" "ideas") "%?\n  %i\n  %a")))


;;======================== Org-journal setting ============================
(customize-set-variable 'org-journal-dir "~/org-notes/journal/")
(customize-set-variable 'org-journal-date-format "%A, %d %B %Y")
(require 'org-journal)

(setq org-journal-enable-agenda-integration t)

(defun org-journal-find-location ()
  ;; Open today's journal, but specify a non-nil prefix argument in order to
  ;; inhibit inserting the heading; org-capture will insert the heading.
  (org-journal-new-entry t)
  ;; Position point on the journal's top-level heading so that org-capture
  ;; will add the new entry as a child entry.
  (goto-char (point-min)))

(setq org-capture-templates
      '(("j" "journal entry" entry (function org-journal-find-location)
	 "* %(format-time-string org-journal-time-format)%^{Title}\n%i%?")))

(defun org-journal-save-entry-and-exit()
  "Simple convenience function.
  Saves the buffer of the current day's entry and kills the window
  Similar to org-capture like behavior"
  (interactive)
  (save-buffer)
  (kill-buffer-and-window))
(define-key org-journal-mode-map (kbd "C-x C-s") 'org-journal-save-entry-and-exit)

;;===================end=======================
(provide 'init-org)
