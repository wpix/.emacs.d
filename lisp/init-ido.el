(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-create-new-buffer 'always)
(setq ido-file-extensions-order '(".org" ".txt" ".py" ".emacs" ".el"))
(setq ido-ignore-extensions t)
;;Ido recent file
; 50 files ought to be enough.
(setq recentf-max-saved-items 50)


(provide 'init-ido)
