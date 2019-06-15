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

;; Path
(setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin"))

;;themes and fonts
(load-theme 'dracula t)
;(dolist (charset '(kana han symbol cjk-misc bopomofo))
; (set-fontset-font (frame-parameter nil 'font)
;		   charset (font-spec :family "Hiragino Sans GB W3"
;				                   :size 16)))

(setq-default line-spacing 1)
(set-language-environment "UTF-8")

;; default browser
;; (setq browse-url-browser-function  'w3m-goto-url-new-session)

(setq w3m-coding-system 'utf-8
  w3m-file-coding-system 'utf-8
  w3m-file-name-coding-system 'utf-8
  w3m-input-coding-system 'utf-8
  w3m-output-coding-system 'utf-8
  w3m-use-cookies t)

(defun browse-url-at-point-default ()
  (interactive)
  (let ((browse-url-browser-function 'browse-url-default-macosx-browser))
    (browse-url-at-point)))
(global-set-key (kbd "<f6> d") 'browse-url-at-point-default)
(global-set-key (kbd "<f6> w") 'w3m-goto-url-new-session)







(provide 'init-defaults)
