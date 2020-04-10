
;;notmuch setup
(add-to-list 'exec-path "/usr/local/bin/")
(setq notmuch-binary "/usr/local/bin/notmuch") 
(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp/notmuch"))
(autoload 'notmuch "notmuch" "notmuch mail" t)
(require 'notmuch)
(add-hook 'message-mode-hook 'turn-off-auto-fill)

(require 'gnus-art)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp"))
(require 'org-notmuch)

(setq mail-host-address "purdue.edu")
(setq user-full-name "Congying Wang")
(setq user-mail-adress "wang3294@purdue.edu")
(setq mail-user-agent 'message-user-agent)
(setq message-kill-buffer-on-exit t)
(setq mail-specify-envelope-from t)
(setq sendmail-program "/usr/local/bin/msmtp"
	  mail-specify-envelope-from t
	  mail-envelope-from 'header
	  message-sendmail-envelope-from 'header)

(setq notmuch-search-oldest-first nil
      notmuch-show-all-multipart/alternative-parts nil
      message-send-mail-function 'message-send-mail-with-sendmail
      message-sendmail-f-is-evil nil
      message-kill-buffer-on-exit t
      notmuch-show-indent-messages-width 4
      notmuch-saved-searches '((:name "inbox" :query "tag:inbox and not from:wang3294@purdue.edu" :key "i")
			       (:name "unread" :query "tag:unread" :key "u")
                               (:name "sent" :query "from:wang3294@purdue.edu" :key "s")
			       (:name "archive" :query "tag:archive" :key "a")
			       (:name "todo" :query "tag:todo/now or tag:todo/wait or tag:flagged" :key "t")
			       (:name "Carol" :query "to:carolh@purdue.edu or from:carolh@purdue.edu"))) 

;;(define-key notmuch-show-mode-map "\C-c\C-o" 'browse-url-at-point)


(add-hook 'notmuch-hello-refresh-hook
	  ;;cursur on saved search region
	  (lambda ()
	    (if (and (eq (point) (point-min))
		     (search-forward "Saved searches:" nil t))
		(progn
		  (forward-line)
		  (widget-forward 1))
	      (if (eq (widget-type (widget-at)) 'editable-field)
		  (beginning-of-line)))))

;;helm address selection integration 
(setq notmuch-address-selection-function
      (lambda (prompt collection initial-input)
        (completing-read prompt (cons initial-input collection) nil t nil 'notmuch-address-history)))

;;have a saved search for my inbox, but have it change color when there are thread with unread messages in the inbox
(defun color-inbox-if-unread () (interactive)
      (save-excursion
        (goto-char (point-min))
        (let ((cnt (car (process-lines "notmuch" "count" "tag:inbox and tag:unread"))))
          (when (> (string-to-number cnt) 0)
            (save-excursion
              (when (search-forward "inbox" (point-max) t)
                (let* ((overlays (overlays-in (match-beginning 0) (match-end 0)))
                       (overlay (car overlays)))
                  (when overlay
                    (overlay-put overlay 'face '((:inherit bold) (:foreground "green")))))))))))

(add-hook 'notmuch-hello-refresh-hook 'color-inbox-if-unread)


;; a list of keybindings
(eval-after-load 'notmuch-show
  ;'(define-key notmuch-show-mode-map "`" 'notmuch-show-apply-tag-macro)
  '(define-key notmuch-search-mode-map "`" 'notmuch-search-apply-tag-macro))

(defun notmuch-show-tag-spam ()
      "mark message as spam"
      (interactive)
      (notmuch-show-add-tag (list "+spam" "-inbox")))
(define-key notmuch-show-mode-map "s" 'notmuch-show-tag-spam)


(define-key notmuch-search-mode-map "!"
  (lambda ()
    "toggle unread tag for thread"
    (interactive)
    (if (member "unread" (notmuch-search-get-tags))
        (notmuch-search-tag '("-unread"))
      (notmuch-search-tag '("+unread")))))

(define-key notmuch-search-mode-map "d"
  (lambda ()
    "toggle deleted tag for thread"
    (interactive)
    (if (member "deleted" (notmuch-search-get-tags))
        (notmuch-search-tag '("-deleted"))
      (notmuch-search-tag '("+deleted" "-unread" "-inbox")))))

(define-key notmuch-search-mode-map "s"
  (lambda ()
    "toggle deleted tag for thread"
    (interactive)
    (if (member "spam" (notmuch-search-get-tags))
        (notmuch-search-tag '("-spam"))
      (notmuch-search-tag '("+spam" "-unread" "-inbox")))))

(define-key notmuch-search-mode-map "n"
  (lambda ()
    "toggle deleted tag for thread"
    (interactive)
    (if (member "todo/now" (notmuch-search-get-tags))
        (notmuch-search-tag '("-todo/now"))
      (notmuch-search-tag '("+todo/now" "-unread" "-todo/wait" "-archive")))))

(define-key notmuch-search-mode-map "w"
  (lambda ()
    "toggle deleted tag for thread"
    (interactive)
    (if (member "todo/wait" (notmuch-search-get-tags))
        (notmuch-search-tag '("-todo/wait"))
      (notmuch-search-tag '("+todo/wait" "-unread" "-todo/now" "-archive")))))

(define-key notmuch-search-mode-map "y"
  (lambda ()
    "toggle deleted tag for thread"
    (interactive)
    (if (member "archive/done" (notmuch-search-get-tags))
        (notmuch-search-tag '("-archive/done"))
      (notmuch-search-tag '("+archive/done" "-todo/now" "-todo/wait" "-archive")))))

(define-key notmuch-search-mode-map "o"
  (lambda ()
    "toggle deleted tag for thread"
    (interactive)
    (if (member "archive/obsolete" (notmuch-search-get-tags))
        (notmuch-search-tag '("-archive/obsolete"))
      (notmuch-search-tag '("+archive/obsolete" "-archive")))))

(define-key notmuch-search-mode-map "f"
  (lambda ()
    "toggle deleted tag for thread"
    (interactive)
    (if (member "archive/files" (notmuch-search-get-tags))
        (notmuch-search-tag '("-archive/files"))
      (notmuch-search-tag '("+archive/files" "-archive")))))

(define-key notmuch-search-mode-map "r"
  (lambda ()
    "toggle deleted tag for thread"
    (interactive)
    (if (member "archive/requests" (notmuch-search-get-tags))
        (notmuch-search-tag '("-archive/requests"))
      (notmuch-search-tag '("+archive/requests" "-archive")))))

(define-key notmuch-search-mode-map "p"
  (lambda ()
    "toggle deleted tag for thread"
    (interactive)
    (if (member "archive/people" (notmuch-search-get-tags))
        (notmuch-search-tag '("-archive/people"))
      (notmuch-search-tag '("+archive/people" "-archive")))))
;; (setq notmuch-show-tag-macro-alist
;;       (list
;;        '("!" "+2do::now" "-unread")
;;        '("w" "+2do::wait" "-unread")
;;        '("m" "+2review::mse" "-unread")
;;        '("e" "+2review::ene" "-unread")
;;        '("." "+2review::others" "-unread")
;;        '("d" "+archive::done" "-2do::wait" "-2do:now")       
;;        '("r" "+archive::reviewed" "-2review::mse" "-2review::ene" "-2review::others")
;;        '("o" "+archive::obsolete" "-unread")
;;        '("f" "+archive::files" "-unread")))

;; (defun notmuch-show-apply-tag-macro (key)
;;   (interactive "k")
;;   (let ((macro (assoc key notmuch-show-tag-macro-alist)))
;;     (apply 'notmuch-show-tag-message (cdr macro))))

(provide 'config-notmuch)
