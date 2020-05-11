;;----------------------------------------------------
;;              Chinese words count 
;;----------------------------------------------------
(use-package pyim
  :load-path
  "~/.emacs.d/pyim/liberime/build/"
  "~/.emacs.d/pyim/"
  :demand t
  :config
  (setq default-input-method "pyim")
  (setq pyim-page-length 9)
  (setq pyim-page-style 'one-line)
  (setq pyim-dcache-auto-update nil)
  ;; 暂时先不设置rime 打字反应还是有点慢
  (setq pyim-default-scheme 'xiaohe-shuangpin)
  :bind
  (:map pyim-mode-map
        ("-" . pyim-self-insert-command)
        ("." . pyim-page-next-page)
        ("," . pyim-page-previous-page)))

;(setq default-input-method "pyim")
(global-set-key (kbd "C-M-/") 'toggle-input-method)
;;
;;("=" . pyim-self-insert-command))

;; (use-package liberime
;;     :load-path "~/.emacs.d/pyim/liberime/build/"
;;     :config
;;     (liberime-start (expand-file-name
;;                      "/Library/Input Methods/Squirrel.app/Contents/SharedSupport/")
;;                     (file-truename "~/.emacs.d/pyim/rime"))
;;     (liberime-select-schema "double_pinyin_flypy")
;;     (setq pyim-default-scheme 'rime-flypy))

;;(module-load "/Users/Ying/.emacs.d/pyim/liberime.so")
;; (liberime-start "/Library/Input Methods/Squirrel.app/Contents/SharedSupport" (file-truename "~/.emacs.d/pyim/rime/"))
;;(let ((liberime-auto-build t))
  ;;(require 'liberime nil t))
;;===================================================
;;                   IMPORTANT
;;https://placeless.net/blog/uncommon-chinese-character-in-rime
;;https://emacs-china.org/t/mac-emacs-rime/10063/26  (look for wd1's answer) 
;;===================================================
;; ;;(module-load "~/.emacs.d/pyim/liberime.so")
;; (module-load "/Users/Ying/.emacs.d/pyim/liberime.so")
;; (use-package liberime
;;   (liberime-start "/Library/Input Methods/Squirrel.app/Contents/SharedSupport/" (file-truename "~/.emacs.d/pyim/rime/"))
;;   (liberime-select-schema "double_pinyin_flypy")
;;   (setq pyim-default-scheme 'rime))
;;(add-hook 'after-init-hook #'liberime-sync)
;;================================================== 
;;(liberime-get-schema-list)
;;(liberime-deploy) 
;;(fboundp 'module-load)

(provide 'init-chinese)
