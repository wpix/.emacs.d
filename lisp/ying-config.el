;;========================================================
;;                     e l f e e d
;;========================================================
(setq elfeed-feeds
      '(("https://irreal.org/blog/?feed=rss2" emacs)
        ("https://www.ying-ish.com/index.xml")
	("https://mini.ying-ish.com/index.xml" photo)
	("https://patthomson.net/feed/" writing academic)
	("https://www.rousette.org.uk/index.xml" people academic)
	("https://blindwith.science/index.xml" people)
	("http://endlessparentheses.com/atom.xml" emacs)
	("http://kitchingroup.cheme.cmu.edu/blog/feed/index.xml" academic emacs)
	("http://cachestocaches.com/feed" academic emacs)
	("https://necromuralist.github.io/rss.xml" emacs)
	("http://ergoemacs.org/emacs/blog.xml" emacs)
	("https://blog.aaronbieber.com/posts/index.xml" emacs)
	("http://blog.udn.com/rss.jsp?uid=MengyuanWang")
	))

(setq-default elfeed-search-filter "@2-week-ago +unread ")

;;========================================================
;;                     n o t m u c h
;;========================================================
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


;;========================================================
;;                     h u g o
;;========================================================
(setq easy-hugo-default-ext ".org")

;;main blog: mini
(setq easy-hugo-basedir "~/hugo/swnsa/")
(setq easy-hugo-url "https://ying-ish.com")
(setq easy-hugo-postdir "content/essay/")

(setq easy-hugo-root "~/hugo/")
(setq easy-hugo-sshdomain "mini")

(setq easy-hugo-bloglist
	;; blog
      '(((easy-hugo-basedir . "~/hugo/swnsa/")
	 (easy-hugo-url . "http://ying-ish.com")
	 (easy-hugo-postdir "content/essay/"))
	;; blog2 for photos
	  ((easy-hugo-basedir . "~/hugo/mini/")
	   (easy-hugo-url . "https://mini.ying-ish.com")
	   (easy-hugo-postdir "content/photo/"))))

(setq easy-hugo-server-flags "-D")
(setq easy-hugo-helm-ag t)
;;M-x easy-hugo-magit
;;Netlify just press M and commit to GitHub.

;;========================================================
;;                w 3 m b r o w s e r
;;========================================================
(add-to-list 'load-path "/Users/Ying/.emacs.d/site-lisp/emacs-w3m/")
(require 'w3m-load)
;(require 'mime-w3m)
(setq w3m-coding-system 'utf-8
      w3m-file-coding-system 'utf-8
      w3m-file-name-coding-system 'utf-8
      w3m-input-coding-system 'utf-8
      w3m-output-coding-system 'utf-8
      w3m-terminal-coding-system 'utf-8)
(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
(global-set-key (kbd "C-M-;") 'browse-url-at-point)

;; q 	Quit w3m
;; S 	Open google search
;; R 	Reload page
;; B 	Go to previous page
;; N 	Go to next page
;; a 	Add page to bookmark
;; v 	Show bookmark
;; [ 	Go to next edit box
;; ] 	Go to prev edit box
;; c 	Show URL
;; E 	Edit URL
;; G 	Open URL with new session 


(provide 'ying-config)
