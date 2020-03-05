;;; init.el --- Initialization file for Emacs
;;; Commentary:
;;;     Emacs Startup File --- initialization for Emacs

;; Load path
(when (file-directory-p "~/.emacs.d/vendor")
  (let ((default-directory "~/.emacs.d/vendor/"))
    (setq load-path (cons default-directory load-path))
    (normal-top-level-add-subdirs-to-load-path)))


;; emacs
;; emacs23
(when (>= emacs-major-version 23)
  (cond (window-system
      (set-default-font "VL Gothic-14")
          (set-fontset-font (frame-parameter nil 'font)
                'japanese-jisx0208
                      '("VL Gothic-14" . "unicode-bmp"))
)))

;; emacs24
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  ;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (package-initialize)
  (unless package-archive-contents (package-refresh-contents))

  ;; Auto install packages
  (unless (package-installed-p 'auto-complete) (package-install 'auto-complete))
  (unless (package-installed-p 'editorconfig) (package-install 'editorconfig))
  (unless (package-installed-p 'elp) (package-install 'elp))
  (unless (package-installed-p 'emmet-mode) (package-install 'emmet-mode))
  (unless (package-installed-p 'espresso-theme) (package-install 'espresso-theme))
  (unless (package-installed-p 'exec-path-from-shell) (package-install 'exec-path-from-shell))
  (unless (package-installed-p 'f) (package-install 'f))
  (unless (package-installed-p 'flycheck) (package-install 'flycheck))
  (unless (package-installed-p 'flycheck-kotlin) (package-install 'flycheck-kotlin))
  (unless (package-installed-p 'flycheck-ocaml) (package-install 'flycheck-ocaml))
  (unless (package-installed-p 'fuzzy) (package-install 'fuzzy))
  (unless (package-installed-p 'ggtags) (package-install 'ggtags))
  (unless (package-installed-p 'go-mode) (package-install 'go-mode))
  (unless (package-installed-p 'hemisu-theme) (package-install 'hemisu-theme))
  (unless (package-installed-p 'js2-mode) (package-install 'js2-mode))
  (unless (package-installed-p 'json-mode) (package-install 'json-mode))
  (unless (package-installed-p 'kotlin-mode) (package-install 'kotlin-mode))
  (unless (package-installed-p 'linum) (package-install 'linum))
  (unless (package-installed-p 'markdown-mode+) (package-install 'markdown-mode+))
  (unless (package-installed-p 'multi-web-mode) (package-install 'multi-web-mode))
  (unless (package-installed-p 'php-mode) (package-install 'php-mode))
  (unless (package-installed-p 'py-autopep8) (package-install 'py-autopep8))
  (unless (package-installed-p 'python-mode) (package-install 'python-mode))
  (unless (package-installed-p 'swiper) (package-install 'swiper))
  (unless (package-installed-p 'tuareg) (package-install 'tuareg))
  (unless (package-installed-p 'typescript-mode) (package-install 'typescript-mode))
  (unless (package-installed-p 'web-mode) (package-install 'web-mode))
  (unless (package-installed-p 'yaml-mode) (package-install 'yaml-mode))
)


;; environment
(autoload 'exec-path-from-shell "exec-path-from-shell" nil t)
(exec-path-from-shell-initialize)


;; Language
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq file-name-coding-system 'utf-8)
(setq quail-japanese-use-double-n t)


;; Display
;; Theme
(load-theme 'hemisu-light t)

;; Window size and colors
(if window-system
    (setq default-frame-alist
        (append (list '(width . 120)
                      '(height . 30)
                      ;'(foreground-color . "rgb:00/ab/bc")
                      ;'(background-color . "rgb:00/00/00")
                      ;'(coursor-color . "rgb:11/b8/c8")
                      ;'(mouse-color . "rgb:11/b8/c8")
                      '(alpha . (85))
                )
                default-frame-alist))
    (progn
;        (set-face-foreground 'font-lock-comment-face "LightGoldenrod3")
;        (set-face-foreground 'font-lock-string-face "DodgerBlue")
;        (set-face-foreground 'font-lock-keyword-face "cyan")
;        (set-face-foreground 'font-lock-function-name-face "DodgerBlue")
;        (set-face-foreground 'font-lock-variable-name-face "yellow3")
;        (set-face-foreground 'font-lock-type-face "chartreuse2")
;        (set-face-foreground 'font-lock-builtin-face "purple")
;        (set-face-foreground 'font-lock-constant-face "magenta2")
;        (set-face-foreground 'font-lock-warning-face "red")
;        (set-face-bold-p 'font-lock-warning-face nil)
    )
)

;; Hide startup message
(setq inhibit-startup-message t)

;; Show filename in title bar
(setq frame-title-format (format "emacs@%s : %%f" (system-name)))

;; Hide toolbar
;(if window-system
;    (tool-bar-mode 0)
;)

;; Show scroll bar
(if window-system
    (set-scroll-bar-mode 'right)
)

;; Show line numbers
(autoload 'linum "linum" nil t)
(global-linum-mode)
(setq linum-format "%d  ")

;; Show cursor position
(line-number-mode t)
(column-number-mode t)

;; Highlight
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)
(setq fast-lock nil)
(setq lazy-lock nil)
(setq jit-lock t)
(setq search-highlight t)
(setq hilit-background-mode 'light) ; Light theme
; (setq hilit-background-mode 'dark) ; Dark theme

;; Show matching brackets
(setq show-paren-mode t)

;; Show selection
(setq transient-mark-mode t)

;; Disable word wrapping
(setq-default truncate-lines t)
(setq-default truncate-partial-width-windows t)
(set-default 'auto-show-mode t)

;; Tabs and indents
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default indent-tab-width 4)
(setq-default c-basic-offset 4)
(setq tab-stop-list
  '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108  112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216 220 224 228 232 236 240 244 248 252 256))
(setq indent-line-function 'indent-relative-maybe)

;; Display tabs and spaces
(when (and (>= emacs-major-version 23)
  (require 'whitespace))
  (setq whitespace-style
  '(face
    tabs spaces newline trailing space-before-tab space-after-tab
    space-mark tab-mark newline-mark))
  (let ((dark (eq 'dark (frame-parameter nil 'background-mode))))
    (set-face-attribute 'whitespace-space nil
      :foreground (if dark "pink4" "azure3")
      :background 'unspecified)
    (set-face-attribute 'whitespace-tab nil
      :foreground (if dark "gray20" "gray80")
      :background 'unspecified
      :strike-through t)
    (set-face-attribute 'whitespace-newline nil
      :foreground (if dark "darkcyan" "darkseagreen")))
  (setq whitespace-space-regexp "\\(　+\\)")
  (setq whitespace-display-mappings
  '((space-mark   ?\xA0  [?\xA4]  [?_]) ; hard space - currency
    (space-mark   ?\x8A0 [?\x8A4] [?_]) ; hard space - currency
    (space-mark   ?\x920 [?\x924] [?_]) ; hard space - currency
    (space-mark   ?\xE20 [?\xE24] [?_]) ; hard space - currency
    (space-mark   ?\xF20 [?\xF24] [?_]) ; hard space - currency
    (space-mark   ?　    [?□]    [?＿]) ; full-width space - square
    (newline-mark ?\n    [?\xAB ?\n])   ; eol - right quote mark
    ))
  (setq whitespace-global-modes '(not dired-mode tar-mode))
  (global-whitespace-mode 1))

;; Remove trailing whitespece on save
(add-hook 'before-save-hoook 'delete-trailing-whitespace)

;; Operation
(setq enable-double-n-syntax t)    ; Input "ん" by "nn"

;; Keybind
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)
(global-set-key (kbd "M-g") 'goto-line)           ; M-g => M-x goto-line
(global-set-key (kbd "C-r") 'replace-string)
(global-set-key (kbd "C-M-r") 'replace-regexp)
(global-set-key (kbd "C-/") 'undo)


;; Save and backup
;; Buckup:
(setq make-backup-files nil)

;; Auto save
(setq auto-save-default nil)

;; Ensure new line at EOF
(setq require-final-newline t)


;; Editorconfig
(autoload 'editorconfig "editorconfig" nil t)


;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)


;; Auto complete
(autoload 'auto-complete-config "auto-complete-config" nil t)
(when (file-directory-p "~/.emacs.d/ac-dict")
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
  (ac-config-default))


;; GNU Global
(autoload 'gtags "gtags" nil t)
(global-set-key "\M-t" 'gtags-find-tag)
(global-set-key "\M-r" 'gtags-find-rtag)
(global-set-key "\M-s" 'gtags-find-symbol)
(global-set-key "\M-p" 'gtags-find-pattern)
(global-set-key "\M-f" 'gtags-find-file)
(global-set-key [?\C-,] 'gtags-pop-stack)
(add-hook
    'c-mode-common-hook
    '(lambda()
        (progn
            (gtags-mode 1)
        )
    )
)


;; Markdown
(autoload 'markdown-mode "markdown-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))


;; reStructuredText
(add-to-list 'auto-mode-alist '("\\.re?st$" . rst-mode))


;; Web
(autoload 'web-mode "web-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.x?html?$" . web-mode))
(add-hook 'web-mode-hook
    '(lambda ()
        (progn
            (setq web-mode-markup-indent-offset 4)
            (setq web-mode-css-indent-offset 4)
            (setq web-mode-code-indent-offset 4)
            (setq web-mode-style-padding 4)
            (setq web-mode-script-padding 4)
            (setq web-mode-block-padding 4)
        )
    )
)
(autoload 'emmet-mode "emmet-mode" nil t)
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)
(add-hook 'emmet-mode-hook
    '(lambda ()
        (progn
            (setq emmet-indentation 4)
            (setq emmet-move-cursor-between-quotes t)
        )
    )
)


;; Python
(autoload 'python-mode "python-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(add-hook 'python-mode-hook
    '(lambda ()
        (progn
            (setq indent-tabs-mode nil)
            (setq indent-level 4)
            (setq python-indent 4)
            (setq tab-width 4)
        )
    )
)


;; OCaml
(autoload 'tuareg-mode "tuareg-mode" nil t)
(autoload 'tuareg-run-ocaml "tuareg-run-ocaml" nil t)
(autoload 'ocamldebug "ocamldebug" nil t)
(add-to-list 'auto-mode-alist '("\\.ml[iylp]?$" . tuareg-mode))


;; Go
(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go$" . go-mode))
(add-hook 'before-save-hook 'gofmt-before-save)


;; Kotlin
(autoload 'kotlin-mode "kotlin-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.kt$" . kotlin-mode))


;; PHP
(autoload 'php-mode "php-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-hook 'php-mode-hook
    '(lambda ()
        (progn
            (setq tab-width 4)
            (setq c-basic-offset 4 indent-tabs-mode nil)
            (setq c-hanging-comment-ender-p nil)
            (c-set-offset 'case-label '+)
            (c-set-style "java")
        )
    )
)
(add-hook 'php-mode-user-hook
    '(lambda ()
        (progn
            (setq php-manual-url "http://php.net/manual/ja/")
        )
    )
)


;; TypeScript
(autoload 'typescript-mode "TypeScript" nil t)
(add-to-list 'auto-mode-alist '("\\.ts$" . typescript-mode))


;; JavaScript
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'js2-mode-hook
    '(lambda ()
        (progn
            (setq tab-width 4)
            (setq js2-basic-offset 4)
        )
    )
)


;; JSON
(autoload 'json-mode "json-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))


;; YAML
(autoload 'yaml-mode "yaml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))


;; Packages
;;     Install:
;;         M-x package-refresh-contents
;;         M-x package-install-selected-packages
;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
    (quote
      (auto-complete
       editorconfig
       elp
       emmet-mode
       espresso-theme
       exec-path-from-shell
       f
       flycheck
       flycheck-kotlin
       flycheck-ocaml
       fuzzy
       ggtags
       go-mode
       hemisu-theme
       js2-mode
       json-mode
       kotlin-mode
       markdown-mode+
       multi-web-mode
       php-mode
       py-autopep8
       python-mode
       swiper
       tuareg
       typescript-mode
       web-mode
       yaml-mode
      )
    )
  )
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

