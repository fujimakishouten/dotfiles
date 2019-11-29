function peco_select_history
    history | awk '!a[$0]++' | peco | sed 's/\\n/\n/g'

    commandline -f repaint
end

