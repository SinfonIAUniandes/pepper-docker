#Get ubuntu OS from image and install basic dependencies
FROM ubuntu:20.04
FROM ros:noetic 
RUN apt-get update
RUN apt-get install -y wget git gcc python3 python3-pip
# These commands copy your files into the specified directory in the image
# and set that as the working location
#TODO

# Install pynaoqi 2.5.5.5 library
#TODO


# This command compiles your app using GCC, adjust for your source code
#TODO


LABEL Name=pepperdocker Version=0.0.1
