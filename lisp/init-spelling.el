;; -*- coding: utf-8; lexical-binding: t; -*-
(require 'flyspell)
(setenv "DICTIONARY" "en_US")
(setq exec-path (append exec-path '("/usr/local/bin"))) 
(setq-default ispell-program-name (executable-find "hunspell")) 
(setq ispell-program-name "/usr/local/bin/hunspell"
      ispell-dictionary "en_US")
(setq ispell-local-dictionary-alist
       '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8)))

(setq flyspell-issue-welcome-flag nil)

(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'message-mode-hook 'flyspell-mode)
(add-hook 'org-mode-hook  'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;;flyspell setting
(setq flyspell-abbrev-p t)
(setq flyspell-use-global-abbrev-table-p t)
(setq abbrev-file-name             ;; tell emacs where to read abbrev
       "~/.emacs.d/abbrev_defs")
(setq-default abbrev-mode t)
(setq save-abbrevs 'silent) 

;;languagetool
(setq langtool-language-tool-jar (expand-file-name "languagetool-commandline.jar" "~/Tools/LanguageTool") langtool-java-classpath nil)
(require 'langtool)
(setq langtool-default-language "en-US")

(defun langtool-autoshow-detail-popup (overlays)
  (when (require 'popup nil t)
    ;; Do not interrupt current popup
    (unless (or popup-instances
                ;; suppress popup after type `C-g` .
                (memq last-command '(keyboard-quit)))
      (let ((msg (langtool-details-error-message overlays)))
        (popup-tip msg)))))

(setq langtool-autoshow-message-function
      'langtool-autoshow-detail-popup)

(defun mk-flyspell-correct-previous (&optional words)
  "Correct word before point, reach distant words.
WORDS words at maximum are traversed backward until misspelled
word is found.  If it's not found, give up.  If argument WORDS is
not specified, traverse 12 words by default.
Return T if misspelled word is found and NIL otherwise.  Never
move point."
  (interactive "P")
  (let* ((Δ (- (point-max) (point)))
         (counter (string-to-number (or words "12")))
         (result
          (catch 'result
            (while (>= counter 0)
              (when (cl-some #'flyspell-overlay-p
                             (overlays-at (point)))
                (flyspell-correct-word-before-point)
                (throw 'result t))
              (backward-word 1)
              (setq counter (1- counter))
              nil))))
    (goto-char (- (point-max) Δ))
    result))
(global-set-key (kbd "C-'") 'mk-flyspell-correct-previous)

(provide 'init-spelling)
