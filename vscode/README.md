# Visual Studio Code settings and extensions

Running the `bootstrap.sh` will symlink the settings.json and extensions.json to the correct location for Visual Studio Code.

- Directory for settings.json: `~/Library/Application\ Support/Code/User/settings.json`
- Directory for extensions.json: `~/.vscode/extensions.json`

Opening VSCode, you _SHOULD_ be prompted to install the extensions listed in the extensions.json file (small popup on the lower left side), however I have not tested this yet..

If that doesn't work, run the following command to install the extensions listed in the extensions.json file:

```bash
bash install-extensions.sh
```
