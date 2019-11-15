(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(package-initialize)
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp")

;; Path
(setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin"))

;;themes and fonts
(load-theme 'dracula t)
(set-default-font "Monaco 14")
(setq-default line-spacing 1)
(set-language-environment "UTF-8")

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------

(require 'init-keybindings)
(require 'init-company)
(require 'init-ido)
(require 'init-helm)
(require 'init-chinese)
(require 'init-spelling)
(require 'init-magit)
(require 'init-browser)

(require 'init-org)
(require 'yorg-babel)
(require 'yorg-papers)
(require 'yorg-projectile)


(require 'scimax-hydra)

(require 'config-notmuch)
(require 'config-elfeed)
(require 'config-hugo)

(ido-mode 1)

(require 'recentf)
(recentf-mode t)

(require 'smartparens-config)
(smartparens-mode 1)

(ace-popup-menu-mode 1)
(ace-link-setup-default)

;;(global-linum-mode 1)
(delete-selection-mode 1)
(winner-mode 1)
(autoload 'ibuffer "ibuffer" "List buffers." t)

;;----------------------------------------------------------------------------
;; Env etc. setting 
;;----------------------------------------------------------------------------
;; mute notifications and sounds
(setq use-dialog-box nil)
(setq ring-bell-function 'ignore)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(menu-bar-mode -1)
(tool-bar-mode -1)
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
    (flx-ido projectile elpy ob-ipython ob-translate cmake-mode ess-smart-underscore exec-path-from-shell citeproc-org org-tracktable academic-phrases org-journal bbdb ess magit ox-reveal imenu-anywhere org-ref org-brain org-noter ace-popup-menu pdf-tools define-word ace-link toc-org hydra easy-hugo elfeed yasnippet company-statistics pos-tip w3m smartparens whole-line-or-region doom-themes langtool company dracula-theme helm)))
 '(safe-local-variable-values (quote ((org-confirm-babel-evaluate))))
 '(send-mail-function (quote smtpmail-send-it))
 '(show-paren-mode t)
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
 '(default ((t (:inherit nil :stipple nil :background "#282a36" :foreground "gray80" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "nil" :family "Hack"))))
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
 '(org-level-1 ((t (:inherit bold :foreground "plum2" :height 1.2))))
 '(org-level-2 ((t (:inherit bold :foreground "sky blue" :height 1.1))))
 '(org-level-3 ((t (:foreground "#bd93f9" :weight normal :height 1.05))))
 '(org-level-4 ((t (:foreground "yellow green" :weight normal))))
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
