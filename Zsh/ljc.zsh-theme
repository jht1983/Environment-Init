# vim:ft=zsh ts=2 sw=2 sts=2

PROMPT='
${_user_host} ${_current_dir} ${_time}
${_return_status}$(prompt_char)%{$reset_color%} '

PROMPT2='%{$fg[yellow]%}>%{$reset_color%} '

RPROMPT='%{$(echotc UP 1)%}$(git_prompt_info) $(_git_time_since_commit)$(git_prompt_status)%{$(echotc DO 1)%}'

local _user_host="%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%}%n%{$reset_color%}%{$fg[green]%}@%{$fg_bold[green]%})%m%{$reset_color%}"
local _current_dir="%{$fg_bold[blue]%}%10~%{$reset_color%}"
local _time="%{$fg_bold[magenta]%}⌚ %*%{$reset_color%}"
local _return_status="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})"

function prompt_char() {
    echo ➜
    # if [ $UID -eq 0 ]; then echo "#"; else echo $; fi
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✗ "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✔ "

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚ "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}M "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖ "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}R "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}U "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[white]%}◒ "

# Colors vary depending on time lapsed.
ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="green"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="yellow"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="red"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="white"

function _git_time_since_commit() {
    # Only proceed if there is actually a commit.
    if git log -1 > /dev/null 2>&1; then
        last_commit=$(git log --pretty=format:'%at' -1 2> /dev/null)
        now=$(date +%s)

        seconds_since_last_commit=$((now-last_commit))
        minutes=$((seconds_since_last_commit / 60))
        hours=$((seconds_since_last_commit / 3600))
        days=$((seconds_since_last_commit / 86400))
        sub_minutes=$((minutes % 60))

        if [ $hours -gt 24 ]; then
            commit_age="${days}d"
            _color=$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG
        elif [ $minutes -gt 60 ]; then
            commit_age="${hours}h ${sub_minutes}m"
            _color=$ZSH_THEME_GIT_TIME_SINCE_COMMIT_MEDIUM
        else
            commit_age="${minutes}m"
            _color=$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT
        fi

        if [ $(git status --short | wc -c) -eq 0 ]; then
            _color=$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL
        fi
        echo "%{$fg[$_color]%}$commit_age %{$reset_color%}"
    fi
}

export GREP_COLOR='1;33'
