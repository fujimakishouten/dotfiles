function fish_prompt
#    if test -n "$SSH_TTY"
#        switch (id --user)
#            case '*'
#                printf "%s" (set_color green)
#        end
#    end

    # Main
    printf "%s@%s:%s%% %s" $USER (prompt_hostname) (pwd) (set_color normal)
end

function fish_right_prompt
    # Git
    set last_status $status
    printf '%s' (__fish_git_prompt)
    set_color normal
end
