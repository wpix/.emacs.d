(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)

(when (maybe-require-package 'company)
  (add-hook 'after-init-hook 'global-company-mode)
  (after-load 'company
    (dolist (backend '(company-eclim company-semantic))
      (delq backend company-backends))
    (diminish 'company-mode)
                                        ;    (define-key company-mode-map (kbd "M-/") 'company-complete)
                                        ;    (define-key company-active-map (kbd "M-/") 'company-other-backend)
    (define-key company-active-map (kbd "C-n") 'company-select-next)
    (define-key company-active-map (kbd "C-p") 'company-select-previous)
    (setq-default company-dabbrev-other-buffers 'all
                  company-tooltip-align-annotations t))
                                        ;  (global-set-key (kbd "M-C-/") 'company-complete)
  (when (maybe-require-package 'company-quickhelp)
    (add-hook 'after-init-hook 'company-quickhelp-mode)))

;; Suspend page-break-lines-mode while company menu is active
;; (see https://github.com/company-mode/company-mode/issues/416)
(after-load 'company
  (after-load 'page-break-lines
    (defvar-local sanityinc/page-break-lines-on-p nil)

    (defun sanityinc/page-break-lines-disable (&rest ignore)
      (when (setq sanityinc/page-break-lines-on-p (bound-and-true-p page-break-lines-mode))
        (page-break-lines-mode -1)))

    (defun sanityinc/page-break-lines-maybe-reenable (&rest ignore)
      (when sanityinc/page-break-lines-on-p
        (page-break-lines-mode 1)))

    (add-hook 'company-completion-started-hook 'sanityinc/page-break-lines-disable)
    (add-hook 'company-after-completion-hook 'sanityinc/page-break-lines-maybe-reenable)))


(require 'company-statistics)
(company-statistics-mode)
(add-hook 'after-init-hook 'company-statistics-mode)

;; {{ setup company-ispell
(defun toggle-company-ispell ()
  (interactive)
  (cond
   ((memq 'company-ispell company-backends)
    (setq company-backends (delete 'company-ispell company-backends))
    (message "company-ispell disabled"))
   (t
    (add-to-list 'company-backends 'company-ispell)
    (message "company-ispell enabled!"))))

(defun company-ispell-setup ()
  ;; @see https://github.com/company-mode/company-mode/issues/50
  (when (boundp 'company-backends)
    (make-local-variable 'company-backends)
    (add-to-list 'company-backends 'company-ispell)
    ;; https://github.com/redguardtoo/emacs.d/issues/473
    (cond
     ((and (boundp 'ispell-alternate-dictionary)
           ispell-alternate-dictionary)
      (setq company-ispell-dictionary ispell-alternate-dictionary))
     (t
      (setq company-ispell-dictionary (file-truename "~/.emacs.d/misc/english-words.txt"))))))

(add-hook 'text-mode-hook 'company-ispell-setup)
(add-hook 'message-mode-hook 'company-ispell-setup)

(setq company-idle-delay              0
      company-minimum-prefix-length   3
      company-show-numbers            t
      company-tooltip-limit           9
      company-dabbrev-downcase        t
      company-require-match           nil
      company-dabbrev-other-buffers   t
      company-transformers '(company-sort-by-occurrence))
(setq company-frontends '(company-pseudo-tooltip-frontend))
(setq company-auto-complete-chars nil)


;;(defun company-complete-common-or-cycle ()
;;(interactive)
;;(when (company-manual-begin)
;;(if (eq last-command 'company-complete-common-or-cycle)
;;  (let ((company-selection-wrap-around t))
;;  (call-interactively 'company-select-next))
;;(call-interactively 'company-complete-common))))
(define-key company-active-map (kbd "TAB") 'company-complete-selection)
;;(define-key company-active-map (kbd "SPC") #'company-complete-selection)
(define-key company-active-map (kbd "SPC") nil)
;;(define-key company-active-map (kbd "RET") nil)

;; (defun my-company-after-completion-hook (&rest _ignored) 
;;   ;; this would be called with the completion candidate, so you could
;;   ;; modify it to insert spaces based on the candidate
;;   (just-one-space))
;; ;; or setq-local in a mode hook, eg. for text-mode/org-mode or wherever you are
;; ;; completing with dictionary words
;; (setq company-completion-finished-hook #'my-company-after-completion-hook)

;;https://github.com/expez/company-quickhelp#is-it-any-good
;;(company-quickhelp-mode)
;;(setq company-quickhelp-delay 0.5)

(use-package company-box
  :hook (company-mode . company-box-mode))




(provide 'ying-company)
