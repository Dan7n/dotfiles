source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh # loads the zsh-autosuggestions plugin - https://github.com/zsh-users/zsh-autosuggestions/tree/master
source <(fzf --zsh)

ADMIN_USER="dannyisaac"
alias be-productive="source $HOME/Code/Personal/productivity/productivity-env/bin/activate && python3 $HOME/Code/Personal/productivity/prod-faker.py"
eval "$(oh-my-posh init zsh --config /Users/$ADMIN_USER/.oh-my-posh-config/themes/peru.omp.json)"
eval "$(zoxide init zsh)"
eval "$(thefuck --alias)" # set "fuck" as the alias to thefuck CLI tool which auto-fixes your last command

# bun completions
# [ -s "/Users/$ADMIN_USER/.bun/_bun" ] && source "/Users/$ADMIN_USER/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

PATH=~/.console-ninja/.bin:$PATH

alias src='source ~/.zshrc'
alias int='nvim $(fzf --preview="bat --color=always {}")' # fuzzy find and open file with nvim
alias cint='code $(fzf --preview="bat --color=always {}")' # fuzzy find and open file with vscode
alias hist='echo $(history 1 | cut -c 8- | fzf)'
alias git-log='git log --all --decorate --oneline --graph'
alias c='clear'

alias cd='z' # replace the native cd command with zoxide which offers caching and fzf integration 
alias ls="eza --icons=always --long --color=always" # replaces ls with eza, which is a better version
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias zz="zellij"

function fh() {
    eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}
alias fh=fh

alias docker-compose='docker compose'

GOPATH=$HOME/go
PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# =============================================================================
#
# Utility functions for zoxide.
#

# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd() {
    \builtin pwd -L
}

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd() {
    # shellcheck disable=SC2164
    \builtin cd -- "$@"
}

# =============================================================================
#
# Hook configuration for zoxide.
#

# Hook to add new entries to the database.
function __zoxide_hook() {
    # shellcheck disable=SC2312
    \command zoxide add -- "$(__zoxide_pwd)"
}

# Initialize hook.
# shellcheck disable=SC2154
if [[ ${precmd_functions[(Ie)__zoxide_hook]:-} -eq 0 ]] && [[ ${chpwd_functions[(Ie)__zoxide_hook]:-} -eq 0 ]]; then
    chpwd_functions+=(__zoxide_hook)
fi

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

# Jump to a directory using only keywords.
function __zoxide_z() {
    # shellcheck disable=SC2199
    if [[ "$#" -eq 0 ]]; then
        __zoxide_cd ~
    elif [[ "$#" -eq 1 ]] && { [[ -d "$1" ]] || [[ "$1" = '-' ]] || [[ "$1" =~ ^[-+][0-9]$ ]]; }; then
        __zoxide_cd "$1"
    else
        \builtin local result
        # shellcheck disable=SC2312
        result="$(\command zoxide query --exclude "$(__zoxide_pwd)" -- "$@")" && __zoxide_cd "${result}"
    fi
}

# Jump to a directory using interactive search.
function __zoxide_zi() {
    \builtin local result
    result="$(\command zoxide query --interactive -- "$@")" && __zoxide_cd "${result}"
}

# =============================================================================
# Cheatsheets

alias tmux-kb="bat ~/cheatsheets/tmux/keybindings.md" 


# =============================================================================

# =============================================================================
#
# Commands for zoxide. Disable these using --no-cmd.
#

function cd() {
    __zoxide_z "$@"
}

function cdi() {
    __zoxide_zi "$@"
}

# Completions.
if [[ -o zle ]]; then
    __zoxide_result=''

    function __zoxide_z_complete() {
        # Only show completions when the cursor is at the end of the line.
        # shellcheck disable=SC2154
        [[ "${#words[@]}" -eq "${CURRENT}" ]] || return 0

        if [[ "${#words[@]}" -eq 2 ]]; then
            # Show completions for local directories.
            _files -/
        elif [[ "${words[-1]}" == '' ]]; then
            # Show completions for Space-Tab.
            # shellcheck disable=SC2086
            __zoxide_result="$(\command zoxide query --exclude "$(__zoxide_pwd || \builtin true)" --interactive -- ${words[2,-1]})" || __zoxide_result=''

            # Bind '\e[0n' to helper function.
            \builtin bindkey '\e[0n' '__zoxide_z_complete_helper'
            # Send '\e[0n' to console input.
            \builtin printf '\e[5n'
        fi

        # Report that the completion was successful, so that we don't fall back
        # to another completion function.
        return 0
    }

    function __zoxide_z_complete_helper() {
        if [[ -n "${__zoxide_result}" ]]; then
            # shellcheck disable=SC2034,SC2296
            BUFFER="cd ${(q-)__zoxide_result}"
            \builtin zle reset-prompt
            \builtin zle accept-line
        else
            \builtin zle reset-prompt
        fi
    }
    \builtin zle -N __zoxide_z_complete_helper

    [[ "${+functions[compdef]}" -ne 0 ]] && \compdef __zoxide_z_complete cd
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/Users/dannyisaac/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export CHEAT_CONFIG_PATH="~/.config/cheat/conf.yml"
export CHEAT_USE_FZF=true
export XDG_CONFIG_HOME="$HOME/.config" # change default config dir for lazygit

export EDITOR=nvim
export VISUAL=nvim

neofetch
