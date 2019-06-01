;;main blog
(setq easy-hugo-basedir "~/hugo/swnsa/")
(setq easy-hugo-url "https://ying-ish.com")
(setq easy-hugo-postdir "content/essay")

(setq easy-hugo-bloglist
	;; mini-blog
      '(((easy-hugo-basedir . "~/hugo/mini/")
	 (easy-hugo-url . "http://mini.ying-ish.com")
	 (easy-hugo-postdir "content/post"))
	;; blog3 for photos
	  ((easy-hugo-basedir "~/hugo/swnsa/")
	   (easy-hugo-url "https://ying-ish.com")
	   (easy-hugo-postdir "content/photo"))))

(provide 'hugo-config)
