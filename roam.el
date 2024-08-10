(setq org-directory "~/Brain_2/")
(setq org-agenda-files (list "inbox.org"))

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/Brain_2")
  (org-roam-dailies-directory "~/Brain_2/00-09 System/03 Dailies/")
  (org-roam-completion-everywhere t)
  (org-roam-dailies-capture-templates
   '(("d" "default" entry "* %<%I:%M %p>: %?"
      :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))
  :bind (("C-c z l" . org-roam-buffer-toggle)
         ("C-c z f" . org-roam-node-find)
         ("C-c z i" . org-roam-node-insert)
         ("C-c z c" . org-capture)
         :map org-mode-map
         ("C-M-i"    . completion-at-point)
         :map org-roam-dailies-map
         ("Y" . org-roam-dailies-capture-yesterday)
         ("T" . org-roam-dailies-capture-tomorrow))
  :bind-keymap
  ("C-c z d" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies)
  (org-roam-db-autosync-mode))

(define-key global-map (kbd "C-c c") 'org-capture)
(setq org-capture-templates
  `(("i" "Inbox" entry (file "inbox.org")
    ,(concat "* TODO %?\n"
             "%a\n"
             "/Entered on/ %U"))
    ("w" "Workout" entry (file "workout-log.org")
     ,(concat "* %U\n"
              " - %?\n"
              "   - Reps: , Sets: , Weight:\n"
              " - \n"
              "   - Reps: , Sets: , Weight:"))))

(setq org-roam-capture-templates
    '(("z" "Zettel" plain
       "%?"
       :if-new
       (file+head "Z.0000 Zettelkasten/${slug}.org"
        "#+title: ${title}
        #+created: %U
        #+last_modified: %U\n\n")
       :immediate-finish t
       :unnarrowed t)
      ("r" "reference" plain
       "%?"
       :if-new
       (file+head "00-09 System/01 Reference/${title}.org"
                  "#+title: ${title}
                  #+created: %U
                  #+last_modified: %U\n\n")
       :immediate-finish t
       :unnarrowed t)
      ("b" "blog" plain             ;;                (article)
       "%?"
       :if-new
       (file+head "Website/${title}.org"
                 "#+HUGO_BASE_DIR: ~/alpineTortoise
                 #+HUGO_SECTION: ./posts
                 #+HUGO_AUTO_SET_LASTMOD: t
                 #+TITLE: ${title}
                 #+DATE: %U
                 #+HUGO_TAGS: article
                 #+HUGO_DRAFT: true\n")
       :immediate-finish t
       :unnarrowed t)))

(setq org-confirm-babel-evaluate nil
      org-src-fontify-natively t
      org-src-tab-acts-natively t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell      . t)
   (js         . t)
   (emacs-lisp . t)
   (perl       . t)
   (clojure    . t)
   (python     . t)
   (ruby       . t)
   (dot        . t)
   (css        . t)
   (plantuml   . t)))

(use-package ox-hugo
  :ensure t)

(use-package org-modern
  :hook
  (org-mode . global-org-modern-mode)
  :custom
  (org-modern-star 'replace)
  (org-modern-replace-stars "§¤•·–")
  (org-modern-keyword nil)
  (org-modern-checkbox nil)
  ;(org-modern-table nil)
  )

(use-package org-fragtog
  :after org
  :custom
  (org-startup-with-latex-preview t)
  :hook
  (org-mode . org-fragtog-mode)
  :custom
  (org-format-latex-options
   (plist-put org-format-latex-options :scale 2)
   (plist-put org-format-latex-options :foreground 'auto)
   (plist-put org-format-latex-options :background 'auto)))
