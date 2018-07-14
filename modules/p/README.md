# p

Bash function to jump around between projects.

## Installation

Source the [p.sh](./p.sh) file in your `.bashrc` file.

## Customization

You can customize which directory is used as the home of projects. By default
it is ~/Projects but you can change it to anything you want by setting the
`PROJECTS_DIR` environment variable.

```sh
export PROJECTS_DIR=~/code
```

## Usage

Given a folder structure of:

- ~/Projects
- ~/Projects/module-a
- ~/Projects/module-b

`p` allows you to jump to any project folder by name, from anywhere on the file
system.

```
~ $ p module-a
~/Projects/module-a $
```

It also supports fuzzy matching. It will select the shortest match.

```
~ $ p a
~/Projects/module-a $
```

You can put multiple phrases to search for:

```
~ $ p mod
~/Projects/module-a $ p mod b
~/Projects/module-b $
```

If you dont pass any arguments, or if `p` cannot find any matches, it will put
you into the `PROJECTS_DIR`.

```
~ $ p
~/Projects $
```

```
~ $ p something not matching any projects
~/Projects $
```

It also supports tab completion:

```
~ $ p mod
module-a   module-b
```

## Tips

### Automatically load the projects node version with
[nvm](https://github.com/creationix/nvm) when swapping to the project.

Put the following snippet in your .bashrc file:

```sh
load-nvmrc() {
    if [ -f .nvmrc ] ; then
        nvm use || nvm install
    elif [[ $(nvm version) != $(nvm version default) ]] ; then
        echo "nvm: Reverting to default node version."
        nvm use default
    fi
}

export PHOOK_CD=$PHOOK_CD:load-nvmrc
```

1. First we define a function called `load-nvmrc` which will load the
   appropriate node version from a `.nvmrc` file in the current working
   directory.
2. Then we export a `PHOOK_CD` environment variable and extend it with a
   reference to the `load-nvmrc` function.

If you want your shell to load the node version if started in a folder with a
`.nvmrc` file, you can call the load-nvmrc file just after defining it.


