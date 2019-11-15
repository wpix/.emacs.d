;;----------------------------------------------------------------------------
;; Default Browser 
;;----------------------------------------------------------------------------
(setq w3m-coding-system 'utf-8
  w3m-file-coding-system 'utf-8
  w3m-file-name-coding-system 'utf-8
  w3m-input-coding-system 'utf-8
  w3m-output-coding-system 'utf-8
  w3m-use-cookies t)

(defun browse-url-at-point-default ()
  (interactive)
  (let ((browse-url-browser-function 'browse-url-default-macosx-browser))
    (browse-url-at-point)))
(global-set-key (kbd "<f6> d") 'browse-url-at-point-default)
(global-set-key (kbd "<f6> w") 'w3m-goto-url-new-session)
(global-set-key "\C-xm" 'browse-url-at-point)

(provide 'init-browser)
