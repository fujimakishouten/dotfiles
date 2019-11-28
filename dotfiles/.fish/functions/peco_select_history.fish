function peco_select_history
    history | peco --query $argv | read -l line && commandline $line
    commandline -f repaint
end

