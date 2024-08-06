alias be-productive="python3 /Users/danny.isaac/Documents/Code/_personal/prod-faker-main/prod-faker.py"
# alias fcd="cd $(find . -type d -print | fzf)" # fuzzy find with cd
eval "$(oh-my-posh init zsh --config /Users/danny.isaac/.oh-my-posh-config/themes/catppuccin_frappe.omp.json)"
eval "$(zoxide init zsh)"
source <(fzf --zsh)
eval "$(thefuck --alias)" # set "fuck" as the alias to thefuck CLI tool which auto-fixes your last command

# bun completions
[ -s "/Users/danny.isaac/.bun/_bun" ] && source "/Users/danny.isaac/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
###-begin-grond-completions-###
#
# yargs command completion script
#
# Installation: grond completion >> ~/.zshrc
#    or grond completion >> ~/.zsh_profile on OSX.
#
_grond_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" grond --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _grond_yargs_completions grond
###-end-grond-completions-###

###-begin-grond-completions-###
#
# yargs command completion script
#
# Installation: /opt/homebrew/bin/grond completion >> ~/.zshrc
#    or /opt/homebrew/bin/grond completion >> ~/.zsh_profile on OSX.
#
_grond_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" /opt/homebrew/bin/grond --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _grond_yargs_completions grond
###-end-grond-completions-###

###-begin-grond-completions-###
#
# yargs command completion script
#
# Installation: /opt/homebrew/bin/grond completion >> ~/.zshrc
#    or /opt/homebrew/bin/grond completion >> ~/.zsh_profile on OSX.
#
_grond_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" /opt/homebrew/bin/grond --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _grond_yargs_completions grond
###-end-grond-completions-###

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
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

function fh() {
    eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}
alias fh=fh

alias docker-compose='docker compose'

GOPATH=$HOME/go
PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
###-begin-grond-completions-###
#
# yargs command completion script
#
# Installation: /opt/homebrew/bin/grond completion >> ~/.zshrc
#    or /opt/homebrew/bin/grond completion >> ~/.zsh_profile on OSX.
#
_grond_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" /opt/homebrew/bin/grond --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _grond_yargs_completions grond
###-end-grond-completions-###

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