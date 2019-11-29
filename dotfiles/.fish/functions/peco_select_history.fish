function peco_select_history
    history | awk '!a[$0]++' | peco

    commandline -f repaint
end

