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
BASHRC=~/.bashrc
MAIN_SOURCE_SCRIPT="source /opt/ros/kinetic/setup.bash"
if grep -qF $MAIN_SOURCE_SCRIPT $BASHRC;then
   echo "opt setup.bash already exists"
else
   echo "Adding opt setup.bash to bashrc"
   echo $MAIN_SOURCE_SCRIPT >> $BASHRC
fi


source ~/.bashrc
sudo apt-fast -y install ros-kinetic-turtlebot ros-kinetic-turtlebot ros-kinetic-turtlebot-gazebo
sudo apt-fast -y install ros-kinetic-turtlebot-apps ros-kinetic-turtlebot-rviz-launchers
sudo apt-fast -y install ros-kinetic-rosbridge-suite ros-kinetic-navigation


# external dependencies
cd ~/
git clone https://bitbucket.org/gtborg/gtsam/
mkdir -p ~/gtsam/build && cd ~/gtsam/build
cmake -DGTSAM_INSTALL_GEOGRAPHICLIB=ON -DGTSAM_WITH_EIGEN_MKL=OFF ..
make -j8
sudo make install

# ROS dependencies
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src
git clone https://bitbucket.org/osrf/ariac -b ariac_2017
git clone https://github.com/AutoRally/autorally
cd ..
rosdep install --from-paths src --ignore-src --rosdistro=kinetic -y
catkin install
catkin build --cmake-args=-DGTSAM_WITH_EIGEN_MKL=OFF

USER_SOURCE_SCRIPT="source ~/catkin_ws/install/setup.bash"
if grep -qF "$USER_SOURCE_SCRIPT" BASHRC;then
   echo "user setup.bash already exists"
else
   echo "Adding user setup.bash to bashrc"
   echo $USER_SOURCE_SCRIPT >> $BASHRC
fi

# export variables
POSE="ROBOT_INITIAL_POSE=\"-x 9 -y 2 -z 0 -R 0 -P 0 -Y 3.14\""
if grep -qF "$POSE" BASHRC;then
   echo "robot initial exists"
else
   echo "Adding robot initial pose to bashrc"
   echo $POSE >> $BASHRC
fi

IP="ROS_IP=192.168.0.0" # replace with your computer IP where you will install this script
if grep -qF "$POSE" BASHRC;then
   echo "robot initial pose exists"
else
   echo "Adding robot initial pose to bashrc"
   echo $POSE >> $BASHRC
fi

URI="ROS_MASTER_URI=http://192.168.0.0:11311/" # replace with robot IP
if grep -qF "$URI" BASHRC;then
   echo "robot uri exists"
else
   echo "Adding robot uri to bashrc"
   echo $URI >> $BASHRC
fi

source ~/.bashrc



