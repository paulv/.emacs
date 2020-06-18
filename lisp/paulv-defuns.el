(defun insert-shell-command-output-from-region (p1 p2)
  (interactive "r")
  (kill-ring-save p1 p2)
  (let
      ((command (read-string "Command to run: " nil 'my-history)))
    (insert (concat  (yank) command))))

(defun insert-shell-command-output ()
  (interactive
   (let ((command (read-string "Command to run: " nil 'my-history)))
     (insert (shell-command-to-string command)))))

;; this is a function I wrote that inserts the current date in the form
;; "February 01, 2001 17:15"
(defun insert-date ()
  (interactive)
  (insert
   (substring (shell-command-to-string "date \"+%d %B %Y\"") 0 -1)))

(defun instert-date-with-time ()
  (interactive)
  (insert
   (substring (shell-command-to-string "date \"+%d %B %Y %k:%M\"") 0 -1)))

;; this is a function I wrote that inserts the current date in the form
;; "Thu Feb 1 17:15:29 EST 2001"
(defun insert-long-date ()
  (interactive)
  (insert (substring (shell-command-to-string "date") 0 -1)))

;; this is a function I wrote that inserts the current date in the form
;; "20010201"
(defun insert-iso-date ()
  (interactive)
  (insert (substring (shell-command-to-string "date +%Y%m%d") 0 -1)))

;; this is a function I wrote that simply loads my .emacs
(defun load-emacs ()
  (interactive)
  (load-file "~/.emacs"))


;; this function inserts a new serial number
(defun insert-serial ()
  (interactive)
  (kill-sentence)
  (insert-iso-date)
  (insert "00 ; serial number")
  (backward-char 16)
  (ding))

(defun refontify ()
  (interactive)
  (font-lock-fontify-buffer))

(defun normalize-spaces-away-end-lines ()
  (interactive)
  (let ( (save-point (point)) )
    ;; or (goto-char (point-min)) if you want it to go to the top of
    ;; the buffer
    ;; (goto-char (point))
    (goto-char (move-point-to-end-of-headers))
    (replace-regexp " +$" "" nil)
    (goto-char save-point)))

(defun move-point-to-end-of-headers ()
  (interactive)
  (rfc822-goto-eoh)
  (forward-line 1)
  (point))

(defun turn-off-auto-fill nil
  (auto-fill-mode 0))

(defun tail-file  (filename &optional command)
  (interactive
   (append
    (list (read-file-name "File to Tail: " nil nil t))

    (cond (current-prefix-arg
           (list
            (read-from-minibuffer "Command: " "tail -f")))
          (t nil))))

  (let ((tailed-buffer
         (generate-new-buffer
          (concat "Tailing: " (file-name-nondirectory filename))))
        (tail-command (concat (or command "tail -f") " "
                              (expand-file-name filename))))
    (start-process-shell-command (concat "Tail: " tail-command)
                                 tailed-buffer tail-command)
    (switch-to-buffer tailed-buffer)))

(defun eval-replace-region (start end)
  (interactive "r")
  (save-excursion
    (eval-region start end (current-buffer))
    (delete-region start end))
  (delete-char 1)
  (end-of-line)
  (delete-char 1))

;;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph
;;; Takes a multi-line paragraph and makes it into a single line of text.
;;; from http://emacswiki.org/cgi-bin/wiki/UnfillParagraph
(defun unfill-paragraph ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

(defun inside-string-p ()
  "Returns true if we're inside a string."
  (cadddr (syntax-ppss)))

(defun backward-up-list-escaping-strings ()
  "Like backward-up-list, but works if we're inside a string."
  ;; probably should take comments into account too
  (while (inside-string-p) (backward-char))
  (backward-up-list))

(defun start-of-list ()
  "Go to inside the start of the currently enclosing list --- e.g. arg list."
  (interactive)
  (backward-up-list-escaping-strings)
  (down-list))

(defun end-of-list-p ()
  "Can we move no further forward without going up a list?"
  (looking-at "\\(\\s.\\|\n\\|\\s-\\)*\\s)"))

(defun horizontal-to-vertical-list ()
  "Turn a horizontal argument list into a vertical argument list.
This is written so that it only breaks at commas and semicolons;
too bad for Lisps."
  (interactive)
  (save-excursion
    (start-of-list)
    (while (not (end-of-list-p))
      (while (not (or (end-of-list-p) (looking-at "\\s-*[;,]"))) ; skip over arg
        (forward-sexp))
      (while (looking-at "\\s-*[;,]") (forward-char)) ; skip over comma
      ;; now delete whitespace after comma
      (while (and (not (looking-at "\n")) (looking-at "\\s-")) (delete-char 1))
      (when (not (end-of-list-p)) ; insert newline if needed and indent
        (if (looking-at "\n") (forward-char) (insert "\n"))
        (indent-for-tab-command)))
    (if (current-list-horizontal-p)
        (message "Couldn't find any commas or semicolons.  Are you editing
Lisp?"))))

(defun vertical-to-horizontal-list ()
  (interactive)
  (save-excursion
    (backward-up-list-escaping-strings)
    (forward-list)
    (backward-char)
    (while (not (current-list-horizontal-p))
      (save-excursion (delete-indentation)))))

(defun current-list-horizontal-p ()
  "Returns nil unless the list around point is all on one line."
  (save-excursion
    (backward-up-list-escaping-strings)
    (let ((start (point)))
      (forward-list)
      (= 1 (count-lines start (point))))))


(defun toggle-list-orientation ()
  "Turn a horizontal list into a vertical one, or vice versa."
  (interactive)
  (if (current-list-horizontal-p)
      (horizontal-to-vertical-list)
    (vertical-to-horizontal-list)))

(defun paulv-save-word ()
  (interactive)
  (ispell-send-string (concat "*" (current-word) "\n"))
  (ispell-send-string "#\n"))

(defun is-version (num)
  (= emacs-major-version num))

(defun is-not-version (num)
  (not (= emacs-major-version num)))

(defun paulv-new-frame ()
  (interactive)
  (let
      ((paulv-current-frame (selected-frame))
       (paulv-my-new-frame (make-frame)))
    (select-frame paulv-my-new-frame)
    (set-frame-font "Ubuntu Mono-11")
    (modify-frame-parameters nil '((left . 3072)))
    (x-send-client-message paulv-my-new-frame 0 nil "_NET_WM_STATE" 32
                           '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
    (x-send-client-message paulv-my-new-frame 0 nil "_NET_WM_STATE" 32
                           '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
    (select-frame-set-input-focus paulv-current-frame)))

(provide 'paulv-defuns)
