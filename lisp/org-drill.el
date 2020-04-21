(require 'org-drill)

(setq org-drill-hide-item-headings-p t)
(setq org-drill-maximum-items-per-session 40)
(setq org-drill-maximum-duration 30)   ; 30 minutes
(setq org-drill-save-buffers-after-drill-sessions-p nil)
(setq org-drill-add-random-noise-to-intervals-p t)

;# Local Variables:
;# org-drill-maximum-items-per-session:    50
;# org-drill-spaced-repetition-algorithm:  simple8
;# End:

(provide 'org-drill)
