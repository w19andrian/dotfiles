##############################################
###                                        ###
###           General Config               ###
##############################################

# Alias

## Kubernetes
alias k="kubectl"
alias kx="kubectx"
alias kns="kubens"
alias kpf="kubectl port-forward"

## git
alias gcmm="git commit -m"
alias gadd="git add"
alias gchk="git checkout"
alias gsts="git status"

if (( $+commands[gcloud] )); then
	alias g="gcloud"
	alias glogin="gcloud auth login"
	alias gkls="gcloud container clusters list"
	alias gkx="gcloud container clusters get-credentials"
fi

setopt HASH_LIST_ALL

_cli_zsh_autocomplete() {

        local -a opts
        local cur
        cur=${words[-1]}
        if [[ "$cur" == "-"* ]]; then
		opts=("${(@f)$(_CLI_ZSH_AUTOCOMPLETE_HACK=1 ${words[@]:0:#words[@]-1} ${cur} --generate-bash-completion)}")
        else
		opts=("${(@f)$(_CLI_ZSH_AUTOCOMPLETE_HACK=1 ${words[@]:0:#words[@]-1} --generate-bash-completion)}")
        fi

        if [[ "${opts[1]}" != "" ]]; then
		_describe 'values' opts
        else
		_files
        fi

        return
}

export _zsh_addons_dir="${HOME}/.zsh/addons"
[[ ! -d "${_zsh_addons_dir}" ]] && mkdir -p "${_zsh_addons_dir}"

export _zsh_completions_dir="${_zsh_addons_dir}/completions"

profile_dir="${_zsh_addons_dir}/profiles"

os=$(uname | tr '[:upper:]' '[:lower:]')
if [[ "${os}" != "linux" && "${os}" != "darwin" ]]; then
	print "unkown operating system. Skip loading profile"
elif [[ -f "${profile_dir}/${os}" ]]; then
	source "${profile_dir}/${os}"
fi

# Adds _zsh_completions_dir/cache into fpath if exists
[[ -d "${_zsh_completions_dir}/cache" ]] && export fpath=("${_zsh_completions_dir}/cache" $fpath)

# Explicit kubeconfig location statement
export KUBECONFIG=$HOME/.kube/config

# Default editor
export EDITOR=nvim

# include extra dirs to PATH
export PATH=$HOME/.local/bin:$HOME/.scripts/bin:$PATH

# Go
## include GOPATH into PATH
export PATH=$HOME/go/bin:$PATH

## Go Toolchain settings. Recommended to set it auto here
## and set to the desired version in go.mod file in
## every project
export GOTOOLCHAIN=auto

# NVM(Node Version Manager) configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

bindkey -e

# Keybinding Ctrl+Shift+t for 'sesh' tmux session script
bindkey -s '^T' 'sesh\n'

# Rust related env vars
# export RUSTUP_HOME=
# export CARGO_HOME=

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Oh My Posh prompt
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/theme.wmp.json)"
#
# Load completion systems
[[ -f "${_zsh_completions_dir}/completion_systems" ]] && source "${_zsh_completions_dir}/completion_systems"

autoload -Uz compinit
compinit
