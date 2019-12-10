function la --description 'ls long list all'
	env LC_COLLATE=C ls --color=auto -lahN $argv;
end
