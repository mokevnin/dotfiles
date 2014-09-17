set-option -g prefix C-a
unbind-key C-b
bind-key C-a send-prefix

set -g base-index 1

set-option -sg escape-time 0

bind -n C-h select-pane -L
bind -n C-j select-pane -D
bind -n C-k select-pane -U
bind -n C-l select-pane -R
