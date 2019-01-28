function fish_prompt
    test $SSH_TTY
    and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '
    test $USER = 'root'
    and echo (set_color red)"#"

    # Main
    printf "%s@%s:%s%% " $USER (prompt_hostname) (pwd)
end

function fish_right_prompt
    # Git
    set last_status $status
    printf '%s' (__fish_git_prompt)
    set_color normal
end
