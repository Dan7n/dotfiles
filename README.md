```
██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║
╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝
```

Simple repository to store the configuration files I use for my development environment/workflow.
Some of the configurations here are based on other repositories, others are my own. Feel free to fork this repository or copy/paste anything you find useful.

This repository uses the incredibly useful open source symlink farm manager [GNU Stow](https://www.gnu.org/software/stow/) to create symlinks between the config files/directories located in this repository and where the applications that use these config files expect them to be in the filesystem. The benefit of symlinking files this way is that any changes you make to the config file - be it here in this repository or where the config file is linked to in the filesystem - will be reflected here. So you'll always have one source of truth that you can version-control in Git and keep up to date.

## Installation

First off, you'll need to install GNU Stow on your system. If you're on MacOS, you can use Homebrew:

```bash
brew install stow
```

Now clone this respotory to your home directory and `cd` into it:

```bash
git clone https://github.com/Dan7n/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

Next you can simply use the `stow` command followed by the name of the directories that contain the config files.

```bash
stow kitty nvim skhd tmux vim wezterm zsh
```
