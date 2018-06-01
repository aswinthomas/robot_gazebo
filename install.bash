#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
sudo add-apt-repository -y ppa:apt-fast/stable
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt update
sudo apt -y install apt-fast git
sudo apt-fast -y install ros-kinetic-desktop-full python-wstool python-pip
sudo rosdep init
rosdep update
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
sudo apt-fast -y install ros-kinetic-jackal-simulator ros-kinetic-jackal-desktop 
sudo apt-fast -y install ros-kinetic-rosbridge-suite ros-kinetic-web-video-server

mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src
git clone https://github.com/RobotWebTools/webrtc_ros
cd ..
catkin_make
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc

