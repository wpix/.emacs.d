
;;notmuch setup
(add-to-list 'exec-path "/usr/local/bin/")
(setq notmuch-binary "/usr/local/bin/notmuch") 
(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp/notmuch"))
(autoload 'notmuch "notmuch" "notmuch mail" t)
(require 'notmuch)
(add-hook 'message-mode-hook 'turn-off-auto-fill)

(require 'gnus-art)
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
      notmuch-maildir-use-notmuch-insert t
      notmuch-fcc-dirs "sent"
      notmuch-saved-searches '((:name "inbox" :query "tag:inbox" :key "i")
			       (:name "unread" :query "tag:unread" :key "u")
                               (:name "flagged" :query "tag:flagged" :key "f")
			       (:name "replied" :query "tag:replied" :key "r")
			       (:name "archive" :query "tag:archive" :key "r")
                               (:name "sent" :query "tag:sent" :key "t")))

;;(define-key notmuch-show-mode-map "\C-c\C-o" 'browse-url-at-point)

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
      (notmuch-search-tag '("+deleted" "-unread")))))

(define-key notmuch-show-mode-map "d"
  (lambda ()
    "toggle deleted tag for message"
    (interactive)
    (if (member "deleted" (notmuch-show-get-tags))
        (notmuch-show-tag '("-deleted"))
      (notmuch-show-tag '("+deleted" "-unread")))))

(define-key notmuch-search-mode-map "a"
  (lambda ()
    "toggle archive"
    (interactive)
    (if (member "archive" (notmuch-search-get-tags))
        (notmuch-search-tag '("-archive"))
      (notmuch-search-tag '("+archive" "-unread")))))


(define-key notmuch-show-mode-map "a"
  (lambda ()
    "toggle archive"
    (interactive)
    (if (member "archive" (notmuch-show-get-tags))
        (notmuch-show-tag '("-archive"))
      (notmuch-show-tag '("+archive" "-unread")))))

(define-key notmuch-search-mode-map "f"
  (lambda ()
    (interactive)
    (if (member "flagged" (notmuch-search-get-tags))
        (notmuch-search-tag '("-flagged"))
      (notmuch-search-tag '("+flagged" "-unread")))))


(define-key notmuch-show-mode-map "f"
  (lambda ()
    "toggle flagged"
    (interactive)
    (if (member "flagged" (notmuch-show-get-tags))
        (notmuch-show-tag '("-flagged"))
      (notmuch-show-tag '("+flagged" "-unread")))))


(provide 'notmuch-config)
