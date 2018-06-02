#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
sudo add-apt-repository -y ppa:apt-fast/stable
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt update
sudo apt -yq install apt-fast 
sudo apt-fast -y install ros-kinetic-desktop-full python-wstool python-pip python-catkin-tools
sudo rosdep init
rosdep update
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
sudo apt-fast -y install ros-kinetic-jackal-simulator ros-kinetic-jackal-desktop 
sudo apt-fast -y install ros-kinetic-rosbridge-suite ros-kinetic-tf2-web-republisher
sudo apt-fast -y install ros-kinetic-laser-assembler
sudo apt-fast -y install nodejs nodejs-legacy npm
sudo npm install -g grunt-cli
sudo rm -rf ~/.npm ~/tmp


mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src
#git clone -b update-to-chrome-59-api https://github.com/fkie-forks/webrtc_ros
#sed -i -e "/--revision $WEBRTC_REVISION/d" webrtc_ros/webrtc/checkout_source.sh
git clone https://github.com/RobotWebTools/ros3djs
cd ..
rosdep install --from-paths src --ignore-src --rosdistro=kinetic -y
catkin build
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc

cd src/ros3djs
npm install .



