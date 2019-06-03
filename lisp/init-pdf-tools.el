(require 'pdf-tools)
(require 'pdf-occur)
(require 'pdf-history)
(require 'pdf-links)
(require 'pdf-outline)
(require 'pdf-annot)
(require 'pdf-sync)

;;; Code:
;;; Install epdfinfo via 'brew install pdf-tools' and then install the
;;; pdf-tools elisp via the use-package below. To upgrade the epdfinfo
;;; server, just do 'brew upgrade pdf-tools' prior to upgrading to newest
;;; pdf-tools package using Emacs package system. If things get messed
;;; up, just do 'brew uninstall pdf-tools', wipe out the elpa
;;; pdf-tools package and reinstall both as at the start.
(setq pdf-info-epdfinfo-program "/usr/local/bin/epdfinfo")
(setenv "PKG_CONFIG_PATH" "/usr/local/lib/pkgconfig:/usr/local/Cellar/libffi/3.2.1/lib/pkgconfig")
(setenv "PKG_CONFIG_PATH" "/usr/local/lib/pkgconfig:/usr/local/Cellar/zlib/1.2.11/lib/pkgconfig")
(pdf-tools-install)



(provide 'init-pdf-tools)
