(require 'epa-file)
(epa-file-enable)
(setq epa-file-cache-passphrase-for-symmetric-encryption t)

;; This bit is from
;; http://www.enigmacurry.com/2009/01/14/extending-emacs-with-advice/
;;
;; They wrap epg--start to prevent it from looking at the GPG_AGENT_INFO
;; environment variable. If GPG_AGENT_INFO is set, I get a prompt in a
;; GUI window from seahorse. If it's disabled, emacs prompts me for the
;; password.

(defadvice epg--start (around advice-epg-disable-agent disable)
  "Make epg--start not able to find a gpg-agent"
  (let ((agent (getenv "GPG_AGENT_INFO")))
    (setenv "GPG_AGENT_INFO" nil)
    ad-do-it
    (setenv "GPG_AGENT_INFO" agent)))

(defun epg-disable-agent ()
  "Make EasyPG bypass any gpg-agent"
  (interactive)
  (ad-enable-advice 'epg--start 'around 'advice-epg-disable-agent)
  (ad-activate 'epg--start)
  (message "EasyPG gpg-agent bypassed"))

(defun epg-enable-agent ()
  "Make EasyPG use a gpg-agent after having been disabled with epg-disable-agent"
  (interactive)
  (ad-disable-advice 'epg--start 'around 'advice-epg-disable-agent)
  (ad-activate 'epg--start)
  (message "EasyPG gpg-agent re-enabled"))

(epg-disable-agent)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun epg-signature-creation-time (signature)
  "Return the creation time of SIGNATURE."
  (unless (eq (car-safe signature) 'epg-signature)
    (signal 'wrong-type-argument (list 'epg-signature-p signature)))
  (aref (cdr signature) 4))

(defun epg-signature-to-string (signature)
  "Convert SIGNATURE to a human readable string."
  (let* ((user-id (cdr (assoc (epg-signature-key-id signature)
                              epg-user-id-alist)))
         (pubkey-algorithm (epg-signature-pubkey-algorithm signature)))
    (concat
     (cond ((eq (epg-signature-status signature) 'good)
            "Good sig from ")
           ((eq (epg-signature-status signature) 'bad)
            "Bad sig from ")
           ((eq (epg-signature-status signature) 'expired)
            "Expired sig from ")
           ((eq (epg-signature-status signature) 'expired-key)
            "Sig made by expired key ")
           ((eq (epg-signature-status signature) 'revoked-key)
            "Sig made by revoked key ")
           ((eq (epg-signature-status signature) 'no-pubkey)
            "No public key for "))
     (epg-signature-key-id signature)
     (if user-id
         (concat " "
                 (if (stringp user-id)
                     user-id
                   (epg-decode-dn user-id)))
       "")
     (if (epg-signature-validity signature)
         (format "\ntrust: %s"  (epg-signature-validity signature))
       "")
     ;; (if (epg-signature-creation-time signature)
     ;;     (format-time-string " created at %Y-%m-%dT%T%z"
     ;;                         (epg-signature-creation-time signature))
     ;;   "")
     ;; (if pubkey-algorithm
	 ;; (concat " using "
	 ;;     (or (cdr (assq pubkey-algorithm epg-pubkey-algorithm-alist))
	 ;;         (format "(unknown algorithm %d)" pubkey-algorithm)))
     ;;"")
     )))

(provide 'paulv-epa)
