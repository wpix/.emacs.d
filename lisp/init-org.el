;; org
(add-to-list 'load-path "~/org-mode/lisp")
(add-to-list 'load-path "~/org-mode/contrib/lisp" t)
(add-to-list 'load-path "~/org-mode/site-lisp")
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
;(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(add-to-list 'load-path "~/.emacs.d/site-lisp")

(require 'org)
(require 'org-loaddefs)
(require 'ox-extra)
(with-eval-after-load 'org       
  (setq org-startup-indented t) ; Enable `org-indent-mode' by default
  (add-hook 'org-mode-hook #'visual-line-mode))

(setq org-refile-targets '((org-agenda-files :maxlevel . 2)))

;;====================== Keybindings ===============================
(global-set-key (kbd "<f7>") 'org-mark-ring-push)
(global-set-key (kbd "C-<f7>") 'org-mark-ring-goto)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-iswitchb)
(define-key global-map "\C-cc" 'org-capture)



;;===================== Org-TODO/Capture setting ===================

(setq org-directory "~/org")
(setq org-default-notes-file "~/org/notes.org")

; Set default column view headings: Task Effort Clock_Summary
(setq org-columns-default-format "%50ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM %16TIMESTAMP_IA")


(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "NOW(y)" "|" "DONE(d)")
	(sequence "CHECK(C)" "MOTIVATOR(M)")
	(sequence "WAITING(w@/!)" "INACTIVE(i)" "SOMEDAY(s)" "|" "CANCELLED(c@/!)")))

(setq org-todo-keyword-faces
      '(("TODO" :foreground "red" :weight bold)
	("NEXT" :foreground "orange" :weight bold)
	("NOW" :foreground "yellow" :weight bold)
	("DONE" :foreground "forest green" :weight bold)
	("CHECK" :foreground "#bdcebe" :weight bold)
	("MOTIVATOR" :foreground "#eca1a6" :weight bold)
	("WAITING" :foreground "#5C888B" :weight bold)
	("INACTIVE" :foreground "gray50" :weight bold)
	("SOMEDAY" :foreground "#ada397" :weight bold)
	("CANCELLED" :foreground "forest green" :weight bold)))

(defun transform-square-brackets-to-round-ones(string-to-transform)
  "Transforms [ into ( and ] into ), other chars left unchanged."
  (concat 
  (mapcar #'(lambda (c) (if (equal c ?\[) ?\( (if (equal c ?\]) ?\) c))) string-to-transform)))

(setq org-capture-templates
      '(("t" "todo" entry (file org-default-notes-file "Task")
	  "* TODO %?\n%u\n%a\n" :clock-in t :clock-resume t)
	 ("b" "Blank" entry (file org-default-notes-file "Inbox")
	  "* %?\n%u")
	 ("m" "Meeting" entry (file org-default-notes-file)
	  "* Meeting with %? :MEETING:\n" :clock-in t :clock-resume t)
	 ("i" "Idea" entry (file org-default-notes-file)
	  "* %? :IDEA: \n%u" :clock-in t :clock-resume t)
	 ("l" "Lab" entry (file "~/org/lab-log.org")
	  "* %? :IDEA: \n%u" :clock-in t :clock-resume t)
	 ("n" "Next Task" entry (file+headline org-default-notes-file)
	  "** NEXT %? \nDEADLINE: %t")
	 ("w" "Web site" entry (file+olp "~/org/notes.org" "Web")
 "* %c :website:\n%U %?%:initial")
        ))

(setq org-protocol-default-template-key "w")

;;=================== org word counts/goals =========================
;; (require 'wc-goal-mode)
;; (require 'advance-words-count)
;; (setq words-count-messages-display 'pos-tip)
(use-package org-journal
  :ensure t
  :defer t
  :custom
  (org-journal-enable-encryption t)
  (org-journal-dir "~/org/journal")
  (org-journal-date-format "%A, %d %B %Y"))

(setq org-agenda-file-regexp "\\`\\\([^.].*\\.org\\\|[0-9]\\\{8\\\}\\\(\\.gpg\\\)?\\\)\\'")
(setq org-agenda-files '("~/org" "~/org/publications" "~/org/archive"))
(add-to-list 'org-agenda-files org-journal-dir)

(setq org-journal-file-type 'weekly)

;;====================== Org-Notmuch ===============================
(require 'ol-notmuch)

(setq org-src-fontify-natively nil)
;; (defface org-block
;;     ;; org-block-background was removed from org: http://emacs.stackexchange.com/questions/14824/org-block-background-font-not-having-effect
;;     '((t (:background "#ffe6e6"))) "Face used for the source block background.")




;;===================end=======================
(provide 'init-org)
