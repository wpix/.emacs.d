(setq magit-refresh-status-buffer nil)
(setq vc-handled-backends nil)
(remove-hook 'server-switch-hook 'magit-commit-diff)
(remove-hook 'magit-refs-sections-hook 'magit-insert-tags)


(provide 'init-magit)

