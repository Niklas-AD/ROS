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

#download R50 model
RUN wget -O /home/appuser/mask2former_ws/model_config.yaml https://raw.githubusercontent.com/facebookresearch/Mask2Former/main/configs/cityscapes/panoptic-segmentation/maskformer2_R50_bs16_90k.yaml
RUN wget -O /home/appuser/mask2former_ws/model_weights.pkl https://dl.fbaipublicfiles.com/maskformer/mask2former/cityscapes/panoptic/maskformer2_R50_bs16_90k/model_final_4ab90c.pkl
RUN wget https://raw.githubusercontent.com/Niklas-AD/Mask2Former/main/configs/cityscapes/panoptic-segmentation/Base-Cityscapes-PanopticSegmentation.yaml

# Set the working folder at startup
WORKDIR /home/appuser/mask2former_ws



