(require 'projectile)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(projectile-mode +1)

(setq projectile-project-search-path
      '("~/Documents/Publications/"
	"~/.emacs.d/"
	"~/hugo/swnsa/"
	"~/hugo/mini/"))

;;================= Scimax setting ======================




(provide 'ying-projectile)