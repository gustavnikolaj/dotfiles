# dotfiles

My personal dotfiles. Use at your own risk! I personally use these dotfiles
across a linux laptop, a windows desktop and a macbook and have done so for
years - so they are widely supported and well tested. But I might break them
or change the way they function with no regard to anyone else using it.

A few bits of it has been separated into easy to consume modules which is
listed out below.

## Sharable modules

- [p.sh](./modules/p): Bash function to jump around between projects.
- [p-load-nvmrc](./modules/p-load-nvmrc): Load the defined node version when using `p`.
- [scratch](./modules/scratch): Bash function to create and navigate scratchpad-folders.
- [prompt](./modules/prompt): Bash prompt.

## Tips

- [Use VS Code as the $EDITOR from the integrated shell](./vscode-as-git-editor.md)

## Installation

Clone this repo into a folder named dotfiles in your home directory.

```
$ git clone git@github.com/gustavnikolaj/dotfiles.git $HOME/dotfiles
```

After cloning it, run the install script:

```
$ bash $HOME/dotfiles/scripts/install-dotfiles.sh
```

That will install dependencies and symlink in the relevant files.

## Implementation Notes

A select few files are symlinked to the home directory, such as `.bashrc` and
`.inputrc`.

My bash setup is modularized and there are two ways that I load things. Either
explicitly, by sourcing files directly - such as the modularized bits in the
modules folder - or automatically. Automatic loading is based on the convention
that any files in the `$HOME/dotfiles` directory with a name matching
`*.bashrc.sh` will be loaded.

