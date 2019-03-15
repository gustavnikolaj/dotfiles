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
~ $ git clone git@github.com/gustavnikolaj/dotfiles.git
```

After cloning it, run the install script:

```
~ $ ./dotfiles/scripts/install
```

That will install dependencies and symlink in the relevant files.

## Conventions

- Files named `*.bashrc.sh` will be sourced by the main `.bashrc` file at load
  time.
- Files named `*.symlink.sh` will be symlinked into the home directory as a dot
  file at install time (when running the install script). E.g.
  `bashrc.symlink.sh -> ~/.bashrc`.
