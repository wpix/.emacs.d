(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(defun maybe-require-package (package &optional min-version no-refresh)
  "Try to install PACKAGE, and return non-nil if successful.
In the event of failure, return nil and print a warning message.
Optionally require MIN-VERSION.  If NO-REFRESH is non-nil, the
available package lists will not be re-downloaded in order to
locate PACKAGE."
  (condition-case err
      (require-package package min-version no-refresh)
    (error
     (message "Couldn't install optional package `%s': %S" package err)
     nil)))
;;; Fire up package.el

(setq package-enable-at-startup nil)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)

(setq load-prefer-newer t)
(require 'auto-compile)
(auto-compile-on-load-mode)
(auto-compile-on-save-mode)

(when (not package-archive-contents)
  (package-refresh-contents))

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
(setq exec-path-from-shell-debug t)
(setq exec-path-from-shell-check-startup-files nil)

(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/org-mode/site-lisp")
(add-to-list 'load-path "~/org-mode/lisp")
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
;; Path
(setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin"))

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
;; (server-start)
;; (require 'org-protocol)
;; (require 's)
;; (require 'org-protocol-capture-html)
(require 'org)
(require 'org-paper)
(require 'org-drill)
(require 'org-note)
(require 'org-ebib)

(require 'init-keybindings)
(require 'init-spelling)
(require 'init-chinese)
(require 'init-company)
(require 'init-hai)

;(require 'ying-hydra)
(require 'ying-yas)
;(require 'ying-proj-magit)
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
