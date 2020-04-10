;; org
(setq load-path (cons "~/org-mode/lisp" load-path))
(setq load-path (cons "~/org-mode/contrib/lisp" load-path))
(add-to-list 'load-path "~/org-mode/site-lisp")
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(add-to-list 'load-path "~/.emacs.d/site-lisp")

(require 'org)
(require 'ox-extra)
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
(require 'ol-notmuch)
;;(load "org-tracktable.el")



(setq org-src-fontify-natively nil)
(defface org-block
    ;; org-block-background was removed from org: http://emacs.stackexchange.com/questions/14824/org-block-background-font-not-having-effect
    '((t (:background "#ffe6e6"))) "Face used for the source block background.")





;;===================== Org-TODO/Capture setting ===================
(setq org-agenda-file-regexp "\\`\\\([^.].*\\.org\\\|[0-9]\\\{8\\\}\\\(\\.gpg\\\)?\\\)\\'")
(setq org-agenda-files '(
			 "~/org"
			 "~/Documents/Publications"))

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "InProgress(i)" "|" "DONE(d)")
	      (sequence "WAIT(w)" "PAUSED(p)" "|" "CANCELED(x)")
	      (sequence "1st(a)"  "2nd(b)"  "3rd(c)"  "STAGED(g)"  "|"  "REVIEW(v)"))))

(setq org-directory "~/org")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)


(defun transform-square-brackets-to-round-ones(string-to-transform)
  "Transforms [ into ( and ] into ), other chars left unchanged."
  (concat 
  (mapcar #'(lambda (c) (if (equal c ?[) ?\( (if (equal c ?]) ?\) c))) string-to-transform)))

(setq org-capture-templates
      '(("t" "todo" entry (file+headline "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/inbox.org" "tasks")
         "* TODO %?\n  %i\n  %a")
	("w" "Web site" entry (file+olp "~/org/notes.org" "Web")
 "* %c :website:\n%U %?%:initial")
	;; (("j" "journal entry" entry (function org-journal-find-location)
	;;   "* %(format-time-string org-journal-time-format)%^{Title}\n%i%?"))
	("i" "ideas" entry (file+headline "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/research.org" "ideas") "%?\n  %i\n  %a")))

(setq org-protocol-default-template-key "w")

;;======================== Org-journal setting ============================
;; (customize-set-variable 'org-journal-dir "~/org/journal")
;; (customize-set-variable 'org-journal-date-format "%A, %d %B %Y")
;; (require 'org-journal)

;; (setq org-journal-enable-agenda-integration t)

;; (defun org-journal-save-entry-and-exit()
;;   "Simple convenience function.
;;   Saves the buffer of the current day's entry and kills the window
;;   Similar to org-capture like behavior"
;;   (interactive)
;;   (save-buffer)
;;   (kill-buffer-and-window))
;; (define-key org-journal-mode-map (kbd "C-x C-s") 'org-journal-save-entry-and-exit)



;;=================== org word counts/goals =========================
;; (require 'wc-goal-mode)
;; (require 'advance-words-count)
;; (setq words-count-messages-display 'pos-tip)


;;===================end=======================
(provide 'init-org)
