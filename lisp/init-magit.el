(setq magit-refresh-status-buffer nil)
(setq vc-handled-backends nil)
(remove-hook 'server-switch-hook 'magit-commit-diff)
(remove-hook 'magit-refs-sections-hook 'magit-insert-tags)

(global-set-key (kbd "C-x g") 'magit-status)

(provide 'init-magit)

