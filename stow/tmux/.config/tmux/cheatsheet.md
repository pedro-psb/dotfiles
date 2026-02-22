# Tmux cheatsheet

https://arcolinux.com/everthing-you-need-to-know-about-tmux-panes/

## Restart

tmux kill-server & tmux

## Session/Window Management

[pane help menu] <prefix> >
[window help menu] <prefix> <

## Basic Session/Windows/Pane Management

[rename pane] <prefix> .

[new windows] <prefix> c
[windows manager] lead + w
[rename windows] <prefix> ,

[new session] :new -s <name>
[session manager] lead + s
[rename session] <prefix> $

## Navigation

[last pane] <prefix> + l OR <prefix> ;

## Split

[vertical] <prefix> %
[horizontal] <prefix> "

## Modes

[copy-mode] <prefix> ]

## Close

[window] <prefix> &
[pane] <prefix> x

## Utils

[sync panes] <prefix> :setw synchronize-panes on|off
