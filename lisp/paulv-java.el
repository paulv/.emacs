(defun paulv-java-mode-hook () (abbrev-mode nil))
(add-hook 'java-mode-hook  'paulv-java-mode-hook)

(provide 'paulv-java)