;; init-themes.el --- Defaults for themes -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require-package 'color-theme-sanityinc-solarized)
(require-package 'color-theme-sanityinc-tomorrow)

;; Don't prompt to confirm theme safety. This avoids problems with
;; first-time startup on Emacs > 26.3.
(setq custom-safe-themes t)

;; If you don't customize it, this is the theme you get.
(setq-default custom-enabled-themes '(poet))

;;---------------------------
(require 'disable-mouse)
(global-disable-mouse-mode)

(when window-system
  (blink-cursor-mode 0)                           ; Disable the cursor blinking
  (scroll-bar-mode 0)                             ; Disable the scroll bar
  (tool-bar-mode 0)                               ; Disable the tool bar
  (tooltip-mode 0)
  (menu-bar-mode 1)
  (global-linum-mode 0))                               ; Disable the tooltips

(setq-default show-trailing-whitespace nil
              tab-width 4)
(delete-selection-mode 1)

;; (use-package doom-modeline
;;   :ensure t
;;   :init (doom-modeline-mode 0)
;;   :config
;;   (doom-modeline-def-modeline 'my-simple-line
;;     '(bar matches buffer-info)
;;     '(major-mode))
;;   ;; Add to `doom-modeline-mode-hook` or other hooks
;;   (defun setup-custom-doom-modeline ()
;;     (doom-modeline-set-modeline 'my-simple-line 'default))
;;   (add-hook 'doom-modeline-mode-hook 'setup-custom-doom-modeline)
;;   (setq doom-modeline-buffer-file-name-style 'file-name
;;         mode-line-percent-position nil
;;         doom-modeline-vcs-max-length 3
;;         doom-modeline-major-mode-icon nil
;;         doom-modeline-major-mode-color-icon nil
;;         doom-modeline-buffer-state-icon nil
;;         doom-modeline-buffer-modification-icon t
;;         doom-modeline-enable-word-count nil
;;         inhibit-compacting-font-caches t
;;         doom-modeline-continuous-word-count-modes 'org-mode
;;         doom-modeline-indent-info nil
;;         doom-modeline-minor-modes nil
;;         doom-modeline-buffer-encoding t
;;         doom-modeline-checker-simple-format t
;;         doom-modeline-lsp nil
;;         doom-modeline-modal-icon nil
;;         doom-modeline-bar-width 3
;;         doom-modeline-height 12))

;; set transparency (was 85)
(set-frame-parameter (selected-frame) 'alpha '(85 85))
(add-to-list 'default-frame-alist '(alpha 85 85))





;; Ensure that themes will be applied even if they have not been customized
(defun reapply-themes ()
  "Forcibly load the themes listed in `custom-enabled-themes'."
  (dolist (theme custom-enabled-themes)
    (unless (custom-theme-p theme)
      (load-theme theme)))
  (custom-set-variables `(custom-enabled-themes (quote ,custom-enabled-themes))))

(add-hook 'after-init-hook 'reapply-themes)


;;------------------------------------------------------------------------------
;; Toggle between light and dark
;;------------------------------------------------------------------------------
(defun dark ()
  "Activate a light color theme."
  (interactive)
  (setq custom-enabled-themes '(poet-dark))
  (reapply-themes))

(defun solarized ()
  "Activate a dark color theme."
  (interactive)
  (setq custom-enabled-themes '(doom-solarized-light))
  (reapply-themes))

(defun code ()
  "Activate a dark color theme."
  (interactive)
  (setq custom-enabled-themes '(sanityinc-tomorrow-bright))
  (reapply-themes))

(when (maybe-require-package 'dimmer)
  (setq-default dimmer-fraction 0.15)
  (add-hook 'after-init-hook 'dimmer-mode)
  (after-load 'dimmer
    ;; TODO: file upstream as a PR
    (advice-add 'frame-set-background-mode :after (lambda (&rest args) (dimmer-process-all))))
  (after-load 'dimmer
    ;; Don't dim in terminal windows. Even with 256 colours it can
    ;; lead to poor contrast.  Better would be to vary dimmer-fraction
    ;; according to frame type.
    (defun sanityinc/display-non-graphic-p ()
      (not (display-graphic-p)))
    (push 'sanityinc/display-non-graphic-p dimmer-exclusion-predicates)))

;;------------------------------------------------------------------------------
;; Mixed-font
;;------------------------------------------------------------------------------
(add-hook 'org-mode-hook
          (lambda ()
            (variable-pitch-mode 1)))
(set-face-attribute 'default nil :family "Hack" :height 130)
(set-face-attribute 'fixed-pitch nil :family "Hack")
(set-face-attribute 'variable-pitch nil :family "Rockwell")


(provide 'ying-themes)
