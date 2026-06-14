# dotfiles

The actively maintained branch is `2024-refine`. The repository's remote
default branch is still `main`, so select the active branch explicitly when
cloning:

```sh
git clone --branch 2024-refine git@github.com:k0nen/dotfiles.git ~/Documents/dotfiles
cd ~/Documents/dotfiles
bash install.sh
exec zsh
```

The installer creates symlinks for:

- `~/.zprofile` -> `zprofile`
- `~/.zshrc` -> `zshrc`
- `~/.gitconfig` -> `gitconfig`
- `~/.tmux.conf` -> `tmux.conf`
- custom `thefuck` rules

Existing files are moved to timestamped backups before linking. The script can
be rerun safely and derives the repository location from its own path, not from
the current working directory.

## Shell configuration

`zprofile` owns login-shell environment setup: Homebrew, PATH entries, and the
timezone. `zshrc` owns interactive behavior: Oh My Zsh, Agnoster, aliases,
functions, completions, fzf, thefuck, and NVM.

### Where should a change go?

Use this quick guide:

| Change | Put it in |
| --- | --- |
| Alias, shell function, prompt, completion, or key binding used on every machine | `zshrc` |
| PATH entry, environment variable, Homebrew initialization, or login-shell setup used on every machine | `zprofile` |
| Git alias or Git behavior | `gitconfig` |
| tmux key binding or tmux behavior | `tmux.conf` |
| Custom correction for `thefuck` | `config/thefuck/rules/` |
| Package installation, symlink, or first-time machine setup | `install.sh` |
| Machine-specific alias, experiment, or interactive override | `~/.zshrc.local` |
| Machine-specific path or environment variable | `~/.zprofile.local` |
| Password, API key, token, or other secret | An untracked local file or password manager, never this repository |

As a rule: commit settings that should follow you to every machine. Put settings
that depend on one machine, contain secrets, or are still experimental in the
corresponding `.local` file.

Keep machine-specific values, credentials, and experiments outside Git:

```sh
# ~/.zprofile.local: machine-specific environment
export EXAMPLE_HOME="/machine/specific/path"

# ~/.zshrc.local: interactive overrides
alias example="example --flag"
```

Both local files are sourced automatically when present.

## Included commands

- `hist`: show shell history
- `pythondebug`: run Python under pdb
- `clipboard`: pipe output to the macOS clipboard
- `walltime PID`: show process elapsed time
- `boj run ID` and `boj create ID`
- `pwnvm copy PATH` and `pwnvm shell`
- `pwnconvert`: build Python conversion expressions
- CUDA device aliases such as `CVD0` and `CVD01`

The shell config initializes optional tools only when installed. The installer
handles `tmux` and `fzf`; install `shell-gpt`, `thefuck`, NVM, and other
language runtimes separately as needed.

## Updating

```sh
cd ~/Documents/dotfiles
git switch 2024-refine
git pull --ff-only
exec zsh
```

Because the home files are symlinks, pulled changes apply immediately to new
shells.
