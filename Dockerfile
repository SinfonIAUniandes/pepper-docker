#Get gentoo OS from image and install basic dependencies
FROM gentoo
FROM gentoo/portage
FROM ros:noetic 
#Install git, nano, gcc and python
RUN emerge --ask dev-vcs/git
RUN emerge --ask app-editors/nano
RUN emerge --ask sys-devel/gcc
RUN emerge --ask dev-lang/python:3.8
RUN emerge --ask dev-lang/python:2.7

LABEL Name=pepperdocker Version=0.0.2
