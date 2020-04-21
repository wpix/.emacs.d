(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/"))

(setq load-prefer-newer t)
(package-initialize)
(require 'auto-compile)
(auto-compile-on-load-mode)
(auto-compile-on-save-mode)

(when (not package-archive-contents)
  (package-refresh-contents))

(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/org-mode/site-lisp")
(add-to-list 'load-path "~/org-mode/lisp")
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
;; Path
(setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin"))
;(setq exec-path-from-shell-debug t)
(setq exec-path-from-shell-check-startup-files nil)

(defun endless/upgrade ()		
  "Upgrade all packages, no questions asked."
  (interactive)
  (save-window-excursion
    (list-packages)
    (package-menu-mark-upgrades)
    (package-menu-execute 'no-query)))

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
(server-start)
(require 'org-protocol)
(require 's)
(require 'org-protocol-capture-html)
(require 'org)
(require 'org-paper)
(require 'org-babel)
(require 'org-note)
(require 'org-drill)

(require 'init-keybindings)
(require 'init-spelling)
(require 'init-company)
(require 'init-hai)
(require 'init-chinese)

;(require 'ying-hydra)
(require 'ying-yas)
(require 'ying-proj-magit)
(require 'ying-config)

(setq custom-file "~/.emacs.d/lisp/init-face.el")
(load-file custom-file)


;;========================================================
;;                     m i n o r 
;;========================================================
(require 'recentf)
(recentf-mode t)
(require 'smartparens-config)
(smartparens-mode 1)
(winner-mode 1)


