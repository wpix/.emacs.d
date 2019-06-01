(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(package-initialize)
(add-to-list 'load-path "~/.emacs.d/lisp")


;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
(require 'init-spelling)
(require 'init-org)
(require 'init-keybindings)
(require 'init-company)
(require 'init-ido)
(require 'init-dired)
(require 'init-defaults)

(require 'notmuch-config)
(require 'elfeed-config)
(require 'helm-config)
(require 'smartparens-config)
(require 'hugo-config)

(require 'recentf)
(require 'dired-x) 
(require 'awesome-tray)
(require 'awesome-tab)

(awesome-tab-mode t)
(awesome-tray-mode 1)
(helm-mode 1)
(ido-mode 1)
(recentf-mode t)
(smartparens-mode t)
;;(global-linum-mode 1)
(delete-selection-mode 1)
(winner-mode 1)
(google-this-mode 1)
(which-key-mode -1)
(autoload 'ibuffer "ibuffer" "List buffers." t)


(ace-link-setup-default)

;;; Install epdfinfo via 'brew install pdf-tools' and then install the
;;; pdf-tools elisp via the use-package below. To upgrade the epdfinfo
;;; server, just do 'brew upgrade pdf-tools' prior to upgrading to newest
;;; pdf-tools package using Emacs package system. If things get messed
;;; up, just do 'brew uninstall pdf-tools', wipe out the elpa
;;; pdf-tools package and reinstall both as at the start.
(setq pdf-info-epdfinfo-program "/usr/local/bin/epdfinfo")
(setenv "PKG_CONFIG_PATH" "/usr/local/lib/pkgconfig:/usr/local/Cellar/libffi/3.2.1/lib/pkgconfig")
(setenv "PKG_CONFIG_PATH" "/usr/local/lib/pkgconfig:/usr/local/Cellar/zlib/1.2.11/lib/pkgconfig")
(pdf-tools-install)
;;----------------------------------------------------------------------------
;; Customize settings
;;----------------------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(awesome-tab-style "box")
 '(flyspell-use-global-abbrev-table-p t)
 '(gnus-treat-hide-citation-maybe t)
 '(google-this-keybind "C-c / g")
 '(ido-enable-flex-matching t)
 '(ispell-highlight-face (quote flyspell-incorrect))
 '(notmuch-address-internal-completion (quote (received nil)))
 '(notmuch-draft-folder "Drafts")
 '(notmuch-draft-save-plaintext nil)
 '(notmuch-fcc-dirs (quote ((".*" . "sent"))))
 '(notmuch-hello-sections
   (quote
    (notmuch-hello-insert-saved-searches notmuch-hello-insert-search notmuch-hello-insert-recent-searches notmuch-hello-insert-alltags notmuch-hello-insert-footer)))
 '(notmuch-saved-searches
   (quote
    ((:name "inbox" :query "tag:inbox" :key "i" :search-type tree)
     (:name "unread" :query "tag:unread" :key "u" :search-type tree)
     (:name "flagged" :query "tag:flagged" :key "f" :search-type tree)
     (:name "sent" :query "tag:sent" :key "t" :search-type tree)
     (:name "archive" :query "tag:archive" :key "a" :search-type tree)
     (:name "carol" :query "carol" :key "c" :search-type tree)
     (:name "blendell" :query "blendell" :key "b" :search-type tree))))
 '(notmuch-show-logo nil)
 '(org-agenda-files
   (quote
    ("~/org-notes/hobo-schedule.org" "~/org-notes/hobo-research.org")))
 '(org-log-into-drawer t)
 '(package-selected-packages
   (quote
    (pdf-tools define-word ace-link focus google-this dashboard toc-org hydra markdown-mode easy-hugo elfeed yasnippet company-statistics company-quickhelp pos-tip w3m smartparens whole-line-or-region which-key doom-themes langtool company dracula-theme helm)))
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.office365.com")
 '(smtpmail-smtp-service 25)
 '(which-key-idle-delay 0.5)
 '(which-key-mode t)
 '(which-key-side-window-location (quote (right bottom))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#282a36" :foreground "#f8f8f2" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "nil" :family "monaco"))))
 '(font-lock-function-name-face ((t (:foreground "orchid1"))))
 '(message-header-cc ((t (:foreground "orchid1"))))
 '(notmuch-tree-match-author-face ((t (:foreground "orchid1"))))
 '(notmuch-tree-match-tag-face ((t (:foreground "orchid1"))))
 '(org-level-1 ((t (:inherit bold :foreground "plum" :height 1.1))))
 '(org-level-2 ((t (:inherit bold :foreground "#bd93f9" :height 1.1))))
 '(org-level-3 ((t (:foreground "orchid" :weight bold :height 1.1))))
 '(org-level-4 ((t (:foreground "yellow green" :weight normal :height 1.1))))
 '(org-level-5 ((t (:foreground "violet" :weight normal :height 1.1))))
 '(success ((t (:foreground "DarkOliveGreen2" :weight bold)))))
