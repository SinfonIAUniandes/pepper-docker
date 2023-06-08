#Get Ubuntu OS from image and install basic dependencies
FROM ubuntu:20.04
FROM ros:humble

#Install git, nano, gcc and python, these are mostly here for the fact they're used in development 
RUN apt-get update
RUN apt-get install git neofetch python3 python2 gcc curl sudo -y && rm -rf /var/lib/apt/lists/*
RUN rosdep update

#make the user
RUN useradd -m pepper
RUN usermod -aG sudo pepper
RUN sed -Ei 's/^#\ (%wheel.*NOPASSWD.*)/\1/' /etc/sudoers
USER pepper
WORKDIR /home/pepper/
RUN rosdep update --include-eol-distros
RUN rosdep install catkin

#Install internal tools
RUN git clone https://github.com/SinfonIAUniandes/sinfonia_toolkit.git
RUN git clone https://github.com/ros-naoqi/pepper_moveit_config.git
RUN git clone https://github.com/ros-naoqi/pepper_robot.git
RUN git clone https://github.com/awesomebytes/pepper_virtual.git
RUN rosdep install -i -y --from-paths --ignore-src ./pepper_moveit_config ./pepper_robot ./pepper_virtual 

RUN neofetch
#Label the image
LABEL Name=sinfonia-novadocker Version=0.0.2
