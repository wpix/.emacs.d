;; org
(setq load-path (cons "~/org-mode/lisp" load-path))
(setq load-path (cons "~/org-mode/contrib/lisp" load-path))
(require 'org-install)
(require 'org-notmuch)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on

(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org-notes/gtd.org" "Tasks")
         "* TODO %?\n %i\n %a")
        ("j" "Journal" entry (file+datetree "~/org-notes/threefrogs.org")
         "* %?\nEntered on %U\n %i\n %a")))
(setq org-todo-keywords
      '((sequence "TODO" "STARTED" "SOMEDAY" "|" "DONE" "CANCELED")))
(setq org-log-done 'note)
(with-eval-after-load 'org       
  (setq org-startup-indented t) ; Enable `org-indent-mode' by default
  (add-hook 'org-mode-hook #'visual-line-mode))

(provide 'init-org)
