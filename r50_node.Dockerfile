FROM mask2former_ros
 
# Change the default shell to Bash
SHELL [ "/bin/bash" , "-c" ]
 
WORKDIR /home/appuser

# Create a Catkin workspace
RUN source /opt/ros/noetic/setup.bash \
 && mkdir -p /home/appuser/mask2former_ws/src \
 && cd /home/appuser/mask2former_ws/src \
 && catkin_init_workspace 

#download R50 model
RUN wget -O /home/appuser/mask2former_ws/src/model_config.yaml https://raw.githubusercontent.com/facebookresearch/Mask2Former/main/configs/cityscapes/panoptic-segmentation/maskformer2_R50_bs16_90k.yaml
RUN wget -O /home/appuser/mask2former_ws/src/model_weights.pkl https://dl.fbaipublicfiles.com/maskformer/mask2former/cityscapes/panoptic/maskformer2_R50_bs16_90k/model_final_4ab90c.pkl
COPY ros_node.py /home/appuser/mask2former_ws/src
 
# Build the Catkin workspace and ensure it's sourced
RUN source /opt/ros/noetic/setup.bash \
 && cd /home/appuser/mask2former_ws\
 && catkin_make
RUN echo "source /home/appuser/mask2former_ws/devel/setup.bash" >> ~/.bashrc
 
# Set the working folder at startup
WORKDIR /mask2former_ws/src



