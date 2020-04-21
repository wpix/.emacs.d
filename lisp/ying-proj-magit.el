(require 'projectile)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(projectile-mode +1)

(setq projectile-project-search-path
      '("~/Documents/Publications/"
	"~/hugo/swnsa/"
	"~/hugo/mini/"))

(setq magit-refresh-status-buffer nil)
(setq vc-handled-backends nil)
(remove-hook 'server-switch-hook 'magit-commit-diff)
(remove-hook 'magit-refs-sections-hook 'magit-insert-tags)

(global-set-key (kbd "C-x g") 'magit-status)

(provide 'ying-proj-magit)
