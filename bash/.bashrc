source ~/.local/share/omakub/defaults/bash/rc

# eval "$(thefuck --alias)" # set "fuck" as the alias to thefuck CLI tool which auto-fixes your last command

# Editor used by CLI
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
. "$HOME/.cargo/env"

# ----- ALIASES -----
alias src='source ~/.bashrc'
alias git-log='git log --all --decorate --oneline --graph'
alias c='clear'

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

eval "$(starship init bash)"

# pnpm
export PNPM_HOME="/home/danny-isaac/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

PATH=~/.console-ninja/.bin:$PATH