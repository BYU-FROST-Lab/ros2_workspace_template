#!/bin/bash

cd "$(dirname "$0")/.."
source scripts/env_setup.sh

docker exec -it $CONTAINER bash -c \
  "source ~/ros2_ws/install/setup.bash && \
   ros2 run topic_monitor topic_monitor_node \
   --ros-args --params-file ~/config/time_sync_utils.yaml"