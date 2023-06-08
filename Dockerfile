#Get Arch Linux OS from image and install basic dependencies
FROM ubuntu:20.04
FROM ros:noetic

#Install git, nano, gcc and python, these are mostly here for the fact they're used in development 
RUN apt update
RUN apt upgrade -y
RUN apt-get install git neofetch python3 python2 python3-pip gcc curl -y

#make the user
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

RUN neofetch
#Label the image
LABEL Name=pepperdocker Version=0.0.2
