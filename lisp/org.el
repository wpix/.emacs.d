;; org
(add-to-list 'load-path "~/org-mode/lisp")
(add-to-list 'load-path "~/org-mode/contrib/lisp" t)
(add-to-list 'load-path "~/org-mode/site-lisp")
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
;(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on

(require 'org)
(require 'org-loaddefs)
(require 'ox-extra)
(with-eval-after-load 'org       
  (setq org-startup-indented t) ; Enable `org-indent-mode' by default
  (add-hook 'org-mode-hook #'visual-line-mode))

(setq org-refile-targets '((org-agenda-files :maxlevel . 2)))

;;===================== Org-TODO/Capture setting ===================

(setq org-directory "~/org")
(setq org-default-notes-file "~/org/notes.org")

; Set default column view headings: Task Effort Clock_Summary
(setq org-columns-default-format "%50ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM %16TIMESTAMP_IA")


;;================ todo  ======================
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "PROJ(p)" "|" "DONE(d)")
		(sequence "RESISTANCE(r)" "MOTIVATOR(m)")
		(sequence "WAITING(w@/!)" "INACTIVE(i)" "SOMEDAY(s)" "|" "CANCELLED(c@/!)")))

(setq org-todo-keyword-faces
      '(("TODO" :foreground "orange" :weight bold)
        ("NEXT" :foreground "sky blue" :weight bold)
        ("PROJ" :foreground "yellow" :weight bold)
        ("DONE" :foreground "forest green" :weight bold)
        ("RESISTANCE" :foreground "#bdcebe" :weight bold)
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
      '(("t" "todo" entry (file+headline org-default-notes-file "Task")
	  "* TODO %?\n%u\n%a\n" :clock-in t :clock-resume t)
	 ("o" "inbox" entry (file+headkube org-default-notes-file "Inbox")
	  "* %?\n%u")
	 ("m" "Minutes" entry (file org-default-notes-file)
	  "* Meeting with %? :MEETING:\n" :clock-in t :clock-resume t)
	 ;; ("l" "Lab" entry (file "~/org/lab-log.org")
	 ;;  "* %? :IDEA: \n%u" :clock-in t :clock-resume t)
	 ("n" "Next Task" entry (file+headline org-default-notes-file)
	  "** NEXT %? \nDEADLINE: %t")
	 ("w" "Web site" entry (file+olp "~/org/notes.org" "Web")
 "* %c :website:\n%U %?%:initial")
	 ))




  ;;============= a g e n d a ===================
(setq org-agenda-file-regexp "\\`\\\([^.].*\\.org\\\|[0-9]\\\{8\\\}\\\(\\.gpg\\\)?\\\)\\'")
(setq org-agenda-files '("~/org"))
(setq org-deadline-warning-days 10)
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

(add-hook 'org-agenda-mode-hook
		  (lambda ()
			(define-key org-agenda-mode-map " " 'org-agenda-cycle-show)))


;;========================= b a b e l
  (setq org-src-fontify-natively t)
  ;; (use-package 'ob-ipython
  ;;   :ensure 
  ;;   :config
  ;;   (setq ob-ipython-command "/Users/Ying/.pyenv/shims/jupyter"
  ;;         python-shell-interpreter "ipython"))
    
  (require 'ob-ipython)
  ;(require 'ob-R)
  (require 'ob-emacs-lisp)
  ;(require 'ob-latex)
  ;(require 'ob-python)
  (require 'ob-shell)
  (require 'ob-org)

  ;; (use-package ob-async
  ;;   :ensure t
  ;;   ;:load-path "/Users/Greg/Desktop/ob-async"
  ;;   :config
  ;;   (setq ob-async-no-async-languages-alist '("ipython" "jupyter-python"))
  ;;   )

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((ipython . t)
     (shell . t)
     (latex . t)
     (translate . t)))

  ;;; display/update images in the buffer after evaluation
  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

  ;;The first let Org-mode don't evaluate src blocks when exporting.
  ;;The second let Org-mode export src blocks with results
  (add-to-list 'org-babel-default-header-args '(:eval . "never-export"))
  ;;(add-to-list 'org-babel-default-header-args '(:exports . "both"))
  (setq python-shell-interpreter "/Users/Ying/.pyenv/shims/python")  
  (setq python-shell-completion-native-enable nil)
  (setq org-confirm-babel-evaluate nil)
  (add-to-list 'load-path "~/.emacs.d/elpa/ess-20200408.2126")
  (require 'ess-site)

  ;;ESS will not print the evaluated commands, also speeds up the evaluation
  (setq ess-eval-visibly nil)
  (setq ess-ask-for-ess-directory nil)

  ;;for R coding
  (require 'ess-smart-underscore)
  (setq org-babel-R-command "/usr/local/bin/R --no-save")


;;==================== c o n t a c t s ====================
(use-package org-contacts
  :ensure nil
  :after org
  :custom (org-contacts-files '("~/org/archive/contacts.org")))

(provide 'org)
