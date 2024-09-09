# p2

New experimental take on the p module

## Difference from the original

Use a hierarchical folder structure instead of a flat one. Naming conflicts
using the naming scheme `~/Projects/<git-repo-name>` happened more often than
one might think.

New structure using a dir named `Projects2` would for this repo be:
`~/Projects2/github.com/gustavnikolaj/dotfiles`.

Use would be similar to before:

```
p dotfi
```

Would find the best match, prioritising the basename, then the "parent folder names" in reverse order. Again using this repo as an example, it would look for a match in the following order:

- dotfiles
- gustavnikolaj
- github.com

## Q&A

### Why is it a sourced bash file and not a script?

You cannot change the directory of the parent shell from a script. This is the
entire idea of the `p`-script, and unfortunately there's no other way we can do
it. Having a script would be less intrusive and thus better, but it's not an
option.
