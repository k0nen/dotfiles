
# Personal alias
alias vi="vim"
alias python="python3"
alias pythondebug="python3 -m pdb -c continue"
alias pip="pip3"
alias clipboard="tee >(pbcopy)"

alias hist="history" # show history
alias gpt="sgpt -s" # shell-gpt
alias shit="fuck" # thefuck

# Set timezone
export TZ="UTC-9"

# Don't share command history across tmux windows/panes
setopt nosharehistory

# https://stackoverflow.com/questions/20512957/zsh-new-line-prompt-after-each-command
function precmd() {
    # Print a newline before the prompt, unless it's the
    # first prompt in the process.
    if [ -z "$NEW_LINE_BEFORE_PROMPT" ]; then
        NEW_LINE_BEFORE_PROMPT=1
    elif [ "$NEW_LINE_BEFORE_PROMPT" -eq 1 ]; then
        echo ""
    fi
}

# Simple username
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi
}

# Simple walltime command
walltime() {
    if [ -z "$1" ]; then
        echo "Usage: walltime [PID]"
        return 1
    fi
    ps -p $1 -o etime
}

# CUDA_VISIBLE_DEVICES aliases
alias CVD01='CUDA_VISIBLE_DEVICES=0,1'
alias CVD23='CUDA_VISIBLE_DEVICES=2,3'
alias CVD45='CUDA_VISIBLE_DEVICES=4,5'
alias CVD67='CUDA_VISIBLE_DEVICES=6,7'
alias CVD0='CUDA_VISIBLE_DEVICES=0'
alias CVD1='CUDA_VISIBLE_DEVICES=1'
alias CVD2='CUDA_VISIBLE_DEVICES=2'
alias CVD3='CUDA_VISIBLE_DEVICES=3'
alias CVD4='CUDA_VISIBLE_DEVICES=4'
alias CVD5='CUDA_VISIBLE_DEVICES=5'
alias CVD6='CUDA_VISIBLE_DEVICES=6'
alias CVD7='CUDA_VISIBLE_DEVICES=7'

# pwnvm related command

pwnvm() {
  if [[ $1 == "copy" ]]; then
    local tmpdir="pwn_$(date +%Y%m%d_%H%M%S)"  # Create a unique temporary directory name
    local remote_dir="~/ctf/$tmpdir"            # Remote directory path

    if [[ -n $2 ]]; then
      scp -r $2 k0nen@pwnvm:"$remote_dir"
      echo $remote_dir | clipboard
    else
      echo "Usage: pwnvm copy [path]"
    fi
  elif [[ $1 == "shell" ]]; then
    ssh pwnvm
  else
    echo "Usage: pwnvm [copy|shell]"
  fi
}

pwnconvert () {
  # Set the input variable to $3 if it exists, otherwise default to "s"
  local input_var="${2:-s}"

  if [[ $1 == "char2char" ]]; then
    echo "$input_var" | clipboard
  elif [[ $1 == "char2hex" ]]; then
    echo "$input_var.hex().encode()" | clipboard
  elif [[ $1 == "char2dec" ]]; then
    echo "str($input_var[0]).encode()" | clipboard
  elif [[ $1 == "char2int" ]]; then
    echo "$input_var[0]" | clipboard
  elif [[ $1 == "hex2char" ]]; then
    echo "bytes.fromhex($input_var.decode())" | clipboard
  elif [[ $1 == "hex2hex" ]]; then
    echo "$input_var" | clipboard
  elif [[ $1 == "hex2dec" ]]; then
    echo "str(int($input_var.decode(), 16)).encode()" | clipboard
  elif [[ $1 == "hex2int" ]]; then
    echo "int($input_var.decode(), 16)" | clipboard
  elif [[ $1 == "dec2char" ]]; then
    echo "int($input_var.decode()).to_bytes(1, 'big')" | clipboard
  elif [[ $1 == "dec2hex" ]]; then
    echo "hex(int($input_var.decode()))[2:].encode()" | clipboard
  elif [[ $1 == "dec2dec" ]]; then
    echo "$input_var" | clipboard
  elif [[ $1 == "dec2int" ]]; then
    echo "int($input_var.decode())" | clipboard
  elif [[ $1 == "int2char" ]]; then
    echo "$input_var.to_bytes(1, 'big')" | clipboard
  elif [[ $1 == "int2hex" ]]; then
    echo "hex($input_var)[2:].encode()" | clipboard
  elif [[ $1 == "int2dec" ]]; then
    echo "str($input_var).encode()" | clipboard
  elif [[ $1 == "int2int" ]]; then
    echo "$input_var" | clipboard
  else
    echo "Usage: pwnconvert [char|hex|dec|int]2[char|hex|dec|int] optional_in_var"
  fi
}

if [[ $(hostname) == "pwnvm" ]]; then
  pwnhost() {
    socat TCP-LISTEN:9999,bind=192.168.64.2,reuseaddr,fork EXEC:$1,stderr
  }
fi

