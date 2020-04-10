(setq easy-hugo-default-ext ".org")

;;main blog: mini
(setq easy-hugo-basedir "~/hugo/swnsa/")
(setq easy-hugo-url "https://ying-ish.com")
(setq easy-hugo-postdir "content/essay/")

(setq easy-hugo-root "~/hugo/")
(setq easy-hugo-sshdomain "mini")

(setq easy-hugo-bloglist
	;; blog
      '(((easy-hugo-basedir . "~/hugo/swnsa/")
	 (easy-hugo-url . "http://ying-ish.com")
	 (easy-hugo-postdir "content/essay/"))
	;; blog2 for photos
	  ((easy-hugo-basedir . "~/hugo/mini/")
	   (easy-hugo-url . "https://mini.ying-ish.com")
	   (easy-hugo-postdir "content/photo/"))))

(setq easy-hugo-server-flags "-D")
(setq easy-hugo-helm-ag t)
;;M-x easy-hugo-magit
;;Netlify just press M and commit to GitHub.



(provide 'config-hugo)
