# dotfiles

## How to setup

- Copy or pull this repository inside docker
- Run `install.sh`
- `source ~/.zshrc`

## git

- `log1 = log --oneline`
- `cm = commit -m`
- `br = checkout -b`

## tmux

- Default shell to `/bin/zsh`
- Current command is shown on the bottom of each pane
- Mouse control

## zsh

- Alias `hist` for `history`
  - Set timezone to Asia/Seoul
  - tmux window/pane doesn't share history
- Blank line after every command
- [The Fuck](https://github.com/nvbn/thefuck)

### Custom commands

#### `venv`

List all venvs inside directory specified by `VENV_DIR` (saved inside zshrc)

- `venv ls` to list all venvs
- `venv [env_name]` to activate venv

#### `walltime`

Show the wall-clock time of a process.
I made this command because CPU time is measured as the total CPU time of all cores, which isn't informative to me.

- `walltime [PID]`
