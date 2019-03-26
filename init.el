(require 'package)

(custom-set-variables
 '(garbage-collection-messages t)
 '(gc-cons-percentage (* gc-cons-percentage 5))
 '(gc-cons-threshold (* gc-cons-threshold 5))
 '(max-lisp-eval-depth (* max-lisp-eval-depth 20))
 '(max-specpdl-size (* max-specpdl-size 20)))

(add-function :after after-focus-change-function 'garbage-collect)

(custom-set-variables
 '(debug-on-error t))

;;(byte-recompile-directory "~/.emacs.d/" nil 'force)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")
             '("gnu" . "http://elpa.gnu.org/packages/"))

(package-initialize)

(custom-set-variables
 '(custom-file "~/.emacs.d/custom.el"))
;; '(package-enable-at-startup  nil)
;; '(package--init-file-ensured t))

(condition-case err
    (require 'use-package)
  (error (progn
           (package-refresh-contents)
           (package-install 'use-package)
           (require 'use-package))))

(custom-set-variables
 '(use-package-always-ensure t)
 '(use-package-compute-statistics t))

(custom-set-variables
 '(inhibit-startup-echo-area-message t)
 '(initial-scratch-message nil)
 '(initial-major-mode 'text-mode))

(custom-set-variables
 '(auto-save-default nil)
 '(make-backup-files nil)
 '(kill-whole-line t)
 '(scroll-step 1)
 '(mouse-wheel-scroll-amount '(0.01))
 '(mouse-wheel-follow-mouse 't)
 '(indicate-empty-lines t)
 '(tab-width 4)
 '(indent-tabs-mode nil)
 '(visible-bell nil)
 '(split-height-threshold nil)
 '(split-width-threshold 80)
 '(blink-cursor-mode nil)
 '(menu-bar-mode nil)
 '(tool-bar-mode nil)
 '(scroll-bar-mode nil))

(if (eq system-type 'darwin)
    (custom-set-variables
     '(mac-option-key-is-meta nil)
     '(mac-command-key-is-meta t)
     '(mac-command-modifier 'meta)
     '(mac-option-modifier nil)))

(defalias 'yes-or-no-p 'y-or-n-p)

(use-package async
  :config
  (async-bytecomp-package-mode t)
  :custom
  (async-bytecomp-allowed-packages '(all)))

(use-package doom-themes
  :hook
  (after-init . (lambda () (load-theme 'doom-one t)))
  :config
  (defined-colors)
  :custom-face
  (hl-line                     ((t (:background "#21252b"))))
  (idle-highlight              ((t (:foreground "#ff8900"
                                    :background "#292c33"))))
  (ivy-minibuffer-match-face-1 ((t (:foreground "#92565c"))))
  (ivy-minibuffer-match-face-2 ((t (:foreground "#c678dd"))))
  (ivy-minibuffer-match-face-3 ((t (:foreground "#98be65"))))
  (ivy-minibuffer-match-face-4 ((t (:foreground "#ecbe7b"))))
  (sp-show-pair-match-face     ((t (:foreground "#ff8900"
                                    :background "#292c33"))))
  (whitespace-trailing         ((t (:background "#ff0000"))))
  (whitespace-tab              ((t (:background "#21252b")))))

(use-package doom-modeline
  :hook
  (after-init . doom-modeline-mode))

(use-package fira-code-mode
  :ensure f
  :load-path "vendor"
  :init
  (set-language-environment "UTF-8")
  (set-default-coding-systems 'utf-8)
  (set-face-attribute 'default nil :family "Fira Code" :height 150)
  :hook
  (prog-mode . fira-code-mode))

(use-package visual-regexp-steroids)

(use-package visual-regexp
  :bind
  (([remap isearch-forward]  . vr/isearch-forward)
   ([remap isearch-backward] . vr/isearch-backward))
  :custom
  (vr/match-separator-use-custom-face t))

(use-package undo-tree
  :commands
  (undo-tree-visualize)
  :custom
  (undo-tree-visualizer-diff t)
  (undo-tree-visualizer-timestamps t)
  :bind
  (("C-c u" . undo-tree-visualize)))

(use-package drag-stuff
  :config
  (drag-stuff-global-mode t)
  :bind
  ("M-p"      . drag-stuff-up)
  ("M-<up>"   . drag-stuff-up)
  ("M-n"      . drag-stuff-down)
  ("M-<down>" . drag-stuff-down))

(use-package windmove
  :bind
  ("C-c <left>"  . windmove-left)
  ("C-c <right>" . windmove-right)
  ("C-c <up>"    . windmove-up)
  ("C-c <down>"  . windmove-down))

(use-package buffer-move
  :bind
  ("C-c m <left>" . buf-move-left)
  ("C-c m <right>" . buf-move-right)
  ("C-c m <up>" . buf-move-up)
  ("C-c m <down>" . buf-move-down))

(use-package pass
  :commands
  (pass))

(use-package auth-source-pass
  :commands
  (auth-source-pass-enable auth-source-pass-get)
  :config
  (auth-source-pass-enable))

(use-package paradox
  :commands
  (paradox-enable)
  :requires async
  :custom
  (paradox-execute-asynchronously t)
  (paradox-column-width-package 36)
  (paradox-column-width-version 13)
  (paradox-display-download-count t)
  (paradox-use-homepage-buttons nil)
  (paradox-spinner-type 'progress-bar-filled)
  :init
  (defalias 'upgrade-packages 'paradox-upgrade-packages)
  (defadvice list-packages (before use-paradox-by-default activate)
    (paradox-enable)))

(use-package highlight-indent-guides
  :custom
  (highlight-indent-guides-responsive 'top)
  (highlight-indent-guides-method 'character))

(use-package hl-line
  :config
  (global-hl-line-mode))

(use-package idle-highlight-mode
  :hook
  (prog-mode . idle-highlight-mode)
  :custom
  (idle-highlight-idle-time 0.35))

(use-package whitespace
  :hook
  (prog-mode . whitespace-mode)
  :custom
  (whitespace-style '(face tabs trailing space-before-tab)))

(use-package ws-butler
  :hook
  (prog-mode . ws-butler-mode)
  :custom
  (ws-butler-keep-whitespace-before-point nil))

(use-package subword
  :hook
  (prog-mode . subword-mode))

(use-package edit-server
  :if window-system
  :hook
  (after-init . server-start)
  (after-init . edit-server-start))

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :config
  (exec-path-from-shell-initialize))

(use-package editorconfig
  :config
  (editorconfig-mode)
  :custom
  (editorconfig-trim-whitespaces-mode 'ws-butler-mode))

(use-package projectile
  :bind
  (:map projectile-mode-map
        ("C-c p" . projectile-command-map)))
  ;; :custom
  ;; (projectile-go-project-test-function '(or (projectile-verify-file-wildcard "*.go")
  ;;                                           (projectile-verify-file-wildcard "src/*/*.go"))))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  :custom
  (dashboard-items '((recents   . 10)
                     (projects  . 10)
                     (bookmarks . 10))))


;; TODO: maybe add :company-backends to use-package
;; (add-to-list 'use-package-keywords :company-backends t)
;;
;; (defalias 'use-package-normalize/:company-backends 'use-package-normalize-symlist)
;;
;; (defun use-package-handler/:company-backends (name keyword args rest state)
;;   (use-package-concat
;;    (use-package-process-keywords name rest state)
;;    (add-hook 'company-mode #'(lambda () (add-to-list (make-local-variable 'company-backends) args)))))
;;
;; (defmacro gen-backend-hook (backends)
;;   (lambda ()
;;     `(add-to-list (make-local-variable 'company-backends) ,backends)))

(use-package company-prescient
  :hook
  (company-mode . company-prescient-mode))

(use-package company
  :hook
  (prog-mode . company-mode)
  :custom
  (company-idle-delay 0.3)
  :bind
  (:map company-mode-map
        ("<tab>" . company-indent-or-complete-common)))

(use-package smartparens
  :config
  (smartparens-global-mode)
  (show-smartparens-global-mode)
  :custom
  (sp-show-pair-from-inside t)
  :bind
  (:map smartparens-mode-map
        ("C-)" . sp-forward-slurp-sexp)
        ("C-(" . sp-forward-barf-sexp)))

(use-package paredit
  :hook
  (parinfer-mode . paredit-mode))

(use-package parinfer
  :hook
  (lisp-mode . parinfer-mode)
  (emacs-lisp-mode . parinfer-mode)
  :custom
  (parinfer-extensions '(defaults
                         pretty-parens
                         paredit
                         smart-tab
                         smart-yank)))

(use-package lisp-mode
  :ensure f
  :hook
  (emacs-lisp-mode . (lambda ()
                       (add-to-list (make-local-variable 'company-backends)
                                    '(company-emacs-lisp)))))

(use-package flx)

(use-package recentf
  :custom
  (recentf-case-fold-search t)
  (recentf-max-saved-items 2000)
  (recentf-save-file "~/.emacs.d/var/recentf.el"))

(use-package prescient
  :custom
  (prescient-filter-method '(literal regexp initialism fuzzy))
  (prescient-save-file "~/.emacs.d/var/prescient-save.el")
  :config
  (prescient-persist-mode))

(use-package ivy-prescient
  :hook
  (ivy-mode . ivy-prescient-mode)
  :custom
  (ivy-prescient-retain-classic-highlighting t))

(use-package all-the-icons)

(use-package all-the-icons-dired
  :hook
  (dired-mode . all-the-icons-dired-mode))

(defun ivy-rich-switch-buffer-icon (candidate)
  (with-current-buffer
      (get-buffer candidate)
    (let ((icon (all-the-icons-icon-for-mode major-mode)))
      (if (symbolp icon)
          (all-the-icons-icon-for-mode 'fundamental-mode)
        icon))))

(use-package ivy-rich
  :hook
  (counsel-mode . ivy-rich-mode)
  :custom
  (ivy-rich-display-transformers-list
   '(ivy-switch-buffer
     (:columns
      ((ivy-rich-switch-buffer-icon       (:width 2))
       (ivy-rich-candidate                (:width 40))
       (ivy-rich-switch-buffer-major-mode (:width 20 :face warning))
       (ivy-rich-switch-buffer-project    (:width 15 :face success))
       (ivy-rich-switch-buffer-path       (:width (lambda (x) (ivy-rich-switch-buffer-shorten-path x (ivy-rich-minibuffer-width 0.3))))))
      :predicate
      (lambda (cand) (get-buffer cand)))

     counsel-M-x
     (:columns
      ((counsel-M-x-transformer             (:width 50))
       (ivy-rich-counsel-function-docstring (:face font-lock-doc-face))))

     counsel-describe-function
     (:columns
      ((counsel-describe-function-transformer (:width 40))
       (ivy-rich-counsel-function-docstring   (:face font-lock-doc-face))))

     counsel-describe-variable
     (:columns
      ((counsel-describe-variable-transformer (:width 50))
       (ivy-rich-counsel-variable-docstring   (:face font-lock-doc-face))))

     counsel-recentf
     (:columns
      ((ivy-rich-candidate               (:width 0.8))
       (ivy-rich-file-last-modified-time (:face font-lock-comment-face))))

     counsel-projectile-switch-project
     (:columns
      ((ivy-rich-candidate                                      (:width 60))
       (ivy-rich-counsel-projectile-switch-project-project-name (:width 40 :face success)))))))

(use-package ivy
  :hook
  (after-init . ivy-mode)
  :custom
  (ivy-display-style 'fancy)
  (ivy-use-virtual-buffers t)
  (ivy-count-format "(%d/%d) ")
  (ivy-initial-inputs-alist nil)
  (ivy-format-function 'ivy-format-function-line))

(use-package counsel-world-clock
  :commands
  (counsel-world-clock)
  :custom
  (counsel-world-clock-time-format "%Y-%m-%d %H:%M (%/h)"))

(use-package counsel
  :hook
  (ivy-mode . counsel-mode)
  :bind
  ([remap describe-face] . counsel-faces))

(use-package counsel-projectile
  :config
  (counsel-projectile-mode))

(use-package flycheck
  :hook
  (prog-mode . flycheck-mode)
  :custom
  (flycheck-idle-change-delay 1.5)
  (flycheck-check-syntax-automatically '(idle-change mode-enabled))
  (flycheck-disabled-checkers '(emacs-lisp-checkdoc
                                rust-cargo
                                go-build
                                go-errcheck
                                go-gofmt
                                go-golint
                                go-megacheck
                                go-unconvert
                                go-vet
                                gometalinter)))

(use-package flycheck-posframe
  :hook
  (flycheck-mode . flycheck-posframe-mode))

(use-package lsp-mode
  :custom
  (lsp-prefer-flymake nil)
  :bind
  (:map lsp-mode-map
        ("C-c C-r" . lsp-rename)))

(use-package lsp-ui
  :commands
  (lsp-ui-mode)
  :custom
  (lsp-ui-doc-use-webkit nil)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-max-width 100)
  (lsp-ui-doc-max-height 100)
  (lsp-ui-sideline-enable nil)
  (lsp-ui-flycheck-enable t)
  :bind
  (:map lsp-ui-mode-map
        ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
        ([remap xref-find-references] . lsp-ui-peek-find-references)))

(use-package company-box
  :hook
  (company-mode . company-box-mode)
  :custom
  (company-box-icons-alist 'company-box-icons-all-the-icons))

(use-package yasnippet-snippets
  :after yasnippet
  :config
  (yas-reload-all))

(use-package yasnippet
  :hook
  (prog-mode . yas-minor-mode))

(use-package company-lsp
  :commands
  (company-lsp))

(use-package deadgrep
  :bind
  ("C-x C-g" . deadgrep))

(use-package flycheck-golangci-lint
  :hook
  (go-mode . flycheck-golangci-lint-setup))

(use-package go-projectile
  :custom
  (go-projectile-switch-gopath 'never)
  :config
  (mapc (lambda (tool)
          (add-to-list 'go-projectile-tools tool))
        '((golangci-lint   . "github.com/golangci/golangci-lint/cmd/golangci-lint")
          (bingo           . "github.com/saibing/bingo")
          (goreturns       . "github.com/sqs/goreturns")
          (dlv             . "github.com/go-delve/delve/cmd/dlv")))
  (go-projectile-tools-add-path))

(use-package gotest
  :requires
  (go-mode)
  :bind
  (:map go-mode-map
        ("C-c C-t r" . go-run)
        ("C-c C-t t" . go-test-current-test)
        ("C-c C-t f" . go-test-current-file)
        ("C-c C-t p" . go-test-current-project)
        ("C-c C-t c" . go-test-current-coverage)
        ("C-c C-b b" . go-test-current-benchmark)
        ("C-c C-b f" . go-test-current-file-benchmarks)
        ("C-c C-b p" . go-test-current-project-benchmarks))
  :custom
  (go-test-verbose t))

(defconst custom-go-style
  '((tab-width . 2)))

(use-package go-mode
  :config
  (c-add-style "custom-go-style" custom-go-style)
  :hook
  (go-mode . flycheck-mode)
  (go-mode . lsp)
  (before-save . gofmt-before-save)
  :custom
  (gofmt-command "goreturns"))
                                        ;
(use-package magit
  :custom
  (vc-handled-backends nil)
  :bind
  ("C-x g" . magit-status))

(use-package polymode)

(use-package poly-markdown)

(use-package graphql
  :commands
  (graphql-query graphql-mutation))

(use-package know-your-http-well
  :commands
  (company-restclient))

(use-package company-restclient
  :hook
  (restclient-mode . (lambda ()
                       (add-to-list (make-local-variable 'company-backends)
                                    '(company-restclient)))))

(define-hostmode poly-restclient-hostmode
  :mode 'restclient-mode)

(define-innermode poly-restclient-elisp-root-innermode
  :mode 'emacs-lisp-mode
  :head-mode 'host
  :tail-mode 'host)

(define-innermode poly-restclient-elisp-single-innermode poly-restclient-elisp-root-innermode
  :head-matcher "^:[^ ]+ :="
  :tail-matcher "\n")

(define-innermode poly-restclient-elisp-multi-innermode poly-restclient-elisp-root-innermode
  :head-matcher "^:[^ ]+ := <<"
  :tail-matcher "^#$")

(define-polymode poly-restclient-mode
  :hostmode 'poly-restclient-hostmode
  :innermodes '(poly-restclient-elisp-single-innermode
                poly-restclient-elisp-multi-innermode))

(use-package restclient
  :commands
  (restclient-mode)
  :hook
  (restclient-mode . company-mode)
  (restclient-mode . poly-restclient-mode)
  :custom
  (restclient-same-buffer-response t))

(use-package cargo
  :hook
  (rust-mode . cargo-minor-mode))

(use-package rust-mode
  :hook
  (rust-mode . lsp)
  :custom
  (rust-format-on-save t))

(use-package yaml-mode)

(use-package docker
  :bind
  ("C-c d" . docker))

(use-package docker-tramp)

(use-package counsel-tramp)

(use-package dockerfile-mode
  :custom
  (dockerfile-image-name-history '()))

(use-package docker-compose-mode)

;; Dependencies:
;; npm i -g typescript-language-server
;; npm i -g typescript
(use-package typescript-mode
  :hook
  (typescript-mode . lsp))

(use-package pyvenv)

;; pytools/build-lsp.sh
(use-package lsp-python-ms
  :ensure nil
  :hook (python-mode . lsp)
  :custom
  (lsp-python-ms-executable "~/.emacs.d/pytools/bin/Microsoft.Python.LanguageServer.LanguageServer"))

(use-package meson-mode)

(use-package cmake-mode)

(defun json-reformat/buffer ()
  (interactive)
  (json-reformat-region (buffer-end -1) (buffer-end 1)))

(use-package json-reformat
  :custom
  (json-reformat:indent-width 2)
  (json-reformat:pretty-string t))

(use-package json-mode
  :mode ("\\.json$" . json-mode)
  :bind
  (:map json-mode-map
        ("C-c C-f" . json-reformat/buffer)
        ("C-c C-j" . jq-interactively)))

(use-package jq-mode)

(provide 'init)
