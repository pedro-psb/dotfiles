# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi
unset rc

###############
# base config #
###############

# Default programs
export EDITOR="hx"

# XDG Base Directory specification
# https://specifications.freedesktop.org/basedir/latest/
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export ANSIBLE_HOME="$XDG_DATA_HOME"/ansible
export HISTFILE="${XDG_STATE_HOME}"/bash/history
export BOTO_CONFIG="${XDG_CONFIG_HOME}/gcloud/boto"
export DOTNET_CLI_HOME="$XDG_DATA_HOME"/dotnet
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GOPATH="$XDG_DATA_HOME"/go
export MINIKUBE_HOME="$XDG_DATA_HOME"/minikube
export MYPY_CACHE_DIR="$XDG_CACHE_HOME"/mypy
export NODE_REPL_HISTORY="$XDG_STATE_HOME"/node_repl_history
export NPM_CONFIG_INIT_MODULE="$XDG_CONFIG_HOME"/npm/config/npm-init.js
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME"/npm
export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR"/npm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
# export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel
export PSQL_HISTORY="$XDG_STATE_HOME/psql_history"
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/pythonrc
export PYTHON_HISTORY="$XDG_CONFIG_HOME"/python/history
export RBENV_ROOT="$XDG_DATA_HOME"/rbenv
export R_LIBS_USER="${XDG_DATA_HOME}"/R/x86_64-pc-linux-gnu-library
export R_HISTFILE="$XDG_CONFIG_HOME/R/history"
export RUFF_CACHE_DIR="$XDG_CACHE_HOME/ruff"
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export SQLITE_HISTORY="$XDG_CACHE_HOME"/sqlite_history
export TMUX_PLUGIN_MANAGER_PATH="$XDG_CONFIG_HOME/tmux/plugins/"
export VAGRANT_HOME="${XDG_DATA_DIR}/vagrant"
export CLAUDE_CONFIG_DIR="$XDG_CONFIG_HOME/claude"
export CLAUDE_CACHE_DIR="$XDG_CACHE_HOME/claude"

alias svn="svn --config-dir $XDG_CONFIG_HOME/subversion"
alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"


# Custom shell data
SCRIPTS_DIR="${XDG_CONFIG_HOME}/shell/scripts"
SHARED_ALIAS_FILE="$XDG_CONFIG_HOME/shell/alias"
SHARED_VARS_FILE="$XDG_CONFIG_HOME/shell/vars"
SHARED_SECRETS_FILE="$XDG_CONFIG_HOME/shell/secrets"

export PATH="$SCRIPTS_DIR:$PATH"
[ -f "$SHARED_ALIAS_FILE" ] && source "$SHARED_ALIAS_FILE"
[ -f "$SHARED_VARS_FILE" ] && source "$SHARED_VARS_FILE"
[ -f "$SHARED_SECRETS_FILE" ] && source "$SHARED_SECRETS_FILE"

# Bash specific
GITPROMPT_SETUP="$XDG_CONFIG_HOME/bash/git-prompt-setup.sh"
[ -f "$GITPROMPT_SETUP" ] && source "$GITPROMPT_SETUP"

############################
# program-specific configs #
############################

# claude
# export ANTHROPIC_MODEL='claude-sonnet-4'

# go
export PATH="$GOPATH/bin:$PATH"

# ruby
# https://stackoverflow.com/questions/10940736/rbenv-not-changing-ruby-version
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"

# pulp
alias ,oci-config="oci-env compose config | yq '.services.pulp.environment'"
alias ,oci-edit="hx ~/workspace/pulpdev/oci_env/compose.env"
alias pc="podman-compose"
alias lazypodman="DOCKER_HOST=unix:///run/user/4214970/podman/podman.sock lazydocker"
mkdir -p /tmp/pulp
export PATH="$HOME/projects/pulp/scripts:$PATH"
export PULP_FILE_UPLOAD_TEMP_DIR=/tmp/pulp/
export PULP_WORKING_DIRECTORY=/tmp/pulp/
export PULP_DB_ENCRYPTION_KEY=$HOME/projects/pulp/scripts/assets/database_fields.symmetrics.key
source "$HOME/projects/pulp/scripts/pulp-utils.sh"
eval "$(LC_ALL=C _PULP_COMPLETE=bash_source pulp)"

# rust
export PATH="$CARGO_HOME/bin:$PATH"
source "$CARGO_HOME/env"

# zoxide
eval "$(zoxide init bash)"

# vagrant
. /opt/vagrant/embedded/gems/gems/vagrant-2.4.9/contrib/bash/completion.sh

# virsh
# https://serverfault.com/questions/803283/how-do-i-list-virsh-networks-without-sudo
export LIBVIRT_DEFAULT_URI=qemu:///system

# java
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk

# lima
source <(limactl completion bash)

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
