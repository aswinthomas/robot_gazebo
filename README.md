# robot_gazebo_install

## Robot installation on VM

- Create a virtualbox (or similar) with ubuntu 16.04 64bit
- Under the VM manager set the network to bridged adaptor so it appears like its two different machines
- Clone this repo
```
mkdir -p ~/catkin_ws/src && cd src
git clone https://github.com/aswinthomas/robot_gazebo_install
```
- Then run ```./install.bash```

## Running server on VM

```roslaunch server_services.launch```

Note that you need to set your external IP in this launch file. Assume this is 172.16.24.108. Gazebo might take a few minutes to launch if you are running this for the first time.

## Running a web browser client on your host (user/operator)

### Viewing odom
Run ```http://172.16.24.108:8080/jackal_velocity_controller/odom``` on your host browser.

### Sending cmd_vel
On your VM view the odom so you can see if the robot is moving
```
rostopic echo /jackal_velocity_controller/odom
```
To be able to send commands on your host, you will need a RESTClient like [this](https://addons.mozilla.org/en-US/firefox/addon/restclient/)

Choose POST Method and set the url to http://172.16.24.108:8080/jackal_velocity_controller/cmd_vel and key in the following message
```
{"linear": {"x": 0.1, "y": 0.0, "z": 0.0}, "angular": {"y": 0.0, "x": 0.0, "z": 0.0}}
```
You will see that odom gors to 0.1 for an instant. This probably goes back to zero since command is not sent continuously

## Running a ROS client on your host (user/operator)

Go through the same steps as above to install on your host or another VM for the user, then run
```
roslaunch robot_gazebo_install client_services.launch
```

Now you will be able to view topics
```
rostopic echo /jackal_velocity_controller/odom
```

And publish command like
```
rostopic pub /jackal_velocity_controller/cmd_vel geometry_msgs/Tst "linear:
  x: 0.1
  y: 0.0
  z: 0.0
angular:
  x: 0.0
  y: 0.0
  z: 0.0" -r 10
```
```

