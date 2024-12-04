Run tests of dotfile changes in a docker container.

First run the build script - that just has to be done once, and then again when
the `Docker` file is changed.

```
$ bash build.sh
```

Then you can start the test container by running the test script.

```
$ bash test.sh
```

... and once you are in the container, you just need to run the install script
and then either source .bashrc or start a new bash shell.

```
$ bash dotfiles/scripts/install-dotfiles.sh
$ source .bashrc
```
