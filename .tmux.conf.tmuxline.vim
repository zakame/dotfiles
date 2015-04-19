# This tmux statusbar config was created by tmuxline.vim
# on Tue, 03 Feb 2015

set -g status-bg "colour234"
set -g message-command-fg "colour255"
set -g status-justify "left"
set -g status-left-length "100"
set -g status "on"
set -g pane-active-border-fg "colour190"
set -g message-bg "colour238"
set -g status-right-length "100"
set -g status-right-attr "none"
set -g message-fg "colour255"
set -g message-command-bg "colour238"
set -g status-attr "none"
set -g status-utf8 "on"
set -g pane-border-fg "colour238"
set -g status-left-attr "none"
setw -g window-status-fg "colour85"
setw -g window-status-attr "none"
setw -g window-status-activity-bg "colour234"
setw -g window-status-activity-attr "none"
setw -g window-status-activity-fg "colour190"
setw -g window-status-separator ""
setw -g window-status-bg "colour234"
set -g status-left "#[fg=colour17,bg=colour190] #S #[fg=colour190,bg=colour234,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=colour238,bg=colour234,nobold,nounderscore,noitalics]#[fg=colour255,bg=colour238] %Y-%m-%d  %H:%M #[fg=colour190,bg=colour238,nobold,nounderscore,noitalics]#[fg=colour17,bg=colour190] #h #(rainbarf --width 10 --remaining --bright --swap)"
setw -g window-status-format "#[fg=colour85,bg=colour234] #I #[fg=colour85,bg=colour234] #W "
setw -g window-status-current-format "#[fg=colour234,bg=colour238,nobold,nounderscore,noitalics]#[fg=colour255,bg=colour238] #I #[fg=colour255,bg=colour238] #W #[fg=colour238,bg=colour234,nobold,nounderscore,noitalics]"
