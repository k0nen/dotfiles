# dotfiles

## How to setup
- Copy or pull this repo inside new system
- `bash install.sh`
- `source ~/.zshrc`

## zsh
- Alias `hist` for `history`
- Set timezone to Asia/Seoul
- tmux window/panes don't share history
- Blank line after every command
- Simplified username
- `walltime [PID]` command
- [The Fuck](https://github.com/nvbn/thefuck)
- `pythondebug = python3 -m pdb -c continue`
- `clipboard = tee >(pbcopy)` (Works on Mac only, but anyway)
- `boj` commands
  - `boj run [id]` will compile and run `[id].cpp`
  - `boj create [id]` will copy `template.cpp` into `[id].cpp`
- `pwnvm` commands
  - `pwnvm copy [path]` will copy path to vm, and save path in clipboard
  - `pwnvm shell` will open a ssh connection to the vm
- `pwnconvert` commands
  - `pwnconvert dec2int foo` will output `int(foo.decode())` and copy to clipboard.

## git
- `log1 10` shows 10 recent commits
- `cm = commit -m`
- `br = checkout -b`
- `append = commit --amend --no-edit`

## tmux
- Default shell to `/bin/zsh`
- Current command is shown on the bottom of each pane
- Mouse control

## TODOs
- vi default tabs to 4
