;;; org-tracktable-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "advance-words-count" "advance-words-count.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from advance-words-count.el

(autoload 'define-words-count-function "advance-words-count" "\
Define the function used to format the strings displayed.
NAME    = Function's name.
MESSAGE = A string used to display.
RULES   = A list of functions to form the string.
BIND    = A boolean, if ture, bind the function to
          `words-count-message-function'.
REGEXP  = A list of regexp to call, if not specified, use
          `words-count-regexp-list'.

\(fn NAME MESSAGE RULES &optional BIND REGEXP)" nil t)

(autoload 'advance-words-count "advance-words-count" "\
Chinese user preferred word count.
If BEG = END, count the whole buffer. If called initeractively,
use minibuffer to display the messages. The optional ARG will be
passed to `words-count--format-message' to decide the style of
display.
See also `special-words-count'.

\(fn &optional BEG END ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "advance-words-count" '("words-count")))

;;;***

;;;### (autoloads nil "org-notmuch" "org-notmuch.el" (0 0 0 0))
;;; Generated autoloads from org-notmuch.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-notmuch" '("org-notmuch-")))

;;;***

;;;### (autoloads nil "org-tracktable" "org-tracktable.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from org-tracktable.el

(autoload 'org-tracktable-insert-table "org-tracktable" "\
Insert the a table with the name defined by `org-tracktable-table-name'.

\(fn)" t nil)

(autoload 'org-tracktable-status "org-tracktable" "\
Report the number of words between positions BEG and END.
If a table is inserted with `org-tracktable-table-insert', shows words written today.
If `org-tracktable-daily-goal' is set to more than 0, show % of daily goal.

\(fn BEG END)" t nil)

(autoload 'org-tracktable-status-today "org-tracktable" "\
Reports number of words written today

\(fn)" t nil)

(autoload 'org-tracktable-write "org-tracktable" "\
Write progress to the tracktable.
If the last entry is from today, this entry will be updated.
Otherwise a new entry will be made.  It is only necessary to call this function
when you're done writing for the day.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-tracktable" '("org-tracktable-")))

;;;***

;;;### (autoloads nil "ox-extra" "ox-extra.el" (0 0 0 0))
;;; Generated autoloads from ox-extra.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ox-extra" '("org-" "ox-extras")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; org-tracktable-autoloads.el ends here
