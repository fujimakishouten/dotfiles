function ghq_select
    set -l query (commandline)
    ghq list --full-path | peco --query "$query" | read select
    if test -n "$select"
        cd "$select"
    end

    commandline -f repaint
end

