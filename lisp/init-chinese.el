;;----------------------------------------------------
;;              Chinese words count 
;;----------------------------------------------------
(require 'use-package)
(use-package pyim
    :demand t
    :config
    (setq default-input-method "pyim")
    (setq pyim-page-length 9)
    (setq pyim-page-style 'one-line)
    (setq pyim-dcache-auto-update nil)
    :bind
    (:map pyim-mode-map
          ("." . pyim-page-next-page)
          ("," . pyim-page-previous-page)))

;(setq default-input-method "pyim")
;; (global-set-key (kbd "C-\\") 'toggle-input-method)
;;("-" . pyim-self-insert-command)
;;("=" . pyim-self-insert-command))

(add-to-list 'load-path "~/.emacs.d/pyim/liberime/build/")
;;(module-load "/Users/Ying/.emacs.d/pyim/liberime.so")
;; (liberime-start "/Library/Input Methods/Squirrel.app/Contents/SharedSupport" (file-truename "~/.emacs.d/pyim/rime/"))

(setq load-path (cons (file-truename "~/.emacs.d/pyim/") load-path))
(use-package liberime
    :load-path "~/.emacs.d/pyim/liberime/build/"
    :config
    (liberime-start (expand-file-name "/Library/Input Methods/Squirrel.app/Contents/SharedSupport/")
                    (file-truename "~/.emacs.d/pyim/rime"))
    (liberime-select-schema "double_pinyin_flypy")
    (setq pyim-default-scheme 'rime))
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
(liberime-get-schema-list)
;;(liberime-deploy) 

;;(fboundp 'module-load)
;;=====================================================
;;             dictionary setting
;;=====================================================
;; (defvar my-pyim-directory
;;   "~/.eim"
;;   "There directory of peronsal dictionaries for chinese-pyim.")

;; (add-to-list 'auto-mode-alist '("\\.pyim\\'" . text-mode))

;; (defun my-pyim-personal-dict (&optional dict-name)
;;   (file-truename (concat (file-name-as-directory my-pyim-directory)
;;                          (or dict-name "personal.pyim"))))
;; (defun my-pyim-export-dictionary ()
;;   "Export words you use in chinese-pyim into personal dictionary."
;;   (interactive)
;;   (with-temp-buffer
;;     (maphash
;;      #'(lambda (key value)
;;          ;; only export two character word
;;          (if (string-match "-" key)
;;              (insert (concat key
;;                              " "
;;                              (mapconcat #'identity value ""))
;;                      "\n")))
;;      pyim-dcache-icode2word)
;;     (unless (and my-pyim-directory
;;                  (file-directory-p my-pyim-directory))
;;       (setq my-pyim-directory
;;             (read-directory-name "Personal Chinese dictionary directory:")))
;;     (if my-pyim-directory
;;         (write-file (my-pyim-personal-dict)))))
;;=====================================================
;;             dictionary setting
;;=====================================================
;; (require 'cnfonts)
;; (cnfonts-enable)
;; (cnfonts-set-spacemacs-fallback-fonts)
;; (set-face-attribute
;;  'default nil
;;  :font (font-spec :name "-*-Monaco-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1"
;;                   :weight 'normal
;;                   :slant 'normal
;;                   :size 12.5))
;; (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;   (set-fontset-font
;;    (frame-parameter nil 'font)
;;    charset
;;    (font-spec :name "-*-STFangsong-normal-normal-normal-*-*-*-*-*-p-0-iso10646-1"
;;               :weight 'normal
;;               :slant 'normal
;;               :size 15.0)))

(provide 'init-chinese)
