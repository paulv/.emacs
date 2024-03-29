(cond ((string= "penguin" paulv-current-host) (set-frame-font "Ubuntu Mono-12"))
      ((string= "hanzo" paulv-current-host) (set-frame-font "Ubuntu Mono-12"))
      (t (set-frame-font "Ubuntu Mono-9")))

(cond
 (window-system
  (setq-default default-frame-alist
                '(
                  (menu-bar-lines . 0)
                  (vertical-scroll-bars . nil)
                  (mouse-yank-at-point . t)
;                 (background-color . "black")
;                 (foreground-color . "white")
;                 (cursor-color . "dodgerblue")
;                 (font . paulv-frame-font)
;                 (font . "6x13")
;                 (width . 80)
;                 (height . 40)
                 (fullscreen . maximized)))
 (require 'avoid)
 (mouse-avoidance-mode 'cat-and-mouse)
 ))

(load-theme 'dracula t)
;; this is for font locking mode. it only(currently) works when you're
;; in X
(require 'font-lock)

;; set the foreground colors for all of these things.
(set-face-foreground font-lock-string-face "grey")
(set-face-foreground font-lock-comment-face "red")
(set-face-foreground font-lock-keyword-face "blue")
(set-face-foreground font-lock-variable-name-face "white")
(set-face-foreground font-lock-keyword-face "dodgerblue")
(set-face-foreground font-lock-type-face "dodgerblue")
(set-face-foreground font-lock-comment-face "red")
(set-face-foreground font-lock-function-name-face "lightgreen")

;; set the modeline foreground black and the background white.
(set-face-foreground 'mode-line "white")
(set-face-background 'mode-line "black")

;; highlight using these colors
(set-face-background 'highlight "dodgerblue")
(set-face-foreground 'highlight "white")

;; display the region in these colors
(set-face-foreground 'region "white")
(set-face-background 'region "blue")

;; (set-frame-font "-misc-fixed-medium-r-semicondensed--13-120-75-75-c-60-iso8859-1")

;; flyspell mode
(set-face-attribute 'flyspell-incorrect nil
                    :weight 'normal)

(set-face-attribute 'flyspell-duplicate nil
                    :underline nil
                    :weight 'normal
                    :background "forest green"
                    :foreground "white")

;; set-face-attribute is documented in
;; elisp > Display > Faces >  Attribute Functions (38.12.3)
;; options are documented in (38.12.2)

;; set the font
;; (set-frame-font "10x20")
;; (set-frame-font "6x13") ; was "fixed"
;; (set-frame-font "monospace-8")
;; (set-frame-font "Inconsolata-8")
;; (set-frame-font "Inconsolata-9")
;; (set-frame-font "Inconsolata-10")
;; (set-frame-font "Inconsolata-11")
;; (set-frame-font "Ubuntu Mono-8")
;; (set-frame-font "Ubuntu Mono-9")
;; (set-frame-font "Ubuntu Mono-10")
;; (set-frame-font "Ubuntu Mono-11")
;; (set-frame-font "Ubuntu Mono-12")
;; (set-frame-font "Ubuntu Mono-13")
;; (set-frame-font "Inconsolata-12")
;; (set-frame-font "-unknown-Inconsolata-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1")
;; (set-frame-font "-misc-fixed-medium-r-semicondensed--13-*-*-*-*-*-iso8859-1")
;;
;; (set-frame-font "-unknown-inconsolata-medium-r-semicondensed-*-14") -*-15-*-*-*-m-0-iso10646-1")

;; Firefox-like zooming of fonts.
;; (setq default-font-zoom-index 2)
;; (setq font-zoom-index default-font-zoom-index)

;; (setq font-zoom-list
;;       (list "-*-fixed-*-*-*-*-6-*-*-*-*-*-*-*"
;;             "-*-fixed-*-*-*-*-10-*-*-*-*-*-*-*"
;;             "-*-fixed-*-*-*-*-13-*-*-*-*-*-*-*"
;;             "-*-fixed-*-*-*-*-17-*-*-*-*-*-*-*"
;;             "-*-fixed-*-*-*-*-18-*-*-*-*-*-*-*"
;;             "-*-fixed-*-*-*-*-24-*-*-*-*-*-*-*"
;;             "-*-fixed-*-*-*-*-36-*-*-*-*-*-*-*"
;;             "-*-fixed-*-*-*-*-48-*-*-*-*-*-*-*"))
;; (set-frame-font "-*-fixed-medium-r-*--13-*-*-*-*-60-ISO8859-1")
;; (set-frame-font "-*-fixed-medium-r-*--20-*-*-*-*-60-ISO8859-1")


;; (defun font-zoom-increase-font-size ()
;;   (interactive)
;;   (progn
;;     (setq font-zoom-index (min (- (length font-zoom-list) 1)
;;                                (+ font-zoom-index 1)))
;;     (set-frame-font (nth font-zoom-index font-zoom-list))))

;; (defun font-zoom-decrease-font-size ()
;;   (interactive)
;;   (progn
;;     (setq font-zoom-index (max 0
;;                                (- font-zoom-index 1)))
;;     (set-frame-font (nth font-zoom-index font-zoom-list))))

;; (defun font-zoom-reset-font-size ()
;;   (interactive)
;;   (progn
;;     (setq font-zoom-index default-font-zoom-index)
;;     (set-frame-font (nth font-zoom-index font-zoom-list))))

;(define-key global-map (read-kbd-macro "C--") 'font-zoom-decrease-font-size)
;(define-key global-map (read-kbd-macro "C-=") 'font-zoom-increase-font-size)
;(define-key global-map (read-kbd-macro "C-0") 'font-zoom-reset-font-size)

;(set-frame-font (nth font-zoom-index font-zoom-list))
;(set-frame-font "-*-fixed-medium-r-*--13-*-*-*-*-60-ISO8859-1")
;(set-frame-font "-*-fixed-medium-r-*--18-*-*-*-*-60-ISO8859-1")
; (set-frame-font "6x13")

; (global-hl-line-mode -1)
; (set-face-background 'hl-line "#707070")

(provide 'paulv-appearance)
