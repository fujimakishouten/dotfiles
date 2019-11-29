function peco_select_history
    set LF '\\\x0A'
    history | awk '!a[$0]++' | peco | sed 's/\\n/'"$LF"'/g'

    commandline -f repaint
end

