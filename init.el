(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("elpa" . "https://elpa.gnu.org/packages/") t)

(package-initialize)

(package-install 'exec-path-from-shell)
(package-install 'solarized-theme)
(package-install 'yaml-mode)
(package-install 'cmake-mode)
(package-install 'use-package)
(package-install 'vertico)
(package-install 'orderless)
(package-install 'consult)
(package-install 'magit)
(package-install 'company)
(package-install 'lsp-mode)
(package-install 'lsp-ui)
(package-install 'flycheck)
(package-install 'yasnippet)

;; dependencies for copilot.el
(package-install 'dash)
(package-install 's)
(package-install 'editorconfig)

;; disable crate backup file
(setq make-backup-files nil)
(setq auto-save-default nil)
;; disbable bell
(setq ring-bell-function 'ignore)
;; highlight pair
(electric-pair-mode 1)
;; highlight line
(global-hl-line-mode t)

(show-paren-mode t)
(setq show-paren-style 'mixed)
(transient-mark-mode t)

(which-function-mode 1)
(setq-default tab-width 4 indent-tabs-mode nil)

;; change font
(add-to-list 'default-frame-alist '(font . "Source Code Pro-11" ))
;;(load-theme 'dracula t)
;;(load-theme 'solarized-light t)

(exec-path-from-shell-initialize)

(use-package vertico
  :init
  (vertico-mode)

  (setq vertico-count 15)
  (define-key vertico-map (kbd "C-r") 'vertico-previous)
  (define-key vertico-map (kbd "C-s") 'vertico-next)
  (setq vertico-cycle t)
  )

(use-package vertico-directory
  :after vertico
  :ensure nil
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package orderless
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package consult
  :bind (("C-s" . consult-line)
         ("C-r" . consult-line)
         ("C-x b" . consult-buffer))
  :config
  (consult-customize
   consult-line :prompt "Search ->  "))

(use-package savehist
  :init
  (savehist-mode))

;;(global-set-key (kbd "TAB") 'company-indent-or-complete-common)
;;(define-key comapny-active-map (kbd "TAB") 'company-indent-or-complete-common)
(use-package company
  :after lsp-mode
  :ensure t
  :config
  (global-company-mode)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  (setq company-selection-wrap-around t)

  ;; (setq company-selection-default nil)
  ;; (setq company-selection nil)
  :bind (:map company-active-map
              ("C-n" . company-select-next)
              ("C-p" . company-select-previous)
              ("C-s" . company-filter-candidates)
              ;;("TAB" . company-complete-selection)
              ("TAB" . company-indent-or-complete-common))

  :bind (:map company-search-map
              ("C-n" . company-select-next)
              ("C-p" . company-select-previous))
  :bind (:map lsp-mode-map
              ;; ("TAB" . company-indent-or-complete-common)
              ))

(use-package lsp-mode
  :hook (prog-mode . lsp-mode)
  :custom
  (lsp-signature-auto-activate nil)
  (lsp-diagnostics-provider :flycheck)
  )

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
    ;; lsp-ui-doc
    (lsp-ui-doc-enable t)
    (lsp-ui-doc-header t)
    (lsp-ui-doc-include-signature t)
    (lsp-ui-doc-position 'top)
    (lsp-ui-doc-use-childframe t)
    (lsp-ui-doc-use-webkit t)
    (lsp-ui-flycheck-enable t)
    (lsp-ui-sideline-enable t)
    (lsp-ui-sideline-ignore-duplicate t)
    (lsp-ui-sideline-show-symbol t)
    (lsp-ui-sideline-show-hover t)
    (lsp-ui-sideline-show-diagnostics t)
    (lsp-ui-sideline-show-code-actions t)
  )

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp))))  ; or lsp-deferred

;; (use-package copilot
;;   :load-path "copilot.el"
;;   :hook (prog-mode . copilot-mode)
;;   :bind (:map copilot-completion-map
;;               ("<tap>" . copilot-accept-completion)
;;               ("TAB" . copilot-accept-completion))
;;   )

(use-package emacs
  :init
  (defun crm-indicator (args)
    (cons (concat "[CRM] " (car args)) (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  (setq enable-recursive-minibuffers t))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(web-mode yaml-mode vertico use-package solarized-theme orderless exec-path-from-shell consult cmake-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
