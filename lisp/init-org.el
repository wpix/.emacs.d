;; org
(setq load-path (cons "~/org-mode/lisp" load-path))
(setq load-path (cons "~/org-mode/contrib/lisp" load-path))
(require 'org-install)
(require 'org-brain)
(require 'ox-extra)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(add-to-list 'load-path "~/.emacs.d/site-lisp")
(require 'org-notmuch)
(add-to-list 'load-path "~/.emacs.d/site-lisp/org-tracktable")
(load "org-tracktable.el")

(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org-notes/inbox.org" "tasks")
         "* TODO %?\n  %i\n  %a")
	("n" "Notmuch" entry (file+headline "~/org-notes/inbox.org" "emails") "%?\n  %i\n  %a")
	("i" "ideas" entry (file+headline "~/org-notes/hobo-research.org" "ideas") "%?\n  %i\n  %a")))

	
(global-set-key (kbd "<f7>") 'org-mark-ring-push)
(global-set-key (kbd "C-<f7>") 'org-mark-ring-goto)


;; TODO options setting
(setq org-todo-keywords
      (quote ((sequence "TODO(t)"  "DOING(g)" "SOMEDAY(y)" "|" "DONE(d)")
	      (sequence "WAIT(w)"  "|"  "PAUSED(p)")
	      (sequence "1st(a)"  "2nd(b)"  "3rd(c)"  "STAGED(s!)"  "|"  "REVIEW(v!)")
	      )))


;; allow for export=>beamer by placing

;; #+LaTeX_CLASS: beamer in org files
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))
(add-to-list 'org-export-latex-classes
  ;; beamer class, for presentations
  '("beamer"
     "\\documentclass[10pt]{beamer}\n
      \\mode<{{{beamermode}}}>\n
      \\usetheme{{{{beamertheme}}}}\n
      \\usecolortheme{{{{beamercolortheme}}}}\n
      \\beamertemplateballitem\n
      \\setbeameroption{show notes}
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage{hyperref}\n
      \\usepackage{color}
      \\usepackage{listings}
      \\lstset{numbers=none,language=[ISO]C++,tabsize=4,
  frame=single,
  basicstyle=\\small,
  showspaces=false,showstringspaces=false,
  showtabs=false,
  keywordstyle=\\color{blue}\\bfseries,
  commentstyle=\\color{red},
  }\n
      \\usepackage{verbatim}\n
      \\institute{{{{beamerinstitute}}}}\n          
       \\subject{{{{beamersubject}}}}\n"

     ("\\section{%s}" . "\\section*{%s}")
     
     ("\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}"
       "\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}")))

  ;; letter class, for formal letters

  (add-to-list 'org-export-latex-classes

  '("letter"
     "\\documentclass[10pt]{letter}\n
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage{color}"
     
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
     ("\\paragraph{%s}" . "\\paragraph*{%s}")
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))




(with-eval-after-load 'org       
  (setq org-startup-indented t) ; Enable `org-indent-mode' by default
  (add-hook 'org-mode-hook #'visual-line-mode))

;;org-brain
(setq org-brain-path "~/Documents/Brains/whiskers/")
(setq org-id-track-globally t)
(setq org-id-locations-file "~/.emacs.d/.org-id-locations")
(push '("b" "Brain" plain (function org-brain-goto-end)
          "* %i%?" :empty-lines 1)
        org-capture-templates)
(setq org-brain-visualize-default-choices 'all)
(setq org-brain-title-max-length 30)
(setq org-brain-show-resources nil)

;;org-journals
(customize-set-variable 'org-journal-dir "~/org-notes/journal/")
(customize-set-variable 'org-journal-date-format "%A, %d %B %Y")
(require 'org-journal)

(defun org-journal-find-location ()
  ;; Open today's journal, but specify a non-nil prefix argument in order to
  ;; inhibit inserting the heading; org-capture will insert the heading.
  (org-journal-new-entry t)
  ;; Position point on the journal's top-level heading so that org-capture
  ;; will add the new entry as a child entry.
  (goto-char (point-min)))

(setq org-capture-templates
      '(("j" "Journal entry" entry (function org-journal-find-location)
	 "* %(format-time-string org-journal-time-format)%^{Title}\n%i%?")))

(defun org-journal-save-entry-and-exit()
  "Simple convenience function.
  Saves the buffer of the current day's entry and kills the window
  Similar to org-capture like behavior"
  (interactive)
  (save-buffer)
  (kill-buffer-and-window))
(define-key org-journal-mode-map (kbd "C-x C-s") 'org-journal-save-entry-and-exit)

(provide 'init-org)
