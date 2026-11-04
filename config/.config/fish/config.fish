# ---- Utility functions (safe to define even in non-interactive shells) ----
function backup --argument filename
    cp $filename $filename.bak
end

function copy
    if test (count $argv) -eq 2 -a -d "$argv[1]"
        command cp -r $argv[1] $argv[2]
    else
        command cp $argv
    end
end

# Everything below only makes sense for an interactive session
if status is-interactive
    # Prompt
    if type -q starship
        starship init fish | source
    end

    # Man page formatting (safe fallback)
    if type -q bat
        set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
    else
        set -x MANPAGER less
    end
    set -x MANROFFOPT -c

    # Load user profile if exists
    if test -f ~/.fish_profile
        source ~/.fish_profile
    end

    # PATH additions
    fish_add_path "~/.local/bin"
    fish_add_path "~/.cargo/bin"
    fish_add_path $HOME/.cargo/bin
    fish_add_path "~/Applications/depot_tools"
    fish_add_path "~/.npm-global/bin"
    fish_add_path "~/.bun/bin"
    fish_add_path "~/go/bin"
    fish_add_path --prepend /usr/bin
    fish_add_path /opt/android-sdk/cmdline-tools/latest/bin/sdkmanager
    fish_add_path /opt/android-sdk/platform-tools
    fish_add_path /opt/android-sdk/build-tool

    # ---- History enhancements (!! and !$) ----
    function __history_previous_command
        switch (commandline -t)
            case "!"
                commandline -t $history[1]
                commandline -f repaint
            case "*"
                commandline -i !
        end
    end
    function __history_previous_command_arguments
        switch (commandline -t)
            case "!"
                commandline -t ""
                commandline -f history-token-search-backward
            case "*"
                commandline -i '$'
        end
    end
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments

    # Better history timestamps
    function history
        builtin history --show-time='%F %T ' $argv
    end

    # ---- Safer aliases ----
    if type -q eza
        alias ls='eza -al --group-directories-first --icons'
        alias gl='eza -al --group-directories-first --icons --git-repos'
        alias ll='eza -l --group-directories-first --icons'
        alias la='eza -a --group-directories-first --icons'
        alias lt='eza -aT --group-directories-first --icons'
    else
        alias ls='ls --color=auto'
        alias ll='ls -l'
        alias la='ls -a'
    end
    alias ..='cd ..'
    alias ...='cd ../..'
    alias grep='grep --color=auto'

    # ---- Package manager abstraction ----
    if type -q pacman
        alias update='sudo pacman -Syu'
        function cleanup
            set -l orphans (pacman -Qtdq)
            if test (count $orphans) -gt 0
                sudo pacman -Rns $orphans
            else
                echo "No orphan packages found."
            end
        end
        alias update_repo="sudo reflector --country India --protocol https --sort rate --latest 10 --save /etc/pacman.d/mirrorlist"
    else if type -q dnf
        alias update='sudo dnf upgrade --refresh'
        alias cleanup='sudo dnf autoremove'
    else if type -q apt
        alias update='sudo apt update && sudo apt upgrade'
        alias cleanup='sudo apt autoremove'
    end

    # ---- Misc useful ----
    alias wget='wget -c'
    alias tarnow='tar -acf'
    alias untar='tar -zxvf'
    alias help="tldr"
    alias ld="lazydocker"
    alias nv="nvim"
    alias yz="yazi ."
    alias tx="tmux"
    alias up="topgrade"
    alias txk="tmux kill-session"
    alias tl="tmux  ls"
    alias yt="yt-dlp"
    alias ff="fastfetch"
    alias hr="herdr"
    alias q='exit'
    alias cs='clear'

    set -gx SUDO_EDITOR /usr/bin/nvim
    set -gx EDITOR nvim

    # Journal errors (systemd systems)
    if type -q journalctl
        alias jctl="journalctl -p 3 -xb"
    end

    # Hardware info (optional)
    if type -q hwinfo
        alias hw='hwinfo --short'
    end

    # Optional editor
    if type -q zeditor
        alias zed="zeditor"
    end

    # Greeting
    function fish_greeting
    end
end
