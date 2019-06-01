;;mastering emacs keybindings
(define-key global-map (kbd "RET") 'newline-and-indent)
(define-key dired-mode-map (kbd "q") 'kill-this-buffer)
(global-set-key (kbd "C-a") 'back-to-indentation)
(global-set-key (kbd "M-.") 'other-window)
(global-set-key (kbd "M-i") 'imenu)
(global-set-key (kbd "C-x C-k") 'kill-this-buffer)
(global-set-key (kbd "M-SPC") 'mark-sexp)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(global-set-key "\C-xm" 'browse-url-at-point)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
;;(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "C-x b") #'ido-switch-buffer)

(global-set-key [remap dabbrev-expand] 'hippie-expand)



(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)

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
(global-set-key (kbd "C-<f2>") 'multi-occur-in-this-mode)


;; Window resize keybindings
(global-set-key (kbd "C-S-M-w") 'windmove-up)
(global-set-key (kbd "C-S-M-s") 'windmove-down)
(global-set-key (kbd "C-S-M-d") 'windmove-right)
(global-set-key (kbd "C-S-M-a") 'windmove-left)

(global-set-key (kbd "C-S-a") 'shrink-window-horizontally)
(global-set-key (kbd "C-S-d") 'enlarge-window-horizontally)
(global-set-key (kbd "C-S-s") 'shrink-window)
(global-set-key (kbd "C-S-w") 'enlarge-window)

(provide 'init-keybindings)
