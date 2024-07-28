(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/Brain_2")
  (org-roam-dailies-directory "~/Brain_2/00-09 System/03 Dailies/")
  (org-roam-completion-everywhere t)
  (org-roam-capture-templates
   '(("d" "default" plain
      "%?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)))
  :bind (("C-c z l" . org-roam-buffer-toggle)
         ("C-c z f" . org-roam-node-find)
         ("C-c z i" . org-roam-node-insert):map org-mode-map
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


(use-package ox-hugo
  :ensure t)

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
