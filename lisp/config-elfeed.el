(setq elfeed-feeds
      '(("https://irreal.org/blog/?feed=rss2" emacs)
        ("https://www.ying-ish.com/index.xml")
	("https://mini.ying-ish.com/index.xml")
	("https://patthomson.net/feed/" academic)
	("https://www.rousette.org.uk/index.xml" fun-people)
	("https://blindwith.science/index.xml" fun-people)
	("http://endlessparentheses.com/atom.xml" emacs)
	("http://kitchingroup.cheme.cmu.edu/blog/feed/index.xml" academic emacs)
	("https://necromuralist.github.io/rss.xml" emacs)
	("http://blog.udn.com/rss.jsp?uid=MengyuanWang")
	))

(setq-default elfeed-search-filter "@2-week-ago +unread ")

(provide 'config-elfeed)
