#Tmux

1. Install tmux from [this link](https://github.com/tmux/tmux/wiki/Installing)
2. Install TPM (tmux package manager) from their [Github repository](https://github.com/tmux-plugins/tpm)
3. Start the tmux server by opening a terminal and typing `tmux`
4. Install the packages that are listed in your `.tmux.conf` file by pressing `Prefix + I`

## IMPORTANT NOTICE FOR MACOS USERS

If you use something other than C-Space as your tmux leader key then you can stop reading.
For some reason, macOs captures the Ctrl+Space key combination in terminal emulators and uses it for switching input sources, so if you use that key combo you need to disable that behaviour in system settings by going to:

System Preferences -> Keyboard -> Shortcuts -> Input Sources, and then disable both shortcuts in there
