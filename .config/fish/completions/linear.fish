#!/usr/bin/env fish
# fish completion support for linear v0.4.1

function __fish_linear_using_command
  set -l cmds __linear __linear_issue __linear_issue_open __linear_issue_print __linear_issue_id __linear_issue_list __linear_issue_title __linear_issue_start __linear_issue_view __linear_issue_url __linear_issue_pull_request __linear_team __linear_team_open __linear_team_id __linear_team_autolinks __linear_completions __linear_completions_bash __linear_completions_fish __linear_completions_zsh __linear_config
  set -l words (commandline -opc)
  set -l cmd "_"
  for word in $words
    switch $word
      case '-*'
        continue
      case '*'
        set word (string replace -r -a '\W' '_' $word)
        set -l cmd_tmp $cmd"_$word"
        if contains $cmd_tmp $cmds
          set cmd $cmd_tmp
        end
    end
  end
  if test "$cmd" = "$argv[1]"
    return 0
  end
  return 1
end

complete -c linear -n '__fish_linear_using_command __linear' -s h -l help -x -k -f -d 'Show this help.'
complete -c linear -n '__fish_linear_using_command __linear' -s V -l version -x -k -f -d 'Show the version number for this program.'
complete -c linear -n '__fish_linear_using_command __linear' -k -f -a issue -d 'Manage Linear issues'
complete -c linear -n '__fish_linear_using_command __linear_issue' -k -f -a '(linear completions complete string issue)'
complete -c linear -n '__fish_linear_using_command __linear_issue' -s h -l help -x -k -f -d 'Show this help.'
complete -c linear -n '__fish_linear_using_command __linear_issue' -k -f -a open -d 'Open the issue in Linear.app (deprecated: use `linear issue view --app` instead)'
complete -c linear -n '__fish_linear_using_command __linear_issue_open' -k -f -a '(linear completions complete string issue open)'
complete -c linear -n '__fish_linear_using_command __linear_issue_open' -s h -l help -x -k -f -d 'Show this help.'
complete -c linear -n '__fish_linear_using_command __linear_issue' -k -f -a print -d 'Print the issue details (deprecated: use `linear issue view` instead)'
complete -c linear -n '__fish_linear_using_command __linear_issue_print' -k -f -a '(linear completions complete string issue print)'
complete -c linear -n '__fish_linear_using_command __linear_issue_print' -s h -l help -x -k -f -d 'Show this help.'
complete -c linear -n '__fish_linear_using_command __linear_issue_print' -l no-color -k -f -d 'Disable colored output'
complete -c linear -n '__fish_linear_using_command __linear_issue' -k -f -a id -d 'Print the issue based on the current git branch'
complete -c linear -n '__fish_linear_using_command __linear_issue_id' -s h -l help -x -k -f -d 'Show this help.'
complete -c linear -n '__fish_linear_using_command __linear_issue' -k -f -a list -d 'List your issues'
complete -c linear -n '__fish_linear_using_command __linear_issue_list' -s h -l help -x -k -f -d 'Show this help.'
complete -c linear -n '__fish_linear_using_command __linear_issue_list' -l sort -k -f -r -a '(linear completions complete sort issue list)' -d 'Sort order (can also be set via LINEAR_ISSUE_SORT)'
complete -c linear -n '__fish_linear_using_command __linear_issue_list' -s s -l state -k -f -r -a '(linear completions complete state issue list)' -d 'Filter by issue state'
complete -c linear -n '__fish_linear_using_command __linear_issue_list' -s w -l web -k -f -d 'Open in web browser'
complete -c linear -n '__fish_linear_using_command __linear_issue_list' -s a -l app -k -f -d 'Open in Linear.app'
complete -c linear -n '__fish_linear_using_command __linear_issue' -k -f -a title -d 'Print the issue title'
complete -c linear -n '__fish_linear_using_command __linear_issue_title' -k -f -a '(linear completions complete string issue title)'
complete -c linear -n '__fish_linear_using_command __linear_issue_title' -s h -l help -x -k -f -d 'Show this help.'
complete -c linear -n '__fish_linear_using_command __linear_issue' -k -f -a start -d 'Start working on an issue'
complete -c linear -n '__fish_linear_using_command __linear_issue_start' -k -f -a '(linear completions complete string issue start)'
complete -c linear -n '__fish_linear_using_command __linear_issue_start' -s h -l help -x -k -f -d 'Show this help.'
complete -c linear -n '__fish_linear_using_command __linear_issue' -k -f -a view -d 'View issue details (default) or open in browser/app'
complete -c linear -n '__fish_linear_using_command __linear_issue_view' -k -f -a '(linear completions complete string issue view)'
complete -c linear -n '__fish_linear_using_command __linear_issue_view' -s h -l help -x -k -f -d 'Show this help.'
complete -c linear -n '__fish_linear_using_command __linear_issue_view' -s w -l web -k -f -d 'Open in web browser'
complete -c linear -n '__fish_linear_using_command __linear_issue_view' -s a -l app -k -f -d 'Open in Linear.app'
complete -c linear -n '__fish_linear_using_command __linear_issue' -k -f -a url -d 'Print the issue URL'
complete -c linear -n '__fish_linear_using_command __linear_issue_url' -k -f -a '(linear completions complete string issue url)'
complete -c linear -n '__fish_linear_using_command __linear_issue_url' -s h -l help -x -k -f -d 'Show this help.'
complete -c linear -n '__fish_linear_using_command __linear_issue' -k -f -a pull-request -d 'Create a GitHub pull request with issue details'
complete -c linear -n '__fish_linear_using_command __linear_issue_pull_request' -k -f -a '(linear completions complete string issue pull-request)'
complete -c linear -n '__fish_linear_using_command __linear_issue_pull_request' -s h -l help -x -k -f -d 'Show this help.'
complete -c linear -n '__fish_linear_using_command __linear_issue_pull_request' -l base -k -f -r -a '(linear completions complete string issue pull-request)' -d 'The branch into which you want your code merged'
complete -c linear -n '__fish_linear_using_command __linear_issue_pull_request' -l draft -k -f -d 'Create the pull request as a draft'
complete -c linear -n '__fish_linear_using_command __linear_issue_pull_request' -s t -l title -k -f -r -a '(linear completions complete string issue pull-request)' -d 'Optional title for the pull request (Linear issue ID will be prefixed)'
complete -c linear -n '__fish_linear_using_command __linear' -k -f -a team -d 'Manage Linear teams (deprecated: use `linear issue list --app` instead)'
complete -c linear -n '__fish_linear_using_command __linear_team' -s h -l help -x -k -f -d 'Show this help.'
complete -c linear -n '__fish_linear_using_command __linear_team' -k -f -a open -d 'Open the team page in Linear.app'
complete -c linear -n '__fish_linear_using_command __linear_team_open' -s h -l help -x -k -f -d 'Show this help.'
complete -c linear -n '__fish_linear_using_command __linear_team' -k -f -a id -d 'Print the team id derived from the repository name'
complete -c linear -n '__fish_linear_using_command __linear_team_id' -s h -l help -x -k -f -d 'Show this help.'
complete -c linear -n '__fish_linear_using_command __linear_team' -k -f -a autolinks -d 'Configure GitHub repository autolinks for Linear issues'
complete -c linear -n '__fish_linear_using_command __linear_team_autolinks' -s h -l help -x -k -f -d 'Show this help.'
complete -c linear -n '__fish_linear_using_command __linear' -k -f -a completions -d 'Generate shell completions.'
complete -c linear -n '__fish_linear_using_command __linear_completions' -s h -l help -x -k -f -d 'Show this help.'
complete -c linear -n '__fish_linear_using_command __linear_completions' -k -f -a bash -d 'Generate shell completions for bash.'
complete -c linear -n '__fish_linear_using_command __linear_completions_bash' -s h -l help -x -k -f -d 'Show this help.'
complete -c linear -n '__fish_linear_using_command __linear_completions_bash' -s n -l name -k -f -r -a '(linear completions complete string completions bash)' -d 'The name of the main command.'
complete -c linear -n '__fish_linear_using_command __linear_completions' -k -f -a fish -d 'Generate shell completions for fish.'
complete -c linear -n '__fish_linear_using_command __linear_completions_fish' -s h -l help -x -k -f -d 'Show this help.'
complete -c linear -n '__fish_linear_using_command __linear_completions_fish' -s n -l name -k -f -r -a '(linear completions complete string completions fish)' -d 'The name of the main command.'
complete -c linear -n '__fish_linear_using_command __linear_completions' -k -f -a zsh -d 'Generate shell completions for zsh.'
complete -c linear -n '__fish_linear_using_command __linear_completions_zsh' -s h -l help -x -k -f -d 'Show this help.'
complete -c linear -n '__fish_linear_using_command __linear_completions_zsh' -s n -l name -k -f -r -a '(linear completions complete string completions zsh)' -d 'The name of the main command.'
complete -c linear -n '__fish_linear_using_command __linear' -k -f -a config -d 'Interactively generate .linear.toml configuration'
complete -c linear -n '__fish_linear_using_command __linear_config' -s h -l help -x -k -f -d 'Show this help.'
