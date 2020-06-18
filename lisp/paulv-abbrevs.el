;; I like abbrev's. This loads them.  this should check to see if
;; "~/.abbrev_defs exists and load them if it does.
;; (setq-default abbrev-mode t)

(condition-case ()
    (read-abbrev-file "~/.abbrev_defs")
  (t nil)
  (error (message "paulv: Couldn't load ~/.abbrev_defs...")))

(setq-default save-abbrevs t)
(setq-default only-global-abbrevs t)

(setq-default abbrev-mode nil)

(provide 'paulv-abbrevs)