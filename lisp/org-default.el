;; org
(add-to-list 'load-path "~/org-mode/lisp")
(add-to-list 'load-path "~/org-mode/contrib/lisp" t)
(add-to-list 'load-path "~/org-mode/site-lisp")
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(require 'org)
(require 'org-habit)
(require 'org-loaddefs)
(require 'ox-extra)
(with-eval-after-load 'org
  (setq org-startup-indented t) ; Enable `org-indent-mode' by default
  (add-hook 'org-mode-hook #'visual-line-mode))

(setq org-refile-targets '((org-agenda-files :maxlevel . 2)))

;;===================== Org-TODO/Capture setting ===================

(setq org-directory "~/Dropbox/y/org")
(setq org-default-notes-file "~/Dropbox/y/org/notes.org")

                                        ; Set default column view headings: Task Effort Clock_Summary
(setq org-columns-default-format "%50ITEM %20TAGS %10PRIORITY %20TODO")


;;================ todo  ======================
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "PROJ(p)" "|" "DONE(d)")
        (sequence "WAITING(w@/!)" "INACTIVE(i)" "SOMEDAY(s)" "|" "CANCELLED(c@/!)")))

(setq org-todo-keyword-faces
      '(("TODO" :foreground "orange" :weight bold)
        ("NEXT" :foreground "sky blue" :weight bold)
        ("PROJ" :foreground "yellow" :weight bold)
        ("DONE" :foreground "forest green" :weight bold)
        ;; ("HABIT" :foreground "#bdcebe" :weight bold)
        ;; ("MOTIVATOR" :foreground "#eca1a6" :weight bold)
        ("WAITING" :foreground "#5C888B" :weight bold)
        ("INACTIVE" :foreground "gray50" :weight bold)
        ("SOMEDAY" :foreground "#ada397" :weight bold)
        ("CANCELLED" :foreground "forest green" :weight bold)))

(defun transform-square-brackets-to-round-ones(string-to-transform)
  "Transforms [ into ( and ] into ), other chars left unchanged."
  (concat 
  (mapcar #'(lambda (c) (if (equal c ?\[) ?\( (if (equal c ?\]) ?\) c))) string-to-transform)))

(setq org-capture-templates
      '(;("c" "clocknow" entry (file+headline org-default-notes-file "Task")
                                        ;"* TODO %?\n%u\n%a\n" :clock-in t :clock-resume t)
        ("d" "Dump" entry (file+headline "~/Dropbox/y/org/wiki/Zettelkasten.org" "Undeveloped Ideas") "** %? %^{DATE}p %^{LOCATION}p")
        ("m" "Minutes" entry (file org-default-notes-file)
         "* Meeting with %? :meeting:\n" :clock-in t :clock-resume t)
        ("j" "Journal" entry (file+olp+datetree "~/Dropbox/y/org/monthly.org") "* %? %^g" :tree-type week)
        ("w" "Web site" entry (file+olp "~/Dropbox/y/org/notes.org" "Web")
         "* %c :website:\n%U %?%:initial")
        ))

;;============= a g e n d a ===================
(setq org-agenda-file-regexp "\\`\\\([^.].*\\.org\\\|[0-9]\\\{8\\\}\\\(\\.gpg\\\)?\\\)\\'"
      org-agenda-files '("~/Dropbox/y/org"))

;; (load-library "find-lisp")
;; (setq org-agenda-files (find-lisp-find-files "~/org" "\.org$"))
;;https://orgmode.org/worg/org-tutorials/org-custom-agenda-commands.html
;;https://orgmode.org/worg/org-tutorials/org-custom-agenda-commands.html
(setq org-agenda-custom-commands
      '(("p" "Persona Y"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Velvet Room:"))
                )
          (agenda "" ((org-agenda-span 3))
                  (org-agenda-skip-function
                   '(air-org-skip-subtree-if-habit))
                  (org-agenda-start-on-weekday nil)
                  )
          (todo "TODO"
                ((org-agenda-skip-function
                  '(or (air-org-skip-subtree-if-priority ?A)
                       (air-org-skip-subtree-if-habit)
                       (org-agenda-skip-if nil '(scheduled deadline))))
                 (org-agenda-overriding-header "Midnight Channel:"))
                )
          ;; (alltodo ""
          ;;          ((org-agenda-skip-function
          ;; 			 '(or (air-org-skip-subtree-if-priority ?A)
          ;; 				  (org-agenda-skip-entry-if 'todo 'done)
          ;;                 (org-agenda-skip-if nil '(scheduled deadline))))
          ;;           (org-agenda-overriding-header "Midnight Chanel:"))
          ;; 		   )
          ))
        ("w" "Idle & Habit view"
         ((agenda "" ((org-agenda-span 7))); review upcoming deadlines and appointments

          (stuck "") ; review stuck projects as designated by org-stuck-projects
          (todo "SOMEDAY") ; review someday/maybe items
          (todo "INACTIVE")
          (todo "WAITING")
          )) ; review waiting items
        ;; ...other commands here
        ))

(setq org-habit-show-habits-only-for-today t)

(defun air-org-skip-subtree-if-habit ()
  "Skip an agenda entry if it has a STYLE property equal to \"habit\"."
  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
    (if (string= (org-entry-get nil "STYLE") "habit")
        subtree-end
      nil)))

(defun air-org-skip-subtree-if-priority (priority)
  "Skip an agenda subtree if it has a priority of PRIORITY.
PRIORITY may be one of the characters ?A, ?B, or ?C."
  (let ((subtree-end (save-excursion (org-end-of-subtree t)))
        (pri-value (* 1000 (- org-lowest-priority priority)))
        (pri-current (org-get-priority (thing-at-point 'line t))))
    (if (= pri-value pri-current)
        subtree-end
      nil)))

(setq org-agenda-window-setup 'current-window
	  org-deadline-warning-days 7
	  org-agenda-structural-header nil)

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


(provide 'org-default)
