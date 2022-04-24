FROM mask2former_ros
 
# Change the default shell to Bash
SHELL [ "/bin/bash" , "-c" ]
 
# Create a Catkin workspace
RUN source /opt/ros/noetic/setup.bash \
 && mkdir -p /home/appuser/mask2former_ws/src \
 && cd /home/appuser/mask2former_ws \
 && catkin_make
 
# Clone Ros package with inference nodes
RUN cd /home/appuser/mask2former_ws/src \
 && git clone https://github.com/Niklas-AD/ros_mask2former.git 
 
# Make and source package
WORKDIR /home/appuser/mask2former_ws
RUN source /opt/ros/noetic/setup.bash \
 && catkin_make \
 && echo "source /home/appuser/mask2former_ws/devel/setup.bash" >> ~/.bashrc 

#download model
RUN wget -O /home/appuser/mask2former_ws/model_config.yaml https://raw.githubusercontent.com/facebookresearch/detectron2/main/configs/Cityscapes/mask_rcnn_R_50_FPN.yaml
RUN wget -O /home/appuser/mask2former_ws/model_weights.pkl https://dl.fbaipublicfiles.com/detectron2/Cityscapes/mask_rcnn_R_50_FPN/142423278/model_final_af9cf5.pkl
RUN wget -O /home/appuser/Base-RCNN-FPN.yaml https://raw.githubusercontent.com/facebookresearch/detectron2/main/configs/Base-RCNN-FPN.yaml

# Set the working folder at startup
WORKDIR /home/appuser/mask2former_ws

