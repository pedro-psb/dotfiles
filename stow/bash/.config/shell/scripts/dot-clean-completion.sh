#!/bin/bash
# Bash completion for dot-clean

_dot_clean_completion() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # Global options
    global_opts="--no-filter --help"

    # Commands
    commands="list status info edit"

    # List command options
    list_opts="--all --hidden --not-hidden --help"

    # If we're completing the first argument after dot-clean
    if [ $COMP_CWORD -eq 1 ]; then
        # Complete global options and commands
        COMPREPLY=( $(compgen -W "${global_opts} ${commands}" -- ${cur}) )
        return 0
    fi

    # Find the command by looking through previous words
    local command=""
    local i=1
    while [ $i -lt $COMP_CWORD ]; do
        case "${COMP_WORDS[i]}" in
            list|status)
                command="${COMP_WORDS[i]}"
                break
                ;;
        esac
        ((i++))
    done

    # Complete based on the command
    case "$command" in
        list)
            COMPREPLY=( $(compgen -W "${list_opts}" -- ${cur}) )
            ;;
        status)
            COMPREPLY=( $(compgen -W "--help" -- ${cur}) )
            ;;
        info)
            COMPREPLY=( $(compgen -W "--help" -- ${cur}) )
            ;;
        edit)
            COMPREPLY=( $(compgen -W "--help" -- ${cur}) )
            ;;
        *)
            # No command found, complete with commands and global options
            COMPREPLY=( $(compgen -W "${global_opts} ${commands}" -- ${cur}) )
            ;;
    esac

    return 0
}

# Register the completion function
complete -F _dot_clean_completion dot-clean
