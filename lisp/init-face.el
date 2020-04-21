;;========================================================
;;                     d e f a u l t
;;========================================================
(when window-system
  (blink-cursor-mode 0)                           ; Disable the cursor blinking
  (scroll-bar-mode 0)                             ; Disable the scroll bar
  (tool-bar-mode 0)                               ; Disable the tool bar
  (tooltip-mode 0))                               ; Disable the tooltips

(setq-default
 ad-redefinition-action 'accept                   ; Silence warnings for redefinition
 auto-window-vscroll nil                          ; Lighten vertical scroll
 confirm-kill-emacs 'yes-or-no-p                  ; Confirm before exiting Emacs
 cursor-in-non-selected-windows nil               ; Hide the cursor in inactive windows
 delete-by-moving-to-trash t                      ; Delete files to trash
 display-time-default-load-average nil            ; Don't display load average
 display-time-format "%H:%M"                      ; Format the time string
 fill-column 80                                   ; Set width for automatic line breaks
 help-window-select t                             ; Focus new help windows when opened
 indent-tabs-mode nil                             ; Stop using tabs to indent
 inhibit-startup-screen t                         ; Disable start-up screen
 initial-scratch-message ""                       ; Empty the initial *scratch* buffer
 mouse-yank-at-point t                            ; Yank at point rather than pointer
 ns-use-srgb-colorspace nil                       ; Don't use sRGB colors
 recenter-positions '(5 top bottom)               ; Set re-centering positions
 scroll-conservatively most-positive-fixnum       ; Always scroll by one line
 scroll-margin 10                                 ; Add a margin when scrolling vertically
 select-enable-clipboard t                        ; Merge system's and Emacs' clipboard
 sentence-end-double-space nil                    ; End a sentence after a dot and a space
 show-help-function nil                           ; Disable help messages
 show-trailing-whitespace nil                     ; Display trailing whitespaces
 split-height-threshold nil                       ; Disable vertical window splitting
 split-width-threshold nil                        ; Disable horizontal window splitting
 tab-width 4                                      ; Set width for tabs
 uniquify-buffer-name-style 'forward              ; Uniquify buffer names
 window-combination-resize t                      ; Resize windows proportionally
 x-stretch-cursor t)                              ; Stretch cursor to the glyph width
(cd "~/")                                         ; Move to the user directory
(delete-selection-mode 1)                         ; Replace region when inserting text
(display-time-mode 1)                             ; Enable time in the mode-line
(fringe-mode 0)                                   ; Disable fringes
(fset 'yes-or-no-p 'y-or-n-p)                     ; Replace yes/no prompts with y/n
(global-subword-mode 1)                           ; Iterate through CamelCase words
(menu-bar-mode 0)                                 ; Disable the menu bar
(mouse-avoidance-mode 'banish)                    ; Avoid collision of mouse with point
(put 'downcase-region 'disabled nil)              ; Enable downcase-region
(put 'upcase-region 'disabled nil)                ; Enable upcase-region
(set-default-coding-systems 'utf-8)               ; Default to utf-8 encoding

;; mute notifications and sounds
(setq use-dialog-box nil)
(setq ring-bell-function 'ignore)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
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

;;========================================================
;;                     t h e m e s
;;========================================================
;;themes and fonts
(load-theme 'dracula t)
;; (use-package smart-mode-line
;;   :config
;;   (setq sml/theme 'atom-one-dark)
;;   (sml/setup))
;; set transparency
(set-frame-parameter (selected-frame) 'alpha '(75 75))
(add-to-list 'default-frame-alist '(alpha 75 75))
;;========================================================
;;                     f o n t
;;========================================================
;; (defun qiang-font-existsp (font)
;;   (if (null (x-list-fonts font))
;;       nil
;;     t))

;; (defvar zh-font-list '("PingFang SC" "Hiragino Sans GB" "Microsoft Yahei" "Source Han Sans Normal" "STHeiti" "黑体" "新宋体" "宋体"))
;; (defvar en-font-list '("DejaVu Sans Mono" "Monaco" "Consolas" "Monospace" "Courier New"))

;; (defun qiang-make-font-string (font-name font-size)
;;   (if (and (stringp font-size)
;;            (equal ":" (string (elt font-size 0))))
;;       (format "%s%s" font-name font-size)
;;     (format "%s %s" font-name font-size)))

;; (defun qiang-set-font (english-fonts
;;                        english-font-size
;;                        chinese-fonts
;;                        &optional chinese-font-scale)

;;   (setq chinese-font-scale (or chinese-font-scale 1.2))

;;   (setq face-font-rescale-alist
;;         (loop for x in zh-font-list
;;               collect (cons x chinese-font-scale)))

;;   "english-font-size could be set to \":pixelsize=18\" or a integer.
;; If set/leave chinese-font-scale to nil, it will follow english-font-size"

;;   (require 'cl)                         ; for find if
;;   (let ((en-font (qiang-make-font-string
;;                   (find-if #'qiang-font-existsp english-fonts)
;;                   english-font-size))
;;         (zh-font (font-spec :family (find-if #'qiang-font-existsp chinese-fonts))))

;;     ;; Set the default English font
;;     (message "Set English Font to %s" en-font)
;;     (set-face-attribute 'default nil :font en-font)

;;     ;; Set Chinese font
;;     ;; Do not use 'unicode charset, it will cause the English font setting invalid
;;     (message "Set Chinese Font to %s" zh-font)
;;     (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;       (set-fontset-font (frame-parameter nil 'font)
;;                         charset zh-font))))

;; (qiang-set-font en-font-list 14 zh-font-list)

;;========================================================
;;                     e m a c s 
;;========================================================
(put 'set-goal-column 'disabled nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("855eb24c0ea67e3b64d5d07730b96908bac6f4cd1e5a5986493cbac45e9d9636" default)))
 '(org-journal-date-format "%A, %d %B %Y")
 '(org-journal-date-prefix "#+TITLE: ")
 '(org-journal-dir "~/org/wiki/")
 '(org-journal-file-format "%Y-%m-%d.org")
 '(org-journal-file-type (quote daily))
 '(org-roam-directory "~/org/wiki/")
 '(package-selected-packages
   (quote
    (org-download deft yasnippet-snippets whole-line-or-region wc-goal-mode w3m use-package toc-org smartparens smart-mode-line-atom-one-dark-theme pyim projectile pos-tip ox-reveal ox-pandoc osx-dictionary org-super-agenda org-pdftools org-journal org-brain ob-translate ob-ipython markdown-mode magit langtool imenu-anywhere helm-org-rifle focus flx-ido exec-path-from-shell ess-smart-underscore emojify elpy elfeed ebib easy-hugo dracula-theme define-word counsel company-statistics company-org-roam cnfonts cmake-mode citeproc-org bbdb auto-compile anki-editor ace-window ace-popup-menu ace-link academic-phrases))))
 '(exec-path-from-shell-check-startup-files nil)
 '(flyspell-use-global-abbrev-table-p t)
 '(gnus-treat-hide-citation-maybe t)
 '(google-this-keybind "C-c / g")
 '(ido-enable-flex-matching t)
 '(ispell-highlight-face (quote flyspell-incorrect))
 '(line-number-mode nil)
 '(line-spacing 0.2)
 '(notmuch-address-internal-completion (quote (received nil)))
 '(notmuch-draft-folder "")
 '(notmuch-draft-save-plaintext nil)
 '(notmuch-hello-sections
   (quote
    (notmuch-hello-insert-header notmuch-hello-insert-saved-searches notmuch-hello-insert-search notmuch-hello-insert-recent-searches notmuch-hello-insert-alltags notmuch-hello-insert-footer)))
 '(notmuch-mua-cite-function (quote ignore))
 '(notmuch-mua-reply-insert-header-p-function (quote ignore))
 '(notmuch-saved-searches nil)
 '(notmuch-search-line-faces
   (quote
    (("unread" . notmuch-search-unread-face)
     ("flagged" . notmuch-search-flagged-face))))
 '(notmuch-show-indent-multipart t)
 '(notmuch-show-logo nil)
 '(notmuch-show-relative-dates nil)
 '(notmuch-tag-added-formats
   (quote
    (("list"
      (notmuch-apply-face tag
			  (quote
			   (:foreground "gray33")))))))
 '(package-selected-packages
   (quote
    (swiper citeproc org-super-agenda osx-dictionary helm-org-rifle ace-window emojify markdown-mode anki-editor focus ox-pandoc ebib wc-goal-mode auto-compile use-package cnfonts posframe yasnippet-snippets flx-ido projectile elpy ob-ipython ob-translate cmake-mode ess-smart-underscore exec-path-from-shell citeproc-org org-tracktable academic-phrases org-journal bbdb ess magit ox-reveal imenu-anywhere org-ref org-brain org-noter ace-popup-menu pdf-tools define-word ace-link toc-org hydra easy-hugo elfeed yasnippet company-statistics pos-tip w3m smartparens whole-line-or-region doom-themes langtool company dracula-theme helm)))
 '(projectile-mode t nil (projectile))
 '(pyim-default-scheme (quote rime))
 '(pyim-dicts
   (quote
    ((:name "big" :file "/Users/Ying/.emacs.d/pyim/pyim-bigdict.pyim"))))
 '(pyim-english-input-switch-functions (quote (pyim-probe-isearch-mode)))
 '(pyim-exhibit-delay-ms 0)
 '(pyim-isearch-mode nil nil (pyim))
 '(pyim-magic-converter nil)
 '(pyim-page-style (quote one-line))
 '(pyim-page-tooltip (quote pos-tip))
 '(pyim-schemes
   (quote
    ((rime-flypy :document "support ;" :class rime :first-chars "abcdefghijklmnopqrstuvwxyz/" :rest-chars "abcdefghijklmnopqrstuvwxyz;=/,\\" :prefer-trigger-chars nil)
     (quanpin :document "全拼输入法方案（不可删除）。" :class quanpin :first-chars "abcdefghijklmnopqrstuwxyz" :rest-chars "vmpfwckzyjqdltxuognbhsrei'-a" :prefer-trigger-chars "v")
     (rime :document "rime 输入法。这个 scheme 适用于 librime 支持的所有输入法，通用性较好，但无法支持 trigger-chars, 所以类似 pyim 全拼支持的v快捷键将无法使用。" :class rime :first-chars "abcdefghijklmnopqrstuvwxyz" :rest-chars "abcdefghijklmnopqrstuvwxyz'-a" :prefer-trigger-chars nil)
     (rime-quanpin :document "rime 全拼输入法。

这个 scheme 专门用于 librime 全拼输入法，同时支持 trigger-chars,
也就是v快捷键，使用 rime 全拼的朋友建议使用这个 scheme。" :class rime :first-chars "abcdefghjklmnopqrstwxyz" :rest-chars "vmpfwckzyjqdltxuognbhsrei'-a" :prefer-trigger-chars "v")
     (rime-microsoft-shuangpin :document "rime 微软双拼输入法。" :class rime :first-chars "abcdefghijklmnopqrstuvwxyz" :rest-chars "abcdefghijklmnopqrstuvwxyz;" :prefer-trigger-chars nil)
     (wubi :document "五笔输入法。" :class xingma :first-chars "abcdefghijklmnopqrstuvwxyz" :rest-chars "abcdefghijklmnopqrstuvwxyz'" :code-prefix "." :code-split-length 4 :code-maximum-length 4 :prefer-trigger-chars nil)
     (cangjie :document "倉頡输入法。" :class xingma :first-chars "abcdefghijklmnopqrstuvwxyz" :rest-chars "abcdefghijklmnopqrstuvwxyz" :code-prefix "@" :code-split-length 5 :code-maximum-length 5 :prefer-trigger-chars nil)
     (pyim-shuangpin :document "与 pyim 配合良好的双拼输入法方案，源自小鹤双拼方案。" :class shuangpin :first-chars "abcdefghijklmnpqrstuvwxyz" :rest-chars "abcdefghijklmnopqrstuvwxyz" :prefer-trigger-chars "o" :keymaps
		     (("a" "a" "a")
		      ("b" "b" "in")
		      ("c" "c" "ao")
		      ("d" "d" "ai")
		      ("e" "e" "e")
		      ("f" "f" "en")
		      ("g" "g" "eng")
		      ("h" "h" "ang")
		      ("i" "ch" "i")
		      ("j" "j" "an")
		      ("k" "k" "ing" "uai")
		      ("l" "l" "iang" "uang")
		      ("m" "m" "ian")
		      ("n" "n" "iao")
		      ("o" "o" "uo" "o")
		      ("p" "p" "ie")
		      ("q" "q" "iu")
		      ("r" "r" "uan")
		      ("s" "s" "iong" "ong")
		      ("t" "t" "ue" "ve")
		      ("u" "sh" "u")
		      ("v" "zh" "v" "ui")
		      ("w" "w" "ei")
		      ("x" "x" "ia" "ua")
		      ("y" "y" "un")
		      ("z" "z" "ou")
		      ("aa" "a")
		      ("aj" "an")
		      ("ad" "ai")
		      ("ac" "ao")
		      ("ah" "ang")
		      ("ee" "e")
		      ("ew" "ei")
		      ("ef" "en")
		      ("er" "er")
		      ("eg" "eng")
		      ("ag" "ng")
		      ("ao" "o")
		      ("au" "ou")))
     (ziranma-shuangpin :document "自然码双拼方案。" :class shuangpin :first-chars "abcdefghijklmnopqrstuvwxyz" :rest-chars "abcdefghijklmnopqrstuvwxyz" :prefer-trigger-chars nil :keymaps
			(("a" "a" "a")
			 ("b" "b" "ou")
			 ("c" "c" "iao")
			 ("d" "d" "uang" "iang")
			 ("e" "e" "e")
			 ("f" "f" "en")
			 ("g" "g" "eng")
			 ("h" "h" "ang")
			 ("i" "ch" "i")
			 ("j" "j" "an")
			 ("k" "k" "ao")
			 ("l" "l" "ai")
			 ("m" "m" "ian")
			 ("n" "n" "in")
			 ("o" "o" "uo" "o")
			 ("p" "p" "un")
			 ("q" "q" "iu")
			 ("r" "r" "uan" "er")
			 ("s" "s" "iong" "ong")
			 ("t" "t" "ue" "ve")
			 ("u" "sh" "u")
			 ("v" "zh" "v" "ui")
			 ("w" "w" "ia" "ua")
			 ("x" "x" "ie")
			 ("y" "y" "uai" "ing")
			 ("z" "z" "ei")
			 ("aa" "a")
			 ("an" "an")
			 ("ai" "ai")
			 ("ao" "ao")
			 ("ah" "ang")
			 ("ee" "e")
			 ("ei" "ei")
			 ("en" "en")
			 ("er" "er")
			 ("eg" "eng")
			 ("oo" "o")
			 ("ou" "ou")))
     (microsoft-shuangpin :document "微软双拼方案。" :class shuangpin :first-chars "abcdefghijklmnopqrstuvwxyz" :rest-chars "abcdefghijklmnopqrstuvwxyz;" :prefer-trigger-chars nil :keymaps
			  (("a" "a" "a")
			   ("b" "b" "ou")
			   ("c" "c" "iao")
			   ("d" "d" "uang" "iang")
			   ("e" "e" "e")
			   ("f" "f" "en")
			   ("g" "g" "eng")
			   ("h" "h" "ang")
			   ("i" "ch" "i")
			   ("j" "j" "an")
			   ("k" "k" "ao")
			   ("l" "l" "ai")
			   ("m" "m" "ian")
			   ("n" "n" "in")
			   ("o" "o" "uo" "o")
			   ("p" "p" "un")
			   ("q" "q" "iu")
			   ("r" "r" "uan" "er")
			   ("s" "s" "iong" "ong")
			   ("t" "t" "ue")
			   ("u" "sh" "u")
			   ("v" "zh" "ve" "ui")
			   ("w" "w" "ia" "ua")
			   ("x" "x" "ie")
			   ("y" "y" "uai" "v")
			   ("z" "z" "ei")
			   (";" ";" "ing")
			   ("oa" "a")
			   ("oj" "an")
			   ("ol" "ai")
			   ("ok" "ao")
			   ("oh" "ang")
			   ("oe" "e")
			   ("oz" "ei")
			   ("of" "en")
			   ("or" "er")
			   ("og" "eng")
			   ("oo" "o")
			   ("ob" "ou")))
     (zhinengabc-shuangpin :document "智能ABC双拼方案" :class shuangpin :first-chars "abcdefghjklmnopqrstvwxyz" :rest-chars "abcdefghijklmnopqrstuvwxyz" :prefer-trigger-chars nil :keymaps
			   (("q" "q" "ei")
			    ("w" "w" "ian")
			    ("e" "ch" "e")
			    ("r" "r" "iu" "er")
			    ("t" "t" "uang" "iang")
			    ("y" "y" "ing")
			    ("u" "u" "u")
			    ("i" "i" "i")
			    ("o" "o" "o" "uo")
			    ("p" "p" "uan" "van")
			    ("a" "zh" "a")
			    ("s" "s" "ong" "iong")
			    ("d" "d" "ua" "ia")
			    ("f" "f" "en")
			    ("g" "g" "eng")
			    ("h" "h" "ang")
			    ("j" "j" "an")
			    ("k" "k" "ao")
			    ("l" "l" "ai")
			    ("z" "z" "iao")
			    ("x" "x" "ie")
			    ("c" "c" "in" "uai")
			    ("v" "sh" "v")
			    ("b" "b" "ou")
			    ("n" "n" "un")
			    ("m" "m" "ue" "ui")
			    ("oa" "a")
			    ("oj" "an")
			    ("ol" "ai")
			    ("ok" "ao")
			    ("oh" "ang")
			    ("oe" "e")
			    ("oz" "ei")
			    ("of" "en")
			    ("or" "er")
			    ("og" "eng")
			    ("oo" "o")
			    ("ob" "ou")))
     (xiaohe-shuangpin :document "小鹤双拼输入法方案。" :class shuangpin :first-chars "abcdefghijklmnopqrstuvwxyz" :rest-chars "abcdefghijklmnopqrstuvwxyz" :prefer-trigger-chars nil :keymaps
		       (("a" "a" "a")
			("b" "b" "in")
			("c" "c" "ao")
			("d" "d" "ai")
			("e" "e" "e")
			("f" "f" "en")
			("g" "g" "eng")
			("h" "h" "ang")
			("i" "ch" "i")
			("j" "j" "an")
			("k" "k" "ing" "uai")
			("l" "l" "iang" "uang")
			("m" "m" "ian")
			("n" "n" "iao")
			("o" "o" "uo" "o")
			("p" "p" "ie")
			("q" "q" "iu")
			("r" "r" "uan")
			("s" "s" "iong" "ong")
			("t" "t" "ue" "ve")
			("u" "sh" "u")
			("v" "zh" "v" "ui")
			("w" "w" "ei")
			("x" "x" "ia" "ua")
			("y" "y" "un")
			("z" "z" "ou")
			("aa" "a")
			("an" "an")
			("ai" "ai")
			("ao" "ao")
			("ah" "ang")
			("ee" "e")
			("ei" "ei")
			("en" "en")
			("er" "er")
			("eg" "eng")
			("og" "ng")
			("oo" "o")
			("ou" "ou"))))))
 '(safe-local-variable-values (quote ((org-confirm-babel-evaluate))))
 '(send-mail-function (quote smtpmail-send-it))
 '(show-paren-mode t)
 '(smtpmail-smtp-server "smtp.office365.com")
 '(smtpmail-smtp-service 25)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#282a36" :foreground "gray85" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "nil" :family "Hack"))))
 '(apropos-symbol ((t (:inherit ##))))
 '(awesome-tab-default ((t (:background "#31343E" :foreground "white"))))
 '(biblio-results-header-face ((t (:inherit font-lock-preprocessor-face :weight bold :height 1.2))))
 '(bold ((t (:weight semi-bold))))
 '(bold-italic ((t (:slant italic :weight semi-bold))))
 '(bookmark-menu-bookmark ((t (:weight semi-bold))))
 '(buffer-menu-buffer ((t (:weight semi-bold))))
 '(comint-highlight-input ((t (:weight semi-bold))))
 '(company-tooltip ((t (:background "#282a36" :foreground "#e2e2dc" :weight semi-bold))))
 '(compilation-mode-line-fail ((t (:inherit compilation-error :foreground "Red1" :weight semi-bold))))
 '(custom-changed ((t (:background "dark gray" :foreground "white"))))
 '(custom-invalid ((t (:background "dark gray" :foreground "dark red"))))
 '(custom-link ((t (:inherit link :foreground "LightSkyBlue2" :underline nil))))
 '(dired-directory ((t (:foreground "orchid" :weight semi-bold))))
 '(dired-flagged ((t (:foreground "light goldenrod"))))
 '(dired-header ((t (:background "#282a36" :foreground "gray90"))))
 '(dired-mark ((t (:foreground "#f8f8f2" :weight semi-bold))))
 '(dired-marked ((t (:foreground "#ffb86c" :weight semi-bold))))
 '(dired-symlink ((t (:foreground "thistle4" :slant italic :weight normal))))
 '(epa-field-name ((t (:foreground "PaleTurquoise" :weight semi-bold))))
 '(epa-mark ((t (:foreground "orange" :weight semi-bold))))
 '(error ((t (:foreground "Pink" :weight semi-bold))))
 '(ess-bp-fringe-recover-face ((t (:foreground "DarkOrchid1"))))
 '(ess-debug-blink-ref-not-found-face ((t (:background "dark gray"))))
 '(font-lock-function-name-face ((t (:foreground "orchid1" :weight semi-bold))))
 '(font-lock-keyword-face ((t (:foreground "#e872b3" :weight semi-bold))))
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
 '(helm-non-file-buffer ((t (:inherit italic :foreground "gray"))))
 '(helm-source-header ((t (:background "#282a36" :foreground "#ff79c6" :underline nil :weight semi-bold))))
 '(hydra-face-red ((t (:foreground "HotPink1" :weight bold))))
 '(ido-first-match ((t (:foreground "#ff79c6" :weight semi-bold))))
 '(info-node ((t (:foreground "white" :slant italic :weight semi-bold))))
 '(info-title-4 ((t (:inherit variable-pitch :weight semi-bold))))
 '(isearch ((t (:background "#464752" :foreground "#ffb86c" :weight semi-bold))))
 '(langtool-correction-face ((t (:background "dark red" :foreground "DarkGoldenrod3" :weight semi-bold))))
 '(message-cited-text ((t (:background "seashell" :foreground "gray10"))))
 '(message-header-cc ((t (:foreground "orchid1"))))
 '(message-header-name ((t (:foreground "plum1"))))
 '(message-header-newsgroups ((t (:foreground "yellow" :slant italic :weight semi-bold))))
 '(message-header-other ((t (:foreground "gray61"))))
 '(message-header-subject ((t (:foreground "light green" :underline t))))
 '(message-header-to ((t (:foreground "olive drab"))))
 '(message-mml ((t (:foreground "gray50" :weight normal))))
 '(message-separator ((t (:background "dark gray" :foreground "red4"))))
 '(minibuffer-prompt ((t (:foreground "#ff79c6" :weight semi-bold))))
 '(mode-line-buffer-id ((t (:weight semi-bold))))
 '(mode-line-emphasis ((t (:weight semi-bold))))
 '(notmuch-search-count ((t (:inherit default :foreground "gray30"))))
 '(notmuch-search-date ((t (:inherit default :foreground "gray45"))))
 '(notmuch-search-flagged-face ((t (:background "lemon chiffon" :foreground "black"))))
 '(notmuch-search-matching-authors ((t (:inherit default :foreground "gray85"))))
 '(notmuch-search-subject ((t (:inherit default :foreground "gray75" :family "avenir"))))
 '(notmuch-search-unread-face ((t (:background "dark gray" :foreground "Black" :weight semi-bold))))
 '(notmuch-tag-added ((t (:underline "light green"))))
 '(notmuch-tag-face ((t (:foreground "plum2"))))
 '(notmuch-tag-flagged ((t (:foreground "yellow" :weight semi-bold))))
 '(notmuch-tag-unread ((t (:foreground "IndianRed3" :weight semi-bold))))
 '(notmuch-tree-match-author-face ((t (:foreground "gray76"))))
 '(notmuch-tree-match-tag-face ((t (:foreground "plum"))))
 '(notmuch-wash-toggle-button ((t (:inherit font-lock-comment-face :foreground "selectedControlColor" :box (:line-width 1 :color "gray85" :style pressed-button)))))
 '(org-agenda-date ((t (:foreground "plum1" :underline nil))))
 '(org-agenda-date-today ((t (:inherit org-agenda-date :slant italic :weight semi-bold))))
 '(org-agenda-date-weekend ((t (:inherit org-agenda-date))))
 '(org-agenda-done ((t (:foreground "DarkOliveGreen3"))))
 '(org-block ((t (:background "#373844" :foreground "gray70"))))
 '(org-block-begin-line ((t (:inherit org-meta-line :foreground "olive drab"))))
 '(org-block-end-line ((t (:inherit org-block-begin-line :foreground "olive drab"))))
 '(org-column-title ((t (:inherit org-column :underline t :weight semi-bold))))
 '(org-date ((t (:foreground "light steel blue" :underline t))))
 '(org-document-title ((t (:foreground "#ffb86c" :weight semi-bold :height 1.3))))
 '(org-drawer ((t (:foreground "unemphasizedSelectedTextBackgroundColor"))))
 '(org-footnote ((t (:foreground "MediumPurple4"))))
 '(org-level-1 ((t (:inherit bold :foreground "orchid" :height 1.2))))
 '(org-level-2 ((t (:inherit bold :foreground "sky blue" :height 1.1))))
 '(org-level-3 ((t (:foreground "#bd93f9" :weight normal :height 1.05))))
 '(org-level-4 ((t (:foreground "plum" :weight normal))))
 '(org-level-5 ((t (:foreground "#ffb86c" :weight normal))))
 '(org-level-6 ((t (:foreground "sienna1" :weight normal))))
 '(org-link ((t (:foreground "#bdcebe" :box (:line-width 1 :color "gray50" :style pressed-button) :underline nil))))
 '(org-list-dt ((t (:weight semi-bold))))
 '(org-quote ((t (:inherit org-tag :foreground "lavender"))))
 '(org-ref-acronym-face ((t (:inherit org-link :foreground "thistle1"))))
 '(org-ref-cite-face ((t (:inherit org-link :foreground "gray50"))))
 '(org-ref-label-face ((t (:inherit org-link :foreground "light green"))))
 '(org-ref-ref-face ((t (:inherit org-link :foreground "orchid3"))))
 '(org-scheduled-today ((t (:foreground "VioletRed3"))))
 '(org-tag ((t (:background "#373844" :foreground "#ff79c6" :weight normal))))
 '(org-todo ((t (:background "#373844" :foreground "#ffb86c" :weight semi-bold))))
 '(org-warning ((t (:foreground "#ff79c6" :weight semi-bold))))
 '(popup-tip-face ((t (:background "gray20" :foreground "gray95"))))
 '(pyim-page ((t (:inherit default :background "gray25" :foreground "#dcdccc"))))
 '(read-multiple-choice-face ((t (:inherit underline :weight semi-bold))))
 '(success ((t (:foreground "DarkOliveGreen2" :weight semi-bold))))
 '(tty-menu-enabled-face ((t (:background "blue" :foreground "yellow" :weight semi-bold))))
 '(which-key-special-key-face ((t (:inherit which-key-key-face :inverse-video t :weight semi-bold))))
 '(widget-button ((t (:weight semi-bold)))))
