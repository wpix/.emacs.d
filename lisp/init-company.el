
(require 'company)
(global-company-mode)
(add-hook 'after-init-hook 'global-company-mode)
(require 'company-statistics)
(company-statistics-mode)
(add-hook 'after-init-hook 'company-statistics-mode)

;;(defun add-pcomplete-to-capf ()
  ;;(add-hook 'completion-at-point-functions 'pcomplete-completions-at-point nil t))
;;(add-hook 'org-mode-hook #'add-pcomplete-to-capf)

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
      company-dabbrev-downcase        nil
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
(define-key company-active-map [tab] 'company-complete-selection)
(define-key company-active-map (kbd "TAB") 'company-complete-selection)
;;(define-key company-active-map (kbd "SPC") #'company-complete-selection)
(define-key company-active-map (kbd "SPC") nil)
;;(define-key company-active-map (kbd "RET") nil)

(defun my-company-after-completion-hook (&rest _ignored) 
  ;; this would be called with the completion candidate, so you could
  ;; modify it to insert spaces based on the candidate
  (just-one-space))
;; or setq-local in a mode hook, eg. for text-mode/org-mode or wherever you are
;; completing with dictionary words 
(setq company-completion-finished-hook #'my-company-after-completion-hook)


;;https://github.com/expez/company-quickhelp#is-it-any-good
;;(company-quickhelp-mode)
;;(setq company-quickhelp-delay 0.5)


(provide 'init-company)
