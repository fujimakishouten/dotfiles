; Load path
(let ((default-directory "~/.emacs.d/vendor/"))
  (setq load-path (cons default-directory load-path))
  (normal-top-level-add-subdirs-to-load-path)
)

; Language
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq file-name-coding-system 'utf-8)
(setq quail-japanese-use-double-n t)

; emacs23
(when (>= emacs-major-version 23)
  (cond (window-system
      (set-default-font "VL Gothic-8")
          (set-fontset-font (frame-parameter nil 'font)
                'japanese-jisx0208
                      '("VL Gothic-8" . "unicode-bmp"))
)))

; emacs24
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  ;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (package-initialize)
)


; キーバインドの変更
; M-g => M-x goto-line
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-r") 'replace-string)
(global-set-key (kbd "C-M-r") 'replace-regexp)
(global-set-key (kbd "C-/") 'undo)

; ハイライト設定
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)
(setq fast-lock nil)
(setq lazy-lock nil)
(setq jit-lock t)
; (setq hilit-background-mode 'light) ; 明るい背景色用
; (setq hilit-background-mode 'dark) ; 暗い背景色用

; 検索にマッチした文字列をハイライト
(setq search-highlight t)

; 選択範囲を見えるようにする
(setq transient-mark-mode t)

; ウィンドウサイズ・カラー
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

; タイトルバーにファイル名を表示する
(setq frame-title-format (format "emacs@%s : %%f" (system-name)))

; ツールバーを表示しない
;(if window-system
;    (tool-bar-mode 0)
;)

; カーソルの位置が何文字目かを表示する
(column-number-mode t)

; カーソルの位置が何文字目かを表示する
(line-number-mode t)

; タブの設定
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default indent-tab-width 4)
(setq-default c-basic-offset 4)
(setq tab-stop-list
  '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108  112 116 120 124 128))

; 前の行と同じサイズでインデントを行う
(setq indent-line-function 'indent-relative-maybe)

; 括弧の対応を表示
(setq show-paren-mode t)

; タブやスペースを表示
(when (and (>= emacs-major-version 23)
     (require 'whitespace nil t))
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

; 長い行を折り返さない
(setq-default truncate-lines t)
(setq-default truncate-partial-width-windows t)
(set-default 'auto-show-mode t)

; スクロールバーを右側に表示
(if window-system
    (set-scroll-bar-mode 'right)
)

; ウィンドウの左側にラインナンバーを表示
(require 'linum)
(global-linum-mode)
(setq linum-format "%d  ")

; スタートアップメッセージを表示しない
(setq inhibit-startup-message t)

; バックアップを作らない
(setq make-backup-files nil)

; 自動保存しない
(setq auto-save-default nil)

; ファイルの最後に改行を入れる
(setq require-final-newline t)

; 「nn」で「ん」を入力
(setq enable-double-n-syntax t)


; Editorconfig
(load "editorconfig")

; GNU Global
(require 'gtags)
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

; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

; Auto complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

; reStructuredText
(add-to-list 'auto-mode-alist '("\\.re?st$" . rst-mode))

; Markdown
(autoload 'markdown-mode "markdown-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

; Web
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

; Emmet (Zencoding)
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

; Python
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

; Go
(require 'exec-path-from-shell)
(let
    ((envs '("PATH" "GOPATH")))
    (exec-path-from-shell-copy-envs envs))
(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go$" . go-mode))
(add-hook 'before-save-hook 'gofmt-before-save)

; PHP
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

; TypeScript
(autoload 'typescript-mode "TypeScript" nil t)
(add-to-list 'auto-mode-alist '("\\.ts$" . typescript-mode))

; JavaScript
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
(eval-after-load 'flycheck
    '(progn
        (flycheck-add-next-checker 'javascript-jshint 'javascript-gjslint)
    )
)


; JSON
(autoload 'json-mode "json-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))

; YAML
(autoload 'yaml-mode "yaml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))

