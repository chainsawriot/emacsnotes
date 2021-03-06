(require 'package)
(package-initialize)
(add-to-list 'package-archives
   '("melpa" . "http://melpa.milkbox.net/packages/") t)

;(require 'auto-complete)
;(require 'auto-complete-config)
;(ac-config-default)
;(global-auto-composition-mode 1)

(setq inhibit-startup-message t)

(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(show-paren-mode 1)

(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )

;; switch-off ess for asking stupid question

(setq ess-ask-for-ess-directory nil)

;; enable auto-complete for ess

;(add-to-list 'ac-sources 'ac-source-R)
;(setq ess-use-auto-complete t)

;; change all "yes-or-no-p" to "y-or-n-p"

(fset 'yes-or-no-p 'y-or-n-p)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(markdown-command "pandoc -f markdown -t html"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(global-visual-line-mode t)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(require 'markdown-mode) 
(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.rmd" . markdown-mode) auto-mode-alist))

;(setq ess-default-style 'C++)
