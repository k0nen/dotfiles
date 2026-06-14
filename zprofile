# Environment for login shells.

# Initialize Homebrew before adding formula-specific paths.
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

typeset -U path PATH

if [[ -n ${HOMEBREW_PREFIX:-} ]]; then
  for candidate in \
    "$HOMEBREW_PREFIX/opt/tcl-tk/bin" \
    "$HOMEBREW_PREFIX/opt/ruby/bin"; do
    [[ -d $candidate ]] && path=("$candidate" $path)
  done
fi

for candidate in \
  "$HOME/Library/Python/3.9/bin" \
  "$HOME/.local/bin"; do
  [[ -d $candidate ]] && path=("$candidate" $path)
done

export TZ="Asia/Seoul"

# Machine-specific environment and secrets belong here, outside Git.
[[ -r "$HOME/.zprofile.local" ]] && source "$HOME/.zprofile.local"
