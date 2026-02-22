#!/bin/bash
# PS1 CUSTOMIZATION

# TODO: apparently git-prompt hardcodes it's location
# GIT_PROMPT_DIR="$XDG_CONFIG_DIR/bash/bash-git-prompt"
GIT_PROMPT_DIR="$HOME/.bash-git-prompt"


FG_COLOR="2" # green
STYLE="\[$(tput bold)$(tput setb 4)$(tput setaf $FG_COLOR)\]"
STYLE_END="\[$(tput sgr0)\]"
FIRST_LINE='[\u@\h] \w'
SECOND_LINE='> '

# https://github.com/magicmonty/bash-git-prompt
if [ -f "$GIT_PROMPT_DIR/gitprompt.sh" ]; then
	GIT_PROMPT_ONLY_IN_REPO=0

	# GIT_PROMPT_FETCH_REMOTE_STATUS=0   # uncomment to avoid fetching remote status
	GIT_PROMPT_IGNORE_SUBMODULES=1 # uncomment to avoid searching for changed files in submodules
	# GIT_PROMPT_WITH_VIRTUAL_ENV=0 # uncomment to avoid setting virtual environment infos for node/python/conda environments
	# GIT_PROMPT_VIRTUAL_ENV_AFTER_PROMPT=1 # uncomment to place virtual environment infos between prompt and git status (instead of left to the prompt)

	GIT_PROMPT_SHOW_UPSTREAM=1 # uncomment to show upstream tracking branch
	GIT_PROMPT_SHOW_UNTRACKED_FILES=no # can be no, normal or all; determines counting of untracked files
	GIT_PROMPT_SHOW_CHANGED_FILES_COUNT=0 # uncomment to avoid printing the number of changed files

	# GIT_PROMPT_STATUS_COMMAND=gitstatus_pre-1.7.10.sh # uncomment to support Git older than 1.7.10

	# GIT_PROMPT_START="${GREEN} ${USER} ${PathShort}"    # uncomment for custom prompt start sequence
	GIT_PROMPT_END="\n$SECOND_LINE"      # uncomment for custom prompt end sequence

	# as last entry source the gitprompt script
	# GIT_PROMPT_THEME=Custom # use custom theme specified in file GIT_PROMPT_THEME_FILE (default ~/.git-prompt-colors.sh)
	# GIT_PROMPT_THEME_FILE=~/.git-prompt-colors.sh
	GIT_PROMPT_THEME=MyTheme # use theme optimized for solarized color scheme
	source "$GIT_PROMPT_DIR/gitprompt.sh"
fi

