# scratch

Bash function to jump to quickly create a temporary directory for an
experiment.

## Installation

Source the [scratch.sh](./scratch.sh) file in your `.bashrc`.

## Customization

You can customize which directory is used as the home of the experiment
folders. By default it is `~/Scratch`, but you can change it to anything you
want by setting the `SCRATCH_DIR` environment variable.

```sh
export SCRATCH_DIR=~/experiments
```

### Usage

In general, this module works like [p.sh](../p) with the exception that folders
that could not be matched to any preexisting one will be created instead.

Given a folder structure of:

- ~/Scratch
- ~/Scratch/my-experiment
- ~/Scratch/my-other-experiment

`scratch` allows you to jump to any existing folder within the Scratch folder.

```
~ $ scrach my-experiment
~/Scratch/my-experiment $
```

If no such experiment exists, it will create the directory for you.

```
~ $ scratch new-stuff
~/Scratch/new-stuff $
```

It will however attempt to find a similarly named projects by fuzzy matching
your input:

```
~ $ scrach my
~/Scratch/my-experiment $
```

It also supports tab completion:

```
~ $ scratch my
my-experiment   my-other-experiment
```
