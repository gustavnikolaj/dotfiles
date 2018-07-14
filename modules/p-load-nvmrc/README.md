# Load the projects node version with when swapping to the project

Automatically loads the configurated node version through
[nvm](https://github.com/creationix/nvm) when navigating to a project using
[p.sh](../p).

## Installation

Source the [p-load-nvmrc.sh](./p-load-nvmrc.sh) file in your `.bashrc` file.

You must also have [p.sh](../p) installed.

## Usage

When you navigato to a project using `p` it will look for a `.nvmrc` file in
the given project and load the corresponding node version using `nvm`.

```
 ~ $ p my-project
Found '~/Projects/my-project/.nvmrc' with version <8.11.1>
Now using node v8.11.1 (npm v5.6.0)
 my-project $
```

## Tip: Load the appropriate node-version when opening a new shell

If you want your shell to load the node version if started in a folder with a
`.nvmrc` file, you can call the load-nvmrc file just after sourcing it in your
`.bashrc`. That will change the node version if a `.nvmrc` is found.

```sh
source p-load-nvmrc.sh
load-nvmrc
```

My terminal emulator is configured to open a new terminal in the same directory
as the active terminal is currently in. By putting that inline call to
`load-nvmrc` in my `.bashrc` I don't need to manually call `nvm use` whenever I
open a new tab.
