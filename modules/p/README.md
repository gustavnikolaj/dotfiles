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


