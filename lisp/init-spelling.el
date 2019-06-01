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

(provide 'init-spelling)
