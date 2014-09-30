if [ $UID -eq 0 ]; then ROOTPROMPT="%{$fg[red]%}%n%{$reset_color%}::"; fi

PROMPT='$ROOTPROMPT%{$fg[blue]%}%m%{$reset_color%} %{$fg[cyan]%}%c%{$fg[blue]%}$(check_git_prompt_info)%{$fg[blue]%}% %{$reset_color%}: '

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

# Git sometimes goes into a detached head state. git_prompt_info doesn't
# return anything in this case. So wrap it in another function and check
# for an empty string.
function check_git_prompt_info() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        if [[ -z $(git_prompt_info) ]]; then
            echo "%{$fg[magenta]%}detached-head%{$reset_color%})"
        else
            echo "$(git_prompt_info)"
        fi
    fi
}
