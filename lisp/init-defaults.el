;; dashboard
;; (require 'dashboard)
;; (dashboard-setup-startup-hook)
;; (setq show-week-agenda-p t)
;; (add-to-list 'dashboard-items '(agenda) t)

;; mute notifications and sounds
(setq use-dialog-box nil)
(setq ring-bell-function 'ignore)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(setq tooltip-use-echo-area t)
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq confirm-nonexistent-file-or-buffer nil)
(setq kill-buffer-query-functions
  (remq 'process-kill-buffer-query-function
	kill-buffer-query-functions))
(setq inhibit-startup-echo-area-message "your$USER")

;;How to remove a confirmation question with 'M-x revert-buffer' ?
(setq revert-without-query '(".*"))

;;themes and fonts
(load-theme 'dracula t)
(set-language-environment "UTF-8")

;; default browser
(setq browse-url-browser-function  'w3m-goto-url-new-session)


(provide 'init-defaults)
