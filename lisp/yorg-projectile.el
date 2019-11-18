(require 'projectile)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(projectile-mode +1)

(setq projectile-project-search-path
      '("~/Documents/Publications/"
	"~/org-notes/"
	"~/hugo/swnsa/"
	"~/hugo/mini/"))

;;================= Scimax setting ======================
(projectile-mode +1)




(provide 'yorg-projectile)
