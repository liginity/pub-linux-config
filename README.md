# Public Linux Configuration Files

Linux configuration files used on public servers. Now very simple.

# structure

- `userhome/`

    dot files like `.vimrc`, `.bashrc`.

- `etc/` and so on

    files in /etc and so on.

- `administration-scripts/`

    simple configuration scripts. Run at one's own risk.

# How some configuration files come out

## generate `.clang-format`

```
clang-format-14 --style="{BasedOnStyle: google, IndentWidth: 4, SeparateDefinitionBlocks: Always, MaxEmptyLinesToKeep: 2}" --dump-config > .clang-format-14
```
