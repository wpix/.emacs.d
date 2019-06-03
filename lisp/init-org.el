;; org
(setq load-path (cons "~/org-mode/lisp" load-path))
(setq load-path (cons "~/org-mode/contrib/lisp" load-path))
(require 'org-install)
(require 'org-notmuch)
(require 'org-brain)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on

(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)
(setq org-capture-templates
      '(("P" "Research project" entry (file "~/org-notes/inbox.org")
	 "* TODO %^{Project title} :%^G:\n:PROPERTIES:\n:CREATED: %U\n:END:\n%^{Project description}\n** TODO Literature review\n** TODO %?\n** TODO Summary\n** TODO Reports\n** Ideas\n")
        ("t" "Todo" entry (file+headline "~/org-notes/inbox.org" "tasks")
         "* TODO %?\n  %i\n  %a")
	("n" "Notmuch" entry (file+headline "~/org-notes/inbox.org" "emails")
	 "")
	("m" "Meeting" entry (file "~/org-notes/meetings.org")
    "* MEETING: with %?\n" :clock-in t :clock-resume t :empty-lines 1)))

	
(global-set-key (kbd "<f7>") 'org-mark-ring-push)
(global-set-key (kbd "C-<f7>") 'org-mark-ring-goto)

;; TODO options setting
(setq org-todo-keywords
      (quote ((sequence "TODO(t)"  "DOING(g)" "SOMEDAY(y)" "|" "DONE(d)" "REVIEW(v)")
	      (sequence "REPEAT(r)"  "WAIT(w!)"  "|"  "PAUSED(p!)" "CANCELLED(c)" )
	      (sequence "IDEA(i!)" "MAYBE(m!)" "STAGED(s!)" "WORKING(k!)" "|" "USED(u!)")
	      )))

;; logbook drawer setting
(setq org-log-done 'note)

(with-eval-after-load 'org       
  (setq org-startup-indented t) ; Enable `org-indent-mode' by default
  (add-hook 'org-mode-hook #'visual-line-mode))

;;org-brain
(setq org-brain-path "~/Documents/Brains/whiskers/")
(setq org-id-track-globally t)
(setq org-id-locations-file "~/.emacs.d/.org-id-locations")
(push '("b" "Brain" plain (function org-brain-goto-end)
          "* %i%?" :empty-lines 1)
        org-capture-templates)
(setq org-brain-visualize-default-choices 'all)
(setq org-brain-title-max-length 20)
(setq org-brain-show-resources nil)

;;org-brain icons
(defun org-brain-insert-resource-icon (link)
  "Insert an icon, based on content of org-mode LINK."
  (insert (format "%s "
                  (cond ((string-prefix-p "http" link)
                         (cond ((string-match "wikipedia\\.org" link)
                                (all-the-icons-faicon "wikipedia-w"))
                               ((string-match "github\\.com" link)
                                (all-the-icons-octicon "mark-github"))
                               ((string-match "youtube\\.com" link)
                                (all-the-icons-faicon "youtube"))
                               (t
                                (all-the-icons-faicon "globe"))))
                        ((string-prefix-p "brain:" link)
                         (all-the-icons-fileicon "brain"))
                        (t
                         (all-the-icons-icon-for-file link))))))

(add-hook 'org-brain-after-resource-button-functions #'org-brain-insert-resource-icon)



(provide 'init-org)
