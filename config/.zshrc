# ============================================================
# Utility functions
# ============================================================


source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh


source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh



# Rebuild the dump file only once a day
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi



ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240"

# Try history first, fall back to completion system
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Only use history (default, fastest)
ZSH_AUTOSUGGEST_STRATEGY=(history)

# Like history, but prioritizes matches from after the same previous command
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd)

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20



backup() {
    cp "$1" "$1.bak"
}

copy() {
    if [[ $# -eq 2 && -d "$1" ]]; then
        command cp -r "$1" "$2"
    else
        command cp "$@"
    fi
}


# ============================================================
# Prompt
# ============================================================

if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi


# ============================================================
# Man page formatting
# ============================================================

if command -v bat >/dev/null 2>&1; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
else
    export MANPAGER="less"
fi

export MANROFFOPT="-c"


# ============================================================
# Load user profile if it exists
# ============================================================

if [[ -f "$HOME/.zsh_profile" ]]; then
    source "$HOME/.zsh_profile"
fi


# ============================================================
# PATH additions
# ============================================================

typeset -U path PATH

path+=(
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$HOME/Applications/depot_tools"
    "$HOME/.npm-global/bin"
    "$HOME/.bun/bin"
    "$HOME/go/bin"
)


# ============================================================
# History
# ============================================================

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt EXTENDED_HISTORY

# Better history display
alias history='fc -li 1'


# ============================================================
# History expansion (!! and !$)
# ============================================================

# Zsh already supports:
#
#   !!    -> previous command
#   !$    -> last argument of previous command
#   !*    -> all arguments of previous command
#
# Example:
#
#   echo hello world
#   !!
#   !$
#
# Enable history expansion in interactive shells.
setopt BANG_HIST


# ============================================================
# Safer / better ls aliases
# ============================================================

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


# ============================================================
# Navigation
# ============================================================

alias ..='cd ..'
alias ...='cd ../..'


# ============================================================
# Misc command aliases
# ============================================================

alias grep='grep --color=auto'

alias wget='wget -c'
alias tarnow='tar -acf'
alias untar='tar -zxvf'

alias help='tldr'
alias ld='lazydocker'
alias nv='nvim'
alias yz='yazi .'
alias tx='tmux'
alias up='topgrade'
alias txk='tmux kill-session'
alias tl='tmux ls'
alias yt='yt-dlp'
alias ff='fastfetch'
alias hr='herdr'
alias q='exit'
alias cs='clear'


# ============================================================
# Package manager abstraction
# ============================================================

if command -v pacman >/dev/null 2>&1; then

    alias update='sudo pacman -Syu'

    cleanup() {
        local orphans

        orphans=($(pacman -Qtdq 2>/dev/null))

        if (( ${#orphans[@]} > 0 )); then
            sudo pacman -Rns "${orphans[@]}"
        else
            echo "No orphan packages found."
        fi
    }

    alias update_repo='sudo reflector --country India --protocol https --sort rate --latest 10 --save /etc/pacman.d/mirrorlist'

elif command -v dnf >/dev/null 2>&1; then

    alias update='sudo dnf upgrade --refresh'
    alias cleanup='sudo dnf autoremove'

elif command -v apt >/dev/null 2>&1; then

    alias update='sudo apt update && sudo apt upgrade'
    alias cleanup='sudo apt autoremove'

fi


# ============================================================
# Editor
# ============================================================

export SUDO_EDITOR="/usr/bin/nvim"
export EDITOR="nvim"


# ============================================================
# Systemd journal
# ============================================================

if command -v journalctl >/dev/null 2>&1; then
    alias jctl='journalctl -p 3 -xb'
fi


# ============================================================
# Hardware information
# ============================================================

if command -v hwinfo >/dev/null 2>&1; then
    alias hw='hwinfo --short'
fi


# ============================================================
# Zed
# ============================================================

if command -v zeditor >/dev/null 2>&1; then
    alias zed='zeditor'
fi


# ============================================================
# Zsh quality-of-life options
# ============================================================

setopt AUTO_CD
setopt CORRECT
setopt INTERACTIVE_COMMENTS


# ============================================================
# Completion
# ============================================================

autoload -Uz compinit
compinit


# ============================================================
# Greeting
# ============================================================

function precmd() {
    :
}
