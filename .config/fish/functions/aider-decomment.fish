function aider-decomment
	aider --model o4-mini --message "remove any comments added or updated in this branch: $(git diff origin/main..HEAD -- . ':(exclude)package.json' ':(exclude)yarn.lock' ':(exclude)Gemfile.lock' ':(exclude)schema.graphql')"
end
