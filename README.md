# Dotfiles repo

## Dependencies:

- GNU stow

## Usage:

- Clone to `~/dotfiles`.
- run `stow foldername` to create symlinks to the files in `~` .

## Stow with automatic backup

Sometimes when using stow on a previously non-stowed computer, you will get conflicts when attempting to stow in your config files. To solve that issue I wrote a simple script in the file `stowbackup`. If you run `stow git` and get conflicts, run `./stowbackup git`.

What the stowbackup script does:
1. Attempt to stow the given module name.
2. If it fails, the script will move the conflicting files to a folder within the repo called \_backup, in a subfolder with the name of the module. If you run `./stowbackup git` it will thus move conflicting files to `\_backup/git`. If it already has a backup for the same module it will name the directory module.X where X is an integer.
3. Attempt to run stow again.
