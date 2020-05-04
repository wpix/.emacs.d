(use-package org-drill
  :ensure t
  :init
  (setq org-drill-maximum-items-per-session 40
		org-drill-maximum-duration 30
		org-drill-save-buffers-after-drill-sessions-p t
		org-drill-add-random-noise-to-intervals-p t))


;# Local Variables:
;# org-drill-maximum-items-per-session:    50
;# org-drill-spaced-repetition-algorithm:  simple8
;# End:

(provide 'org-drill)
