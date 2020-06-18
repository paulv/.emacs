(server-start)

(add-hook 'server-switch-hook
          (lambda ()
            (message "called server-switch-hook!")
            (local-set-key "\C-x\C-c" 'server-edit)))

(add-hook 'server-done-hook
          (lambda ()
            (cond ((getenv "STY") (shell-command "screen -X next"))
                  ((getenv "TMUX") (shell-command "tmux next")))))

(add-hook 'server-done-hook
          (lambda ()
            (local-unset-key "\C-x\C-c")))

(provide 'paulv-server)
