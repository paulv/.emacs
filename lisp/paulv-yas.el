;;(add-to-list 'load-path paulv-yas-path)
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
;;(yas/load-directory (concat paulv-yas-path "snippets"))
(setq yas/prompt-functions '(yas/dropdown-prompt))

(provide 'paulv-yas)

