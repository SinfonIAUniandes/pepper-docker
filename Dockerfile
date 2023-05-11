#Get Arch Linux OS from image and install basic dependencies
FROM archlinux
FROM ros/noetic

#Install git, nano, gcc and python
RUN pacman-db-upgrade
RUN pacman -Syu git base-devel gcc python python-pip nano go rustup --noconfirm
#Install Rust, this will be important for building a package manager
#Install paru, we will use this to build ROS Noetic
RUN useradd -m -G wheel -s /bin/bash pepper
RUN sed -Ei 's/^#\ (%wheel.*NOPASSWD.*)/\1/' /etc/sudoers
USER pepper
WORKDIR /home/pepper/
RUN rustup default stable
RUN git clone https://aur.archlinux.org/yay.git && cd yay \
&& makepkg -si --noconfirm && cd .. && rm -rf yay

RUN yay -S ros-noetic-ros-base python2-bin --noconfirm

#Install internal tools
RUN git clone https://github.com/SinfonIAUniandes/sinfonia_toolkit.git
RUN git clone https://github.com/SinfonIAUniandes/sinfonia_resources.git
RUN git clone https://github.com/ros-naoqi/pepper_moveit_config.git
RUN git clone https://github.com/ros-naoqi/pepper_robot.git
RUN git clone https://github.com/awesomebytes/pepper_virtual.git
RUN rosdep install -i -y --from-paths ./naoqi_driver
#Build ROS Noetic
LABEL Name=pepperdocker Version=0.0.2
