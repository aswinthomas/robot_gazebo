# robot_gazebo_install

## Robot installation on VM

- Create a virtualbox (or similar) with ubuntu 16.04 64bit
- Under the VM manager set the network to bridged adaptor so it appears like its two different machines
- Install git ```sudo apt install git``` and clone this repo
```
mkdir -p ~/catkin_ws/src && cd src
git clone https://github.com/aswinthomas/robot_gazebo_install
```
- Then run ```./install.bash```

## Running server on VM

```roslaunch server_services.launch```

## Running a web browser client on the robot

Open operator.html in a browser

## Running a web browser client on your host (user/operator)

WIP
