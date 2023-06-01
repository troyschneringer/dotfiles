export CLICOLOR=1
export TERM=xterm

# Configure GOPATH
export GOPATH="$HOME/Source/go"
if [[ -d "$GOPATH" ]]; then
    export PATH="$PATH:$GOPATH/bin"
fi

git_base_path=""
if [ ! -z $(which brew) ]; then
    git_base_path="$(brew --prefix git)"
fi
bash_completion_path="${git_base_path}/etc/bash_completion.d"

# Configure Git bash prompt
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWCOLORHINTS=true
export GIT_PS1_SHOWUPSTREAM=true
if [ -f "${bash_completion_path}/git-prompt" ]; then
    source "${bash_completion_path}/git-prompt"
elif [ -f "${bash_completion_path}/git-prompt.sh" ]; then
    source "${bash_completion_path}/git-prompt.sh"
else
    echo -e "Warning: Git bash prompt script not found!"
fi

# Configure Git completion
if [ -f "${bash_completion_path}/git-completion" ]; then
    source "${bash_completion_path}/git-completion"
elif [ -f "${bash_completion_path}/git-completion.bash" ]; then
    source "${bash_completion_path}/git-completion.bash"
else
    echo -e "Warning: Git bash completion script not found!"
fi

# Configure gcloud prompt
if [[ -d "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk" ]]; then
	source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc'
    source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'
fi


export FONTAWESOME=0
if [[ ! -z $(which fc-list) ]]; then
    fc-list | grep fontawesome &>/dev/null
    if [[ $? == 0 ]]; then
        export FONTAWESOME=1
    fi
elif [[ -d $HOME/Library/Fonts ]]; then
    if [[ -f $HOME/Library/Fonts/FontAwesome.otf ]]; then
        export FONTAWESOME=1
    fi
fi

set_prompt() {
	local last_cmd=$?
	local bg_blue='$(tput setab 4)'
	local term_reset='$(tput sgr0)'
	local text_bold='$(tput bold)'
	local text_dim='$(tput dim)'
	local text_black='$(tput setaf 0)'
	local text_red='$(tput setaf 1)'
	local text_green='$(tput setaf 2)'
	local text_yellow='$(tput setaf 3)'
	local text_blue='$(tput setaf 4)'
	local text_purple='$(tput setaf 5)'
	local text_cyan='$(tput setaf 6)'
	local text_white='$(tput setaf 7)'
    local char_git=''
    local char_prompt='>'

    if [[ $FONTAWESOME == 1 ]]; then
        char_git=''
        char_prompt=''
    fi
	
	local git_dirty=0
	git diff-index --quiet HEAD &>/dev/null
	if [[ $? != 0 ]]; then
		git_dirty=1
	fi

	PS1="\n"
	PS1+="\[$text_cyan\]\w\[$term_reset\]"

    local git_ps1_text=$(__git_ps1 "%s" 2>&1)
	
	if [[ ! -z $git_ps1_text ]]; then
		if [[ $git_dirty == 0 ]]; then
			PS1+="\[$text_dim\]\[$text_green\]"
		else
			PS1+="\[$text_dim\]\[$text_red\]"
		fi

		PS1+=" $char_git  [ \[$git_ps1_text\] ]\[$term_reset\]"
	fi

	PS1+="\n"

	if [[ $last_cmd != 0 ]]; then
		PS1+="\[$text_dim\]\[$text_yellow\]warning: last exit code was $last_cmd\[$term_reset\]\n"
	fi

	if [[ $EUID == 0 ]]; then
		PS1+="\[$text_dim\]\[$text_white\][\[$text_bold\]\[$text_red\]root\[$text_dim\]\[$text_white\]]\[$term_reset\] "
	fi

	PS1+="\[$text_dim\]\[$text_white\]$char_prompt \[$term_reset\]"
}

export -fn set_prompt
export PROMPT_COMMAND='set_prompt'

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export PATH="$HOME/.yarn/bin:$PATH"