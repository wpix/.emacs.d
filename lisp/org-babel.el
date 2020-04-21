;;======================== Org-babel setting ============================
(require 'ob-ipython)
(require 'ob-R)
(require 'ob-emacs-lisp)
(require 'ob-latex)
(require 'ob-python)
(require 'ob-shell)
(require 'ob-org)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (ipython . t)
   (shell . t)
   (latex . t)
   (translate . t)
   (dot . t)
   (lisp . t)
   (matlab . t)))

;;; display/update images in the buffer after evaluation
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

;;The first let Org-mode don't evaluate src blocks when exporting.
;;The second let Org-mode export src blocks with results
(add-to-list 'org-babel-default-header-args '(:eval . "never-export"))
;;(add-to-list 'org-babel-default-header-args '(:exports . "both"))

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;;(setq python-shell-interpreter "/Users/Ying/.pyenv/shims/python")
;;(setq python-shell-interpreter "python3")
;; Enable elpy
;; (elpy-enable)
(setq python-shell-interpreter "ipython")
;; Use IPython for REPL
;; (setq python-shell-interpreter "jupyter"
;;      python-shell-interpreter-args "console --simple-prompt"
;;      python-shell-prompt-detect-failure-warning nil)
;;(add-to-list 'python-shell-completion-native-disabled-interpreters
;;	     "jupyter")



(setq ob-ipython-command "/Users/Ying/.pyenv/shims/jupyter")
(setq python-shell-completion-native-enable nil)

(setq org-confirm-babel-evaluate nil)
(add-to-list 'load-path "~/.emacs.d/elpa/ess-20191014.1343")
(require 'ess-site)

;;ESS will not print the evaluated commands, also speeds up the evaluation
(setq ess-eval-visibly nil)
(setq ess-ask-for-ess-directory nil)

;;=======================R coding=======================
(require 'ess-smart-underscore)
(setq org-babel-R-command "/usr/local/bin/R --no-save")



(provide 'org-babel)
