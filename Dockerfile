#Get Arch Linux OS from image and install basic dependencies
FROM ubuntu:20.04
FROM ros

#Install git, nano, gcc and python
RUN apt-get git neofetch python3 python3-pip gcc rust nano -y

#Install paru, we will use this to build ROS Noetic
RUN useradd -m pepper
RUN usermod -aG sudo pepper
RUN sed -Ei 's/^#\ (%wheel.*NOPASSWD.*)/\1/' /etc/sudoers
USER pepper
WORKDIR /home/pepper/
RUN rosdep update

#Install internal tools
RUN git clone https://github.com/SinfonIAUniandes/sinfonia_toolkit.git
RUN git clone https://github.com/ros-naoqi/pepper_moveit_config.git
RUN git clone https://github.com/ros-naoqi/pepper_robot.git
RUN git clone https://github.com/awesomebytes/pepper_virtual.git

#Build ROS Noetic
LABEL Name=pepperdocker Version=0.0.2
