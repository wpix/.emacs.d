(autoload 'ibuffer "ibuffer" "List buffers." t)
;;================== i v y ========================
;; (ivy-mode 1)
;; (setq ivy-use-virtual-buffers t)
;; (setq enable-recursive-minibuffers t)
;; ;; enable this if you want `swiper' to use it
;; ;; (setq search-default-mode #'char-fold-to-regexp)
;; (global-set-key "\C-s" 'swiper)
;; (global-set-key (kbd "C-c C-r") 'ivy-resume)
;; (global-set-key (kbd "M-x") 'counsel-M-x)
;; (global-set-key (kbd "C-x C-f") 'counsel-find-file)
;; ;; (global-set-key (kbd "<f1> f") 'counsel-describe-function)
;; ;; (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;; ;; (global-set-key (kbd "<f1> l") 'counsel-find-library)
;; ;; (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;; ;; (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
;; (global-set-key (kbd "C-c g") 'counsel-git)
;; (global-set-key (kbd "C-c j") 'counsel-git-grep)
;; (global-set-key (kbd "C-c k") 'counsel-ag)
;; (global-set-key (kbd "C-x l") 'counsel-locate)
;; (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
;; (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;;====================== a c e ===============================
(ace-popup-menu-mode 1)
(ace-link-setup-default)
(define-key org-mode-map (kbd "M-l") 'ace-link-org)
;(define-key org-mode-map (kbd "M-o") 'ace-window)
(global-set-key (kbd "M-o") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
(setq aw-background nil)
(defvar aw-dispatch-alist
  '(;(?x aw-delete-window "Delete Window")
	(?m aw-swap-window "Swap Windows")
	(?M aw-move-window "Move Window")
	(?c aw-copy-window "Copy Window")
	(?j aw-switch-buffer-in-window "Select Buffer")
	(?n aw-flip-window)
	(?u aw-switch-buffer-other-window "Switch Buffer Other Window")
	(?c aw-split-window-fair "Split Fair Window")
	;(?v aw-split-window-vert "Split Vert Window")
	;(?b aw-split-window-horz "Split Horz Window")
	(?o delete-other-windows "Delete Other Windows")
	(?? aw-show-dispatch-help))
  "List of actions for `aw-dispatch-default'.")

;;===================== a v y =============================
(global-set-key (kbd "C-x a i j") 'avy-goto-char-timer)
(global-set-key (kbd "C-x a i l") 'avy-goto-line)
(define-key org-mode-map (kbd "C-x a i h") 'avy-org-goto-heading-timer)
(avy-setup-default)
(global-set-key (kbd "C-c C-j") 'avy-resume)


;;================ h e l m ========================
(use-package helm
  :demand t
  :bind
  ("M-x" . helm-M-x)
  ("M-i" . helm-imenu)
  ("C-x c y" . 'helm-show-kill-ring)
  ("C-x c b" . 'helm-mini)
  ("C-x r b" . 'helm-filtered-bookmarks)
  ("C-x C-f" . 'helm-find-files)
  :init (require 'helm-config)
  :config
  (helm-mode 1)
  (setq helm-M-x-fuzzy-match t
		helm-buffers-fuzzy-matching t
		helm-recentf-fuzzy-match    t)
  (setq helm-split-window-in-side-p           t
		helm-move-to-line-cycle-in-source     t
		helm-ff-search-library-in-sexp        t
		helm-scroll-amount                    8
		helm-ff-file-name-history-use-recentf t
		helm-echo-input-in-header-line t))

;;(use-package helm-org-rifle)




;;===========================i d o=================
(use-package flx-ido
  :init
  (ido-mode 1)
  ;;(ido-everywhere 1)
  (flx-ido-mode 1)
  :config
  (setq ido-enable-flex-matching t)
  (setq ido-use-filename-at-point 'guess)
  (setq ido-create-new-buffer 'always)
  (setq ido-file-extensions-order '(".org" ".el" ".txt" ".py" ".emacs"))
  (setq ido-ignore-extensions nil)
  (setq recentf-max-saved-items 50)
  ;; disable ido faces to see flx highlights.
  (setq ido-enable-flex-matching t)
  (setq ido-use-faces nil))

;;========================t a g s =====================
(use-package etags
  :config
  (defun ido-find-tag ()
  "Find a tag using ido"
  (interactive)
  (tags-completion-table)
  (let (tag-names)
    (mapc (lambda (x)
        (unless (integerp x)
          (push (prin1-to-string x t) tag-names)))
      tags-completion-table)
    (find-tag (ido-completing-read "Tag: " tag-names))))

  (defun ido-find-file-in-tag-files ()
    (interactive)
    (save-excursion
      (let ((enable-recursive-minibuffers t))
        (visit-tags-table-buffer))
      (find-file
       (expand-file-name
        (ido-completing-read
         "Project file: " (tags-table-files) nil t))))))

(global-set-key [remap find-tag] 'ido-find-tag)
(global-set-key (kbd "C-M-t") 'ido-find-file-in-tag-files)




(provide 'init-hai)
