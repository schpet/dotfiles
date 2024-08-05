function report
    eval $argv
    set exit_status $status

    if test $exit_status -eq 0
        say "Command succeeded"
    else
        say "Command failed with exit code $exit_status"
    end
end
