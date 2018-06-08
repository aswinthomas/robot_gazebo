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
sudo apt-fast -y install ros-kinetic-turtlebot ros-kinetic-turtlebot ros-kinetic-turtlebot-gazebo
sudo apt-fast -y install ros-kinetic-turtlebot-apps ros-kinetic-turtlebot-rviz-launchers
sudo apt-fast -y install ros-kinetic-rosbridge-suite 



mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src
git clone https://bitbucket.org/osrf/ariac -b ariac_2017
cd ..
rosdep install --from-paths src --ignore-src --rosdistro=kinetic -y
catkin build
echo "source ~/catkin_ws/install/setup.bash" >> ~/.bashrc
ROBOT_INITIAL_POSE="-x 9 -y 2 -z 0 -R 0 -P 0 -Y 3.14"
source ~/.bashrc



