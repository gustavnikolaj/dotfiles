# Using VS Code as git editor when using the integrated terminal

If you run `export EDITOR=code` in the integrated terminal, VS Code will
correctly be used as the editor for that shell session - so e.g. your git
commits can be authored in vscode.

That is just a bit annoying to have to do on every new session or tab.

In order to get around it, I added the following configuration to my main
user-`settings.json` file in vscode.

```json
{
  //...
  "terminal.integrated.env.osx": {
    "GUSTAVNIKOLAJ_VSCODE": "yes"
  },
  "terminal.integrated.env.linux": {
    "GUSTAVNIKOLAJ_VSCODE": "yes"
  },
  // ...
}
```

That will make VS Code's integrated terminal set an environment variable in the
shells that it starts. I can then use that environment variable to conditionally
alter my EDITOR variable.

```bash
if ! [[ $GUSTAVNIKOLAJ_VSCODE == "" ]]; then
  export EDITOR="code --wait" ;
fi
```

For some reason, it does not work setting EDITOR directly in the vscode
settings.

### References

- [List of default settings](https://code.visualstudio.com/docs/getstarted/settings#_default-settings) (and available keys for the vscode settings file)