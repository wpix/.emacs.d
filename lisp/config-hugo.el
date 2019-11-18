(setq easy-hugo-default-ext ".org")

;;main blog: mini
(setq easy-hugo-basedir "~/hugo/swnsa/")
(setq easy-hugo-url "https://ying-ish.com")
(setq easy-hugo-sshdomain "mini")
(setq easy-hugo-root "~/hugo/")
(setq easy-hugo-postdir "content/post/")

(setq easy-hugo-bloglist
	;; mini-blog
      '(((easy-hugo-basedir . "~/hugo/swnsa/")
	 (easy-hugo-url . "http://mini.ying-ish.com")
	 (easy-hugo-postdir "content/essay/"))
	;; blog3 for photos
	  ((easy-hugo-basedir "~/hugo/swnsa/")
	   (easy-hugo-url "https://ying-ish.com")
	   (easy-hugo-postdir "content/photo/"))))

(provide 'config-hugo)
