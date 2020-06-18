(when (= 0 1)
  ;; (set-frame-font "Ubuntu Mono-11")
  (add-to-list 'load-path (concat dotfiles-dir "vendor/gnus/lisp"))
  (add-to-list 'load-path (concat dotfiles-dir "vendor/gnus/contrib"))

  ;; most of these would get loaded when we start gnus, but some of them
  ;; have variable definitions, etc, so we require them explicitly so we
  ;; don't have problems with variables being undefined.
  (require 'gnus-load)
  (require 'gnus-sum)
  (require 'gnus-art)
  (require 'gnus-cite)
  (require 'gnus-demon)

  (require 'vcard)

  (setq user-full-name "Paul Visscher")
  (setq user-mail-address "paul_visscher@kace.com")

  (setq gnus-select-method
        '(nnimap "localhost"
                 (nnimap-address "localhost")
                 (nnimap-server-port 1143)
                 (nnimap-authinfo-file "~/.authinfo")
                 (nnimap-stream network)))

  (setq gnus-subscribe-newsgroup-method 'gnus-subscribe-alphabetically)

  (setq paulv-email-addresses "paulv@canonical\\.org\\|paulv@sfconservancy\\.org\\|paulvi@gmail\\.com\\|paulv\\+.*@canonical\\.org")

  ;; » if it's to me
  ;; ~ if it's to me and others, bcc'ed, or cc'ed to me
  (defun gnus-user-format-function-a (headers)
    (let
        ((to (gnus-extra-header 'To headers)))
      (if (string-match paulv-email-addresses to)
          (if (string-match "," to) "~" "»")
        (if (or (string-match paulv-email-addresses
                              (gnus-extra-header 'Cc headers))
                (string-match paulv-email-addresses
                              (gnus-extra-header 'BCc headers)))
            "~"
          " "))))


  (defun gnus-user-format-function-b (thing)
    (concat
     (number-to-string
      (gnus-number-of-unseen-articles-in-group gnus-tmp-group))
     "/"
     gnus-tmp-number-of-unread))

  ;; don't go to the next group when I q out of a group summary
  (setq gnus-summary-next-group-on-exit nil)

  (setq gnus-user-date-format-alist '((t . "%b %d")))

  ;; this is the default plus a newline. I like to have the newline below
  ;; the "--text ..." line, but don't want it to show up in the email.
  (setq mail-header-separator "--text follows this line--\n")

  (setq gnus-summary-line-format "%ua%U%R%[%&user-date;: %-15,15f%] %B%s\n")
  (setq gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references)
  (setq gnus-thread-sort-functions '(gnus-thread-sort-by-date))
  (setq gnus-sum-thread-tree-false-root "")
  (setq gnus-sum-thread-tree-indent " ")
  (setq gnus-sum-thread-tree-leaf-with-other "├─► ")
  (setq gnus-sum-thread-tree-root "")
  (setq gnus-sum-thread-tree-single-leaf "└─► ")
  (setq gnus-sum-thread-tree-vertical "│")

  (setq gnus-kill-files-directory "~/.emacs.d/gnus-private/")
  (setq gnus-score-find-score-files-function 'gnus-score-find-single)

  ;; put all the scores in one file
  (defun paulv-score-file-function (group) (list "all.SCORE"))

  (setq gnus-score-find-score-files-function 'paulv-score-file-function)

  (setq gnus-group-line-format "%M%S%p%P%10ub:%B%g\n")

  ;; show smileys as text
  (setq gnus-treat-display-smileys nil)

  (setq gnus-visible-headers "^From:\\|^Newsgroups:\\|^Subject:\\|^Date:\\|^Followup-To:\\|^Reply-To:\\|^Organization:\\|^Summary:\\|^Keywords:\\|^To:\\|^[BGF]?Cc:\\|^Posted-To:\\|^Mail-Copies-To:\\|^Mail-Followup-To:\\|^Apparently-To:\\|^Gnus-Warning:\\|^Resent-From:\\|^X-Mailer:\\|^User-Agent:\\|^Message-ID\\|^X-Mailing-List:\\|X-No-Archive:\\|X-Archive:")

  ;; 4000-4999 misc important
  ;; 5000-5999 work
  ;; 7000-7999 personal
  ;; 8000-9000 misc interesting people

  (add-to-list
   'gnus-summary-highlight
   '((and(>= score 4000) (<= score 4999)) . paulv-gnus-score-misc-face))

  (add-to-list
   'gnus-summary-highlight
   '((and(>= score 5000) (<= score 5999)) . paulv-gnus-score-work-face))

  (add-to-list
   'gnus-summary-highlight
   '((and (>= score 7000) (<= score 7999)) . paulv-gnus-score-friends-face))

  (add-to-list
   'gnus-summary-highlight
   '((and (>= score 8000) (<= score 8999)) . paulv-gnus-score-interesting-people-face))

;;;;;;;;;;;;;;;;;;;;;;
  ;; Face definitions ;;
;;;;;;;;;;;;;;;;;;;;;;

  (defface paulv-gnus-score-misc-face
    '((t
       (:foreground "green")))
    "Face used for misc. messages")

  (defface paulv-gnus-score-work-face
    '((t
       (:foreground "dodgerblue")))
    "Face used for work contacts")

  (defface paulv-gnus-score-friends-face
    '((t
       (:foreground "cyan4")))
    "Face used for work contacts")

  (defface paulv-gnus-score-interesting-people-face
    '((t
       (:foreground "firebrick1")))
    "Face used for work contacts")

  (defface paulv-gnus-score-misc-face
    '((t
       (:foreground "darkgoldenrod1")))
    "Face used for work contacts")

  (defface paulv-gnus-header-from
    '((t
       (:foreground "dodgerblue")))
    "Face used for the From header")

  (defface paulv-gnus-header-subject
    '((t
       (:foreground "green yellow")))
    "Face used for the Subject header")

  (defface paulv-gnus-header-default-name
    '((t
       (:foreground "white")))
    "Face used for otherwise unspecified header names")

  (defface paulv-gnus-header-default-content
    '((t
       (:foreground "white")))
    "Face used for otherwise unspecified header content")

  (setq gnus-header-face-alist '())

  (add-to-list 'gnus-header-face-alist '("From" nil paulv-gnus-header-from))
  (add-to-list 'gnus-header-face-alist '("Subject" nil paulv-gnus-header-subject))

  (add-to-list 'gnus-header-face-alist '("Date:" nil bold))

  ;; this one should be last, hence the t at the end
  (add-to-list 'gnus-header-face-alist '("" paulv-gnus-header-default-name paulv-gnus-header-default-content) t)

  (set-face-attribute 'gnus-button nil
                      :bold nil
                      :underline t
                      :foreground "cyan")

  (set-face-attribute 'gnus-signature nil
                      :italic nil)

  (set-face-attribute 'gnus-cite-attribution nil
                      :italic nil)

  ;; this basically disables this regexp. I don't know a better way.
  (setq gnus-button-mid-or-mail-regexp "^$ ")

  ;; Don't ever turn on buttons in the header.
  (setq gnus-header-button-alist ())

  ;;(setq gnus-blocked-images "doubleclick")

  ;; this doesn't work the way I want it to.
  ;; (defun paulv-gnus-toggle-image ()
  ;;   (interactive)
  ;;   (cond
  ;;    ((member "image/.*" mm-automatic-display)
  ;;     (setq mm-automatic-display (delete "image/.*" mm-automatic-display)))
  ;;    ((not (member "image/.*" mm-automatic-display))
  ;;     (push "image/.*" mm-automatic-display))))


  (setq gnus-inhibit-user-auto-expire t)

  (setq gnus-novice-user nil)

  (setq gnus-message-archive-group "nnimap:Sent")

  ;; redefining this because by default it shows you the article your
  ;; cursor is on, which is annoying.
  (defun gnus-summary-rescan-group (&optional all)
    "Exit the newsgroup, ask for new articles, and select the newsgroup."
    (interactive "P")
    (let ((config gnus-current-window-configuration))
      (gnus-summary-reselect-current-group all t)))

  ;; check for mail every 2 minutes, but only when emacs is idle.
  (defun paulv-gnus-started-hook ()
    (require 'gnus-demon)
    (gnus-demon-init)
    (gnus-demon-add-handler 'gnus-demon-scan-news 2 2))

  (add-hook 'gnus-started-hook 'paulv-gnus-started-hook)

  (defun paulv-message-insert-citation-line ()
    "Insert a simple citation line."
    (when message-reply-headers
      (insert (mail-header-from message-reply-headers) " said:")
      (newline)))

  (setq message-citation-line-function 'paulv-message-insert-citation-line)

  (setq mm-verify-option 'known)
  (setq mm-decrypt-option 'known)

  (setq gnus-buttonized-mime-types '("multipart/encrypted" "multipart/signed"))

  ;; default:
  ;; (setq gnus-mime-security-button-line-format "%{%([[%t:%i]%D]%)%}\n")
  (setq gnus-mime-security-button-line-format "%t:\n%i\n\n")

  ;; turn off the *gnus trace* and *imap log* buffers
  (setq gnus-backend-trace nil)
  (setq nnimap-inhibit-logging t)

  ;; prefer to not see these mime types if we have a choice.
  (setq mm-discouraged-alternatives '("text/html" "text/richtext"))

  ;; never show links to man pages.
  (setq gnus-button-man-level 0)

  ;; gnus-summary-delete-article doesn't move to the next message when
  ;; it's done.

  (define-key gnus-summary-mode-map (kbd "B <backspace>")
    (lambda ()
      (interactive)
      (gnus-summary-delete-article)
      (next-line)))

  (setq message-subscribed-addresses
        '("hackers@canonical.org"
          "linux-sig@lists.dma.org"
          "linux-sig@dma.org"))

  (setq message-alternative-emails
        (regexp-opt '("paulv@canonical.org" "paulv@sfconservancy.org")))

  (gnus-delay-initialize)

  (defadvice gnus-draft-send (around remove-date-header-from-delayed-message
                                     activate)
    "Remove Date header from delayed message in order to be redone."
    (if (equal (ad-get-arg 1) "nndraft:delayed")
        (let ((gnus-message-setup-hook
               (cons (lambda nil
                       (message-remove-header "date" nil t))
                     gnus-message-setup-hook)))
          ad-do-it)
      ad-do-it))


  (setq gnus-secondary-select-methods
        '((nnmaildir "mairix" (directory "~/Mail/mairix"))))

  (defun paulv-clean-fwd-headers ()
    (interactive)
    (save-excursion
      (delete-non-matching-lines "^\\(From\\|To\\|Cc\\|Subject\\|Date\\):")))

  (require 'nnmairix)

  (require 'nnir)
  ;; (setq nnir-method-default-engines '((nnimap . imap)
  ;;                                    (nntp . gmane)))
  ;; (setq nnir-namazu-program "/home/paulv/bin/pv-namazu")
  ;; (setq nnir-search-engine 'namazu)
  ;; (setq nnir-namazu-index-directory
  ;;       (expand-file-name "~/files/cache/"))
  ;; (setq nnir-namazu-remove-prefix
  ;;       (expand-file-name "~/mail/"))
  ;; (setq nnir-mail-backend (nth 0 gnus-secondary-select-methods))
  )
(provide 'paulv-gnus)
