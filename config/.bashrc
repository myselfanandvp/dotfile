#!/usr/bin/env bash
case $- in
*i*) ;;
*) return ;;
esac

# ---- History settings ----
HISTSIZE=10000
HISTFILESIZE=20000
HISTTIMEFORMAT="%F %T "
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
# Append to history after every command, not just on shell exit,
# so history is shared correctly across multiple open terminals.
PROMPT_COMMAND="history -a${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
export HISTTIMEFORMAT HISTCONTROL
shopt -s checkwinsize

# ---- Starship prompt ----
if command -v starship &>/dev/null; then
  eval "$(starship init bash)"
fi

# ---- Man page formatting (safe fallback) ----
if command -v bat &>/dev/null; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
else
  export MANPAGER="less"
fi
export MANROFFOPT="-c"

# Load user profile if it exists.
# Guarded against recursion: .bash_profile conventionally sources .bashrc,
# so sourcing it back from here can cause an infinite loop on login shells.
if [ -f ~/.bash_profile ] && [ -z "$__BASHRC_SOURCED" ]; then
  __BASHRC_SOURCED=1
  source ~/.bash_profile
  unset __BASHRC_SOURCED
fi

# PATH additions
for dir in /usr/bin ~/.local/bin ~/Applications/depot_tools ~/.npm-global/bin ~/.bun/bin ~/go/bin ~/.cargo/bin; do
  case ":$PATH:" in
  *":$dir:"*) ;;
  *) PATH="$dir:$PATH" ;;
  esac
done
export PATH

# ---- Utility functions ----
backup() {
  if [ -z "$1" ] || [ ! -e "$1" ]; then
    echo "usage: backup <file>" >&2
    return 1
  fi
  cp -- "$1" "$1.bak"
}
copy() {
  if [ "$#" -eq 2 ] && [ -d "$1" ]; then
    command cp -r -- "$1" "$2"
  else
    command cp -- "$@"
  fi
}

# ---- Safer aliases ----
if command -v eza >/dev/null 2>&1; then
  alias ls='eza -al --group-directories-first --icons'
  alias gl='eza -al --group-directories-first --icons --git-repos'
  alias ll='eza -l --group-directories-first --icons'
  alias la='eza -a --group-directories-first --icons'
  alias lt='eza -aT --group-directories-first --icons'
else
  alias ls='ls --color=auto'
  alias ll='ls -l'
  alias la='ls -a'
fi
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'

# ---- Package manager abstraction ----
if command -v pacman >/dev/null 2>&1; then
  alias update='sudo pacman -Syu'
  alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'
  alias update_repo="sudo reflector --country 'India' --protocol https --sort rate --latest 10 --save /etc/pacman.d/mirrorlist"
elif command -v dnf >/dev/null 2>&1; then
  alias update='sudo dnf upgrade --refresh'
  alias cleanup='sudo dnf autoremove'
elif command -v apt >/dev/null 2>&1; then
  alias update='sudo apt update && sudo apt upgrade'
  alias cleanup='sudo apt autoremove'
fi

# ---- Misc useful ----
alias wget='wget -c'
alias tarnow='tar -acf'
alias untar='tar -zxvf'
alias help='tldr'
alias ld='lazydocker'
alias nv='nvim'
alias yz='yazi .'
alias tx='tmux'
alias up='topgrade'
alias txk='tx kill-session'
alias tl='tx ls'
alias yt='yt-dlp'

if command -v journalctl &>/dev/null; then
  alias jctl="journalctl -p 3 -xb"
fi
if command -v hwinfo &>/dev/null; then
  alias hw='hwinfo --short'
fi
if command -v zeditor &>/dev/null; then
  alias zed="zeditor"
fi
