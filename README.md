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

If you want to learn more about the structure of this repository and how everything works together, check out [this article](https://shaky.sh/simple-dotfiles/) by [Andrew Burgess](https://www.youtube.com/@andrew-burgess)

## Installation

Installation is pretty simple, just clone this repository and run the `bootstrap.sh` script.

```shell
git clone https://github.com/Dan7n/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
zsh ./install/bootstrap.sh
```

What the `bootstrap.sh` script does is simlinking the configuration files to the directories where the applications expect them to be (that's defined in the `links.prop` file inside each configuration folder). This ensures that the configuration files remain under version control and can still do their job from where the applications expect them to be.

## Local ZSH Config

If there's customization you want ZSH to load on startup that is specific to this machine (stuff you don't want to commit into the repo), create ~/.env.sh and put it in there. It will be loaded near the top of .zshrc.
