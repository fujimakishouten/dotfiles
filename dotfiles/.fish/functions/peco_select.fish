function peco_select
    set LF '\\\x0A'
    history | awk '!a[$0]++' | peco | sed 's/\\n/'"$LF"'/g' | read HISTORY

    if test $HISTORY
        commandline $HISTORY
    else
        commandline ""
    end
end

