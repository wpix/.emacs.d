(global-set-key [(hyper a)] 'mark-whole-buffer)
(global-set-key [(hyper v)] 'yank)
(global-set-key [(hyper c)] 'kill-ring-save)
(global-set-key [(hyper s)] 'save-buffer)
(global-set-key [(hyper l)] 'goto-line)
(global-set-key [(hyper w)]
                (lambda () (interactive) (delete-window)))
(global-set-key [(hyper z)] 'undo)

;; mac switch meta key
(defun mac-switch-meta nil 
  "switch meta between Option and Command"
  (interactive)
  (if (eq mac-option-modifier nil)
      (progn
	(setq mac-option-modifier 'meta)
	(setq mac-command-modifier 'hyper)
	)
    (progn 
      (setq mac-option-modifier nil)
      (setq mac-command-modifier 'meta)
      )
    )
  )

;;mastering emacs keybindings
(define-key global-map (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-a") 'back-to-indentation)
(global-set-key (kbd "M-C-u") 'mark-sexp)
                                        ;(global-set-key (kbd "C-M-u") 'sp-up-sex)
;;====================== o r g  ===============================
                                        ;(global-set-key (kbd "C-c m") 'org-mark-ring-push)
                                        ;(global-set-key (kbd "C-c r") 'org-mark-ring-goto)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-iswitchb)
(define-key global-map "\C-cc" 'org-capture)


;;===================== ido/ibuffer.imenu ====================
(global-set-key (kbd "M-C-h") #'imenu-anywhere)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; (defun ido-recentf-open ()
;;   "Use `ido-completing-read' to \\[find-file] a recent file"
;;   (interactive)
;;   (if (find-file (ido-completing-read "Find recent file: " recentf-list))
;;       (message "Opening file...")
;;     (message "Aborting")))
;; (global-set-key (kbd "C-x C-r") 'ido-recentf-open)

;;==================== OTHERS ==============================
(defun jump-to-mark ()
  "Jumps to the local mark, respecting the `mark-ring' order.
  This is the same as using \\[set-mark-command] with the prefix argument."
  (interactive)
  (set-mark-command 1))
(global-set-key (kbd "M-'") 'jump-to-mark)

;;https://www.masteringemacs.org/article/searching-buffers-occur-mode
(eval-when-compile
  (require 'cl))
(defun get-buffers-matching-mode (mode)
  "Returns a list of buffers where their major-mode is equal to MODE"
  (let ((buffer-mode-matches '()))
   (dolist (buf (buffer-list))
     (with-current-buffer buf
       (if (eq mode major-mode)
           (add-to-list 'buffer-mode-matches buf))))
   buffer-mode-matches))

(defun multi-occur-in-this-mode ()
  "Show all lines matching REGEXP in buffers with this major mode."
  (interactive)
  (multi-occur
   (get-buffers-matching-mode major-mode)
   (car (occur-read-primary-args))))
;; global key for `multi-occur-in-this-mode' - you should change this.
(global-set-key (kbd "M-.") 'multi-occur-in-this-mode)


;;================= w i n d o w =================
(global-set-key (kbd "M-SPC") 'other-window)
(global-set-key (kbd "C-x C-k") 'kill-this-buffer)

;;==================== appearance ==========================
(defun xah-toggle-line-spacing ()
  "Toggle line spacing between no extra space to extra half line height.
URL `http://ergoemacs.org/emacs/emacs_toggle_line_spacing.html'
Version 2017-06-02"
  (interactive)
  (if line-spacing
      (setq line-spacing nil)
    (setq line-spacing 0.25))
  (redraw-frame (selected-frame)))

;; (add-hook 'dired-mode-hook 'dired-hide-details-mode)

;; (require 'ibuf-ext)
;; (add-to-list 'ibuffer-never-show-predicates "^\\*")

;; (setq ibuffer-fontification-alist
;; 	'((2 (eq major-mode 'org-mode) highlight-face)
;; 	  (1 (eq major-mode 'emacs-lisp-mode) pink-face)
;; 	  (3 (eq major-mode 'pdf-view-mode) green-face)
;; 	  (3 (eq major-mode 'bibtex-mode) dim-face)
;; 	  (4 (eq major-mode 'dired-mode) dired-face)
;; 	  (5 (eq major-mode 'fundamental-mode) purple-face)
;; 	  (5 (eq major-mode 'help-mode) dim-face)
;; 	  (5 (eq major-mode 'Custom-mode) dim-face)))

;; (defface pink-face '((t :foreground "hot pink")) "")
;; (defface purple-face '((t :foreground "#d6cbd3")) "")
;; (defface green-face '((t :foreground "light green")) "")
;; (defface dim-face '((t :foreground "#ada397")) "")
;; (defface highlight-face '((t :foreground "yellow")) "")
;; (defface dired-face '((t :foreground "black" :background "lavender")) "")

;; Use human readable Size column instead of original one
;; (define-ibuffer-column size-h
;;   (:name "Size" :inline t)
;;   (cond
;;    ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
;;    ((> (buffer-size) 100000) (format "%7.0fk" (/ (buffer-size) 1000.0)))
;;    ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
;;    (t (format "%8d" (buffer-size)))))

;; ;; Modify the default ibuffer-formats
;;   (setq ibuffer-formats
;; 	'((mark modified read-only " "
;; 		(name 18 18 :left :elide)
;; 		" "
;; 		(size-h 9 -1 :right)
;; 		" "
;; 		(mode 16 16 :left :elide)
;; 		" "
;; 		filename-and-process)))


;; (setq mp/ibuffer-collapsed-groups (list "*Internal*"))
;; ;https://www.emacswiki.org/emacs/IbufferMode
;; (defadvice ibuffer (after collapse-helm)
;;   (dolist (group mp/ibuffer-collapsed-groups)
;; 	  (progn
;; 	    (goto-char 1)
;; 	    (when (search-forward (concat "[ " group " ]") (point-max) t)
;; 	      (progn
;; 		(move-beginning-of-line nil)
;; 		(ibuffer-toggle-filter-group)
;; 		)
;; 	      )
;; 	    )
;; 	  )
;;     (goto-char 1)
;;     (search-forward "[ " (point-max) t)
;;   )

;; (ad-activate 'ibuffer)


(provide 'ying-keybindings)
