#Get Arch Linux OS from image and install basic dependencies
FROM archlinux

#Install git, nano, gcc and python
RUN pacman-db-upgrade
RUN pacman -Syu git base-devel gcc python python-pip nano rustup --noconfirm
#Install Rust, this will be important for building a package manager
#Install paru, we will use this to build ROS Noetic
RUN useradd -m -G wheel -s /bin/bash pepper
RUN sed -Ei 's/^#\ (%wheel.*NOPASSWD.*)/\1/' /etc/sudoers
USER pepper
WORKDIR /home/pepper/
RUN rustup default stable
RUN git clone https://aur.archlinux.org/paru.git && cd paru \
  && makepkg -si --noconfirm && cd .. && rm -rf paru

#Build ROS Noetic
LABEL Name=pepperdocker Version=0.0.2
