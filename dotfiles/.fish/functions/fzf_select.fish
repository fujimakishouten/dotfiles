function fzf_select
    if type tac > /dev/null 2>&1
        set -x TAC tac
    else
        set -x TAC "tail -r"
    end

    history | $TAC | fzf --ansi --cycle --header-first --no-separator --no-sort --color "light" --layout "reverse" --scheme "history" --tabstop 4 --query "$LBUFFER" --tiebreak "begin" | read HISTORY

    if test $HISTORY
        commandline $HISTORY
    else
        commandline ""
    end
end

