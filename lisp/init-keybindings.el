;;mastering emacs keybindings
(define-key global-map (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-a") 'back-to-indentation)

(global-set-key (kbd "M-SPC") 'mark-sexp)
(global-set-key (kbd "C-M-u") 'sp-up-sexp)

;;===================== Helm =======================
(global-set-key (kbd "M-i") 'helm-imenu)
(global-set-key (kbd "C-x c y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x c b") 'helm-mini)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
;;(global-set-key (kbd "C-x C-f") #'helm-find-files)

;;===================== ido/ibuffer.imenu ====================
(global-set-key (kbd "C-.") #'imenu-anywhere)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x b") #'ido-switch-buffer)

(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)

;;==================== OTHERS ==============================
(defun jump-to-mark ()
  "Jumps to the local mark, respecting the `mark-ring' order.
  This is the same as using \\[set-mark-command] with the prefix argument."
  (interactive)
  (set-mark-command 1))
(global-set-key (kbd "M-`") 'jump-to-mark)

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
(global-set-key (kbd "M-]") 'multi-occur-in-this-mode)



(global-set-key (kbd "M-.") 'other-window)
(global-set-key (kbd "C-x C-k") 'kill-this-buffer)


;;Editing
(global-set-key (kbd "M-[") 'insert-pair)
(global-set-key (kbd "M-{") 'insert-pair)
(global-set-key (kbd "M-)") 'delete-pair)


(provide 'init-keybindings)
