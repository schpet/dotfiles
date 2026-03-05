function zellij --wraps=zellij --description "zellij wrapper that defaults session name to hostname"
    if test (count $argv) -eq 0
        command zellij attach -c (hostname -s)
    else
        command zellij $argv
    end
end
