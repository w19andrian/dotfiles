
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

# define addons directory; create an empty directory if it doesn't exist
export _zsh_addons_dir="${HOME}/.${USER}_zsh_addons"
[[ ! -d "${_zsh_addons_dir}" ]] && mkdir -p "${_zsh_addons_dir}"

profile_dir="${_zsh_addons_dir}/profiles"
os=$(uname | tr '[:upper:]' '[:lower:]')

if [[ "${os}" != "linux" && "${os}" != "darwin" ]]; then
	print "unkown operating system. Skipping profile loading"
elif [[ -f "${profile_dir}/${os}" ]]; then
	source "${profile_dir}/${os}"
fi

# Enable and initialize the Zsh completion system
export _zsh_completion_systems="${_zsh_addons_dir}/completion_systems"
[[ -d "${_zsh_completion_systems}" ]] && fpath=("${_zsh_completion_systems}" $fpath)

autoload -Uz compinit
compinit

# 1Password zsh completion
eval "$(op completion zsh)"; compdef _op op

# Default editor
export EDITOR=nvim

# include scripts dir into PATH
export PATH=$HOME/.scripts/bin:$PATH

# include GOPATH into PATH
export PATH=/home/wmp/go/bin:$PATH

# Explicit kubeconfig location statement
export KUBECONFIG=~/.kube/config

# NVM(Node Version Manager) configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Starship prompt
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
eval "$(starship init zsh)"

bindkey -e

# Keybinding Ctrl+Shift+t for 'sesh' tmux session script
bindkey -s '^T' 'sesh\n'

export GOTOOLCHAIN=auto

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

