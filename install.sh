#!/usr/bin/env bash
set -euo pipefail

DOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_SUFFIX="backup.$(date +%Y%m%d-%H%M%S)"

link_dotfile() {
  local source_path=$1
  local target_path=$2

  if [[ -L $target_path && $(readlink "$target_path") == "$source_path" ]]; then
    printf 'Already linked: %s\n' "$target_path"
    return
  fi

  if [[ -e $target_path || -L $target_path ]]; then
    local backup_path="${target_path}.${BACKUP_SUFFIX}"
    mv "$target_path" "$backup_path"
    printf 'Backed up %s to %s\n' "$target_path" "$backup_path"
  fi

  ln -s "$source_path" "$target_path"
  printf 'Linked %s -> %s\n' "$target_path" "$source_path"
}

install_shell_dependencies() {
  local packages=()
  command -v tmux >/dev/null 2>&1 || packages+=(tmux)
  command -v fzf >/dev/null 2>&1 || packages+=(fzf)
  ((${#packages[@]} == 0)) && return

  case "$(uname -s)" in
    Darwin)
      command -v brew >/dev/null 2>&1 || {
        echo "Homebrew is required to install: ${packages[*]}" >&2
        return 1
      }
      brew install "${packages[@]}"
      ;;
    Linux)
      sudo apt-get update
      sudo apt-get install -y "${packages[@]}"
      ;;
    *)
      echo "Install these packages manually: ${packages[*]}" >&2
      return 1
      ;;
  esac
}

install_shell_dependencies

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  command -v curl >/dev/null 2>&1 || {
    echo "curl is required to install Oh My Zsh" >&2
    exit 1
  }
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

link_dotfile "$DOT_DIR/zprofile" "$HOME/.zprofile"
link_dotfile "$DOT_DIR/zshrc" "$HOME/.zshrc"
link_dotfile "$DOT_DIR/gitconfig" "$HOME/.gitconfig"
link_dotfile "$DOT_DIR/tmux.conf" "$HOME/.tmux.conf"

mkdir -p "$HOME/.config/thefuck/rules"
for rule in "$DOT_DIR"/config/thefuck/rules/*; do
  [[ -e $rule ]] || continue
  link_dotfile "$rule" "$HOME/.config/thefuck/rules/$(basename "$rule")"
done

zsh_path="$(command -v zsh || true)"
if [[ -n $zsh_path && ${SHELL:-} != "$zsh_path" ]]; then
  printf 'To make zsh your default shell, run: chsh -s %q\n' "$zsh_path"
fi

echo "Dotfiles installed. Start a new shell with: exec zsh"
