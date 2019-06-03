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
(require 'init-defaults)
(require 'init-pdf-tools)
(require 'init-tab)

(require 'notmuch-config)
(require 'elfeed-config)
(require 'helm-config)
(require 'smartparens-config)
(require 'hugo-config)

(require 'recentf)
;;(require 'lazy-set-key)

(helm-mode 1)
(ido-mode 1)
(recentf-mode t)
(smartparens-mode 1)
(ace-popup-menu-mode 1)
;;(global-linum-mode 1)
(delete-selection-mode 1)
(winner-mode 1)
(google-this-mode 1)
(which-key-mode -1)
(autoload 'ibuffer "ibuffer" "List buffers." t)
(ace-link-setup-default)



;;(global-set-key (kbd "<C-tab>") 'awesome-tab-forward)
;;(global-set-key (kbd "<C-s-tab>") 'awesome-tab-backward)




;;----------------------------------------------------------------------------
;; Customize settings
;;----------------------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(awesome-tab-background-color "#31343E")
 '(awesome-tab-mode t nil (awesome-tab))
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
    (org-brain org-noter ace-popup-menu pdf-tools define-word ace-link focus google-this dashboard toc-org hydra markdown-mode easy-hugo elfeed yasnippet company-statistics company-quickhelp pos-tip w3m smartparens whole-line-or-region which-key doom-themes langtool company dracula-theme helm)))
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
 '(awesome-tab-default ((t (:background "#31343E" :foreground "white"))))
 '(font-lock-function-name-face ((t (:foreground "orchid1"))))
 '(message-header-cc ((t (:foreground "orchid1"))))
 '(notmuch-tree-match-author-face ((t (:foreground "orchid1"))))
 '(notmuch-tree-match-tag-face ((t (:foreground "orchid1"))))
 '(org-level-1 ((t (:inherit bold :foreground "orchid" :height 1.1))))
 '(org-level-2 ((t (:inherit bold :foreground "#bd93f9" :height 1.1))))
 '(org-level-3 ((t (:foreground "plum" :weight bold :height 1.1))))
 '(org-level-4 ((t (:foreground "yellow green" :weight normal))))
 '(org-level-5 ((t (:foreground "violet" :weight normal :height 1.1))))
 '(success ((t (:foreground "DarkOliveGreen2" :weight bold)))))
