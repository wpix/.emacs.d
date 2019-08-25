(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(package-initialize)
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp")

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
(require 'init-spelling)
(require 'init-org)
(require 'init-keybindings)
(require 'init-company)
(require 'init-ido)
(require 'init-helm)
(require 'init-defaults)
(require 'init-pdf-tools)
(require 'init-chinese)
(require 'init-magit)

(require 'notmuch-config)
(require 'elfeed-config)
(require 'smartparens-config)
(require 'hugo-config)

(require 'recentf)

(ido-mode 1)
(recentf-mode t)
(smartparens-mode 1)
(ace-popup-menu-mode 1)
;;(global-linum-mode 1)
(delete-selection-mode 1)
(winner-mode 1)
(which-key-mode -1)
(autoload 'ibuffer "ibuffer" "List buffers." t)
(ace-link-setup-default)





;;----------------------------------------------------------------------------
;; Customize settings
;;----------------------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flyspell-use-global-abbrev-table-p t)
 '(gnus-treat-hide-citation-maybe t)
 '(google-this-keybind "C-c / g")
 '(ido-enable-flex-matching t)
 '(ispell-highlight-face (quote flyspell-incorrect))
 '(notmuch-address-internal-completion (quote (received nil)))
 '(notmuch-draft-folder "")
 '(notmuch-draft-save-plaintext nil)
 '(notmuch-hello-sections
   (quote
    (notmuch-hello-insert-saved-searches notmuch-hello-insert-search notmuch-hello-insert-recent-searches notmuch-hello-insert-alltags notmuch-hello-insert-footer)))
 '(notmuch-mua-cite-function (quote ignore))
 '(notmuch-mua-reply-insert-header-p-function (quote ignore))
 '(notmuch-saved-searches
   (quote
    ((:name "inbox" :query "tag:inbox" :key "i" :search-type tree)
     (:name "unread" :query "tag:unread" :key "u" :search-type tree)
     (:name "flagged" :query "tag:flagged" :key "f" :search-type tree)
     (:name "archive" :query "tag:archive" :key "a" :search-type tree)
     (:name "carol" :query "carol" :key "c" :search-type tree)
     (:name "blendell" :query "blendell" :key "b" :search-type tree))))
 '(notmuch-show-logo nil)
 '(org-agenda-files
   (quote
    ("~/org-notes/inbox.org" "~/org-notes/hobo-meeting-log.org" "~/org-notes/hobo-lab-log.org" "~/org-notes/hobo-schedule.org" "~/org-notes/hobo-research.org")))
 '(org-journal-date-format "%A, %d %B %Y")
 '(org-journal-dir "~/org-notes/journal/")
 '(org-log-into-drawer t)
 '(package-selected-packages
   (quote
    (org-tracktable academic-phrases org-journal bbdb ess magit ox-reveal imenu-anywhere org-ref org-brain org-noter ace-popup-menu pdf-tools define-word ace-link toc-org hydra easy-hugo elfeed yasnippet company-statistics pos-tip w3m smartparens whole-line-or-region which-key doom-themes langtool company dracula-theme helm)))
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.office365.com")
 '(smtpmail-smtp-service 25)
 '(which-key-idle-delay 1)
 '(which-key-mode t)
 '(which-key-side-window-location (quote (right bottom))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#282a36" :foreground "gray85" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight light :height 160 :width normal :foundry "nil" :family "Lantinghei TC"))))
 '(apropos-symbol ((t (:inherit ##))))
 '(awesome-tab-default ((t (:background "#31343E" :foreground "white"))))
 '(bold ((t (:weight semi-bold))))
 '(bold-italic ((t (:slant italic :weight semi-bold))))
 '(bookmark-menu-bookmark ((t (:weight semi-bold))))
 '(buffer-menu-buffer ((t (:weight semi-bold))))
 '(comint-highlight-input ((t (:weight semi-bold))))
 '(company-tooltip ((t (:background "#282a36" :foreground "#e2e2dc" :weight semi-bold))))
 '(compilation-mode-line-fail ((t (:inherit compilation-error :foreground "Red1" :weight semi-bold))))
 '(dired-mark ((t (:foreground "#f8f8f2" :weight semi-bold))))
 '(dired-marked ((t (:foreground "#ffb86c" :weight semi-bold))))
 '(epa-field-name ((t (:foreground "PaleTurquoise" :weight semi-bold))))
 '(epa-mark ((t (:foreground "orange" :weight semi-bold))))
 '(error ((t (:foreground "Pink" :weight semi-bold))))
 '(font-lock-function-name-face ((t (:foreground "orchid1" :weight semi-bold))))
 '(font-lock-keyword-face ((t (:foreground "#ff79c6" :weight semi-bold))))
 '(font-lock-regexp-grouping-backslash ((t (:inherit demibold))))
 '(font-lock-regexp-grouping-construct ((t (:inherit demibold))))
 '(gnus-button ((t (:weight semi-bold))))
 '(gnus-emphasis-bold ((t (:weight semi-bold))))
 '(gnus-emphasis-bold-italic ((t (:slant italic :weight semi-bold))))
 '(gnus-group-mail-1 ((t (:foreground "#ff79c6" :weight semi-bold))))
 '(gnus-group-mail-2 ((t (:foreground "#8be9fd" :weight semi-bold))))
 '(gnus-group-news-1 ((t (:foreground "#ff79c6" :weight semi-bold))))
 '(gnus-header-subject ((t (:foreground "LightPink1" :weight bold))))
 '(helm-ff-directory ((t (:background "#282a36" :foreground "plum1" :weight semi-bold))))
 '(helm-ff-invalid-symlink ((t (:background "#282a36" :foreground "#ff79c6" :weight semi-bold))))
 '(helm-ff-symlink ((t (:background "#282a36" :foreground "#ff79c6" :weight semi-bold))))
 '(helm-source-header ((t (:background "#282a36" :foreground "#ff79c6" :underline nil :weight semi-bold))))
 '(ido-first-match ((t (:foreground "#ff79c6" :weight semi-bold))))
 '(info-node ((t (:foreground "white" :slant italic :weight semi-bold))))
 '(info-title-4 ((t (:inherit variable-pitch :weight semi-bold))))
 '(isearch ((t (:background "#464752" :foreground "#ffb86c" :weight semi-bold))))
 '(langtool-correction-face ((t (:background "dark red" :foreground "DarkGoldenrod3" :weight semi-bold))))
 '(message-header-cc ((t (:foreground "orchid1"))))
 '(message-header-name ((t (:foreground "plum1"))))
 '(message-header-newsgroups ((t (:foreground "yellow" :slant italic :weight semi-bold))))
 '(message-header-subject ((t (:foreground "SteelBlue1"))))
 '(message-header-to ((t (:foreground "DarkOliveGreen1"))))
 '(message-mml ((t (:foreground "plum"))))
 '(minibuffer-prompt ((t (:foreground "#ff79c6" :weight semi-bold))))
 '(mode-line-buffer-id ((t (:weight semi-bold))))
 '(mode-line-emphasis ((t (:weight semi-bold))))
 '(notmuch-search-unread-face ((t (:weight semi-bold))))
 '(notmuch-tag-added ((t (:underline "light green"))))
 '(notmuch-tag-unread ((t (:foreground "IndianRed3"))))
 '(notmuch-tree-match-author-face ((t (:foreground "orchid1"))))
 '(notmuch-tree-match-tag-face ((t (:foreground "orchid1"))))
 '(org-agenda-date ((t (:foreground "plum1" :underline nil))))
 '(org-agenda-date-today ((t (:inherit org-agenda-date :slant italic :weight semi-bold))))
 '(org-agenda-date-weekend ((t (:inherit org-agenda-date))))
 '(org-agenda-done ((t (:foreground "DarkOliveGreen3"))))
 '(org-column-title ((t (:inherit org-column :underline t :weight semi-bold))))
 '(org-date ((t (:foreground "light steel blue" :underline t))))
 '(org-document-title ((t (:foreground "#ffb86c" :weight semi-bold :height 1.3))))
 '(org-level-1 ((t (:inherit bold :foreground "orchid" :height 1.2))))
 '(org-level-2 ((t (:inherit bold :foreground "#bd93f9" :height 1.2))))
 '(org-level-3 ((t (:foreground "plum" :weight semi-bold :height 1.1))))
 '(org-level-4 ((t (:foreground "yellow green" :weight semi-bold))))
 '(org-level-5 ((t (:foreground "#ffb86c" :weight normal))))
 '(org-level-6 ((t (:foreground "sienna1" :weight normal))))
 '(org-link ((t (:foreground "SkyBlue1" :underline t))))
 '(org-list-dt ((t (:weight semi-bold))))
 '(org-tag ((t (:background "#373844" :foreground "#ff79c6" :weight semi-bold))))
 '(org-todo ((t (:background "#373844" :foreground "#ffb86c" :weight semi-bold))))
 '(org-warning ((t (:foreground "#ff79c6" :weight semi-bold))))
 '(popup-tip-face ((t (:background "LightGoldenrod3" :foreground "black"))))
 '(read-multiple-choice-face ((t (:inherit underline :weight semi-bold))))
 '(success ((t (:foreground "DarkOliveGreen2" :weight semi-bold))))
 '(tty-menu-enabled-face ((t (:background "blue" :foreground "yellow" :weight semi-bold))))
 '(which-key-special-key-face ((t (:inherit which-key-key-face :inverse-video t :weight semi-bold))))
 '(widget-button ((t (:weight semi-bold)))))
(put 'set-goal-column 'disabled nil)
