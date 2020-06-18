(when (= 0 1)
  ;; I'm using the bbdb package from debian/ubuntu, so if you don't
  ;; apt-get install it, you'll need to get it some other way. It's
  ;; version 2.35.cvs20060204-1.2ubuntu2, and seems to be different than
  ;; master on http://git.savannah.gnu.org/cgit/bbdb.git as of 13 April
  ;; 2012.

  ;; set this first just so no part of bbdb thinks the database is
  ;; somewhere else.
  (setq bbdb-file "~/.emacs.d/gnus-private/bbdb")

  (require 'bbdb)
  (require 'bbdb-com)
  (require 'bbdb-gnus)

  (bbdb-initialize)
  (add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)

  (add-hook 'message-setup-hook 'bbdb-define-all-aliases)

  (setq bbdb-no-duplicates t)
  (setq bbdb-use-alternate-names t)
  (setq bbdb-use-pop-up nil)
  (setq bbdb-always-add-addresses nil)

  ;; I don't have any clue why this is the default. If you don't turn it
  ;; off, every time you view a message, it shows you the BBDB records.
  ;; What the actual fuck.
  (remove-hook 'gnus-article-prepare-hook 'bbdb/gnus-pop-up-bbdb-buffer))

(provide 'paulv-bbdb)
