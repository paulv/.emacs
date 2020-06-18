;; translates backspace and ^H so deleting works. This seems to break
;; C-h for help, but you can use M-x help instead
; (keyboard-translate ?\C-h ?\C-?)
; (keyboard-translate ?\C-\\ ?\C-h)

(defun match-paren (arg)
  "Go to the matching paren if on a paren, otherwise does nothing."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (message "you are not on a paren"))))

(global-set-key "\M-g" 'goto-line)
(global-set-key "\C-cp" 'match-paren)
(global-set-key "\C-ci" 'indent-region)
(global-set-key "\C-cc" 'compile)
(global-set-key "\C-xu"
                '(lambda ()
                   (interactive)
                   (message "use C-/ instead")))

(if (string-equal window-system "x") (global-set-key "\C-z" '()))

(provide 'paulv-key-bindings)
