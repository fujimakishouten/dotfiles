function ghq_select
    set -l query (commandline)
    ghq list --full-path | fzf --ansi --cycle --header-first --no-separator --no-sort --color "light" --layout "reverse" --scheme "history" --tabstop 4 --query "$query" --tiebreak "begin" | read select
    if test -n "$select"
        commandline 'cd "'"$select"'"'
    end

    commandline -f repaint
end

