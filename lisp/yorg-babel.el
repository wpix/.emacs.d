;;======================== Org-babel setting ============================
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (ipython . t)
   (python . t)
   (shell . t)
   (latex . t)
   (translate . t)
   (dot . t)
   (matlab . t)))

;;; display/update images in the buffer after evaluation
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

;;The first let Org-mode don't evaluate src blocks when exporting.
;;The second let Org-mode export src blocks with results
(add-to-list 'org-babel-default-header-args '(:eval . "never-export"))
(add-to-list 'org-babel-default-header-args '(:exports . "both"))

(setq python-shell-interpreter "/Users/Ying/.pyenv/shims/python3")
(setq ob-ipython-command "/Users/Ying/.pyenv/shims/jupyter")
(setq python-shell-completion-native-enable nil)

(setq org-confirm-babel-evaluate nil)
(add-to-list 'load-path "~/.emacs.d/elpa/ess-20191014.1343")
(require 'ess-site)

;;=======================R coding=======================
(require 'ess-smart-underscore)
(setq org-babel-R-command "/usr/local/bin/R --no-save")



(provide 'yorg-babel)
