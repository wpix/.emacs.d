(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-create-new-buffer 'always)
(setq ido-file-extensions-order '(".org" ".el" ".txt" ".py" ".emacs"))
(setq ido-ignore-extensions t)
;;Ido recent file
; 50 files ought to be enough.
(setq recentf-max-saved-items 50)

(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(provide 'init-ido)
