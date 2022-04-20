## Docker Setup
1. install nvidia docker
2. docker build -f base.Dockerfile -t nvidia_ros .
3. docker build -f mask2former.Dockerfile -t mask2former_ros .
4. docker build -f r50_node.Dockerfile -t r50_node .

## Run Container
5. docker run -it --network host --gpus all r50_node /bin/bash

## Run Rosnode
rosrun mask2former {python_ros node}


### Rosbag commands

rosbag reindex 2022-01-26-11-36-14.bag 

rostopic echo /camera_0/image | tee topic2.yaml

rosrun image_view image_saver image:=/result_images


