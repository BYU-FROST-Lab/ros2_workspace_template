#!/bin/bash

cd "$(dirname "$0")/.."
source scripts/env_setup.sh

# Start a new detached session
tmux new-session -d -s ${SESSION_NAME}

# Enable mouse support
tmux set-option -t ${SESSION_NAME} mouse on

########################
# Window 0: bringup
########################
tmux rename-window -t ${SESSION_NAME}:0 bringup

# Split into left/right (50/50)
tmux split-window -h -t ${SESSION_NAME}:0

# # Split left pane into top/bottom
# tmux split-window -v -t ${SESSION_NAME}:0.0

# Top-left pane
tmux send-keys -t ${SESSION_NAME}:0.0 \
  "docker exec -it ${CONTAINER} bash" C-m
tmux send-keys -t ${SESSION_NAME}:0.0 \
  "clear" C-m
tmux send-keys -t ${SESSION_NAME}:0.0 \
  "ros2 launch sensor_bringup bluerov_launch.py" 


# Right pane
tmux send-keys -t ${SESSION_NAME}:0.1 \
  "colcon build" C-m
tmux send-keys -t ${SESSION_NAME}:0.1 \
  "source install/setup.bash" C-m
tmux send-keys -t ${SESSION_NAME}:0.1 \
  "docker exec -it ${CONTAINER} bash" C-m
tmux send-keys -t ${SESSION_NAME}:0.1 \
  "clear" C-m
tmux send-keys -t ${SESSION_NAME}:0.1 \
  "ros2 topic list" 

########################
# Window 1: empty
########################
tmux new-window -t ${SESSION_NAME} -n monitor


########################
# Window 2: record
########################
tmux new-window -t ${SESSION_NAME} -n record
tmux send-keys -t ${SESSION_NAME}:record \
  "bash scripts/record.sh"


# Select the first window
tmux select-window -t ${SESSION_NAME}:0
# Attach to session
tmux attach -t ${SESSION_NAME}
