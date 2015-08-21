%% Simple demo for the Myo MATLAB interface
% #######################################################################
%
% Authored by Yi Jui Lee
% 
% Tested on MATLAB 2013a, Python 2.7
% 
% ***********************************************************************
% 
% Filename : myo_workfile.m
% Depends on Myo.m official development version
% 
% Version 1 (15 August 2015)
% 
% ***********************************************************************
% 
% Please refer to Myo's API and SDK Portal to learn more about the device

%% Create Myo Object
% Instantiates Myo object
if exist('m') == 1
    clear
end
m = Myo();

%% Get Data Types 
% The sampling rate requested does not represent the true sampling rate of
% the data stream. 
% For the purpose of demonstration, a plot function is called for each data
% type.

%% Get acceleration data in real time
% acceleration is given in 3 axis
% units in g
close all
m.getAcceleration();

%% Get gyro data in real time 
% gyroscope is given as the rate of rotation in 3 axis
% units in deg/s
close all
m.getGyroscope();

%% Get orientation data in real time
% Python interface returns quaternions x,y,z,w
% Myo.m utilizes quat2angle to convert the quaternions to euler angles
% roll pitch yaw units in radians
close all
m.getOrientation();

%% Get gestural data in real time
% Please perform sync calibration (sync status will be indicated on Myo
% Connect)
% Gets predefined gestures
% gesture statuses are fist, rest, waveout, wavein, fingerspread, doubletap
close all
m.getPose();

%% Get emg data in real time
% Gets raw EMG data from the 8 pods on the Myo armband
% Represents "activation" of the pods
% unitless value from -127 to 127
close all
m.getEmg();

%% Get all data simultaneously in real time
% Returns all 5 types of data simultaneously
% Performance depends on various factors (machine computing speed, memory,
% etc.)
close all
m.getAllData();

%% Get all data post-use
% Acquires all 5 data types in post operation mode
% The data can be acquired using the next method (see below)
m.getPostData();

%% Data can be accessed through the Myo object (post-use)
acceleration = m.acceleration;
gyroscope = m.gyroscope;
orientation = m.orientation;
pose = m.pose;
emg = m.emg;

