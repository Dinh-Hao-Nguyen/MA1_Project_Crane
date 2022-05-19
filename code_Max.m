clear all; clc; close all;

addpath('C:\NatNetSDK2.5\Samples\Matlab')
dllPath = ('C:\Users\rosha\OneDrive\Desktop\Michele\NatNet_SDK_3.1 (1)\NatNetSDK\lib\x64\NatNetML.dll');
assemblyInfo = NET.addAssembly(dllPath);
theClient = NatNetML.NatNetClientML;

HostIP = char('127.0.0.1');
theClient.Initialize(HostIP, HostIP)

% Initialises variables
x = zeros(1,2);
y = zeros(1,2);
z = zeros(1,2);
yaw = zeros(1,2);
roll = zeros(1,2);
pitch = zeros(1,2);

%INPUT: (desired displacement)
base_angle = 0;%-pi/2; %in rad
arm_angle = 0; %in rad
wire_length = 0; %in cm
drum_angle = wire_length/2; %conversion from length of wire to drum angle
desired_displacement = [base_angle -arm_angle drum_angle];

%Sets up communication with actuators
base = HebiLookup.newGroupFromSerialNumbers('X-80525');
arm = HebiLookup.newGroupFromSerialNumbers('X-80469');
drum = HebiLookup.newGroupFromSerialNumbers('X-80468');
cmd = CommandStruct();
group = HebiLookup.newGroupFromSerialNumbers({'X-80525','X-80469','X-80468'});
actuFeedback = group.getNextFeedback();

% Tf = 5; %tindication of the duration (s)
% Ts = 1e-3; %sampling time
% tt = 0:Ts:Tf; %time vector



% alpha_0 = actuFeedback.position; %initial angles (rad)
% alpha_f = alpha_0 + desired_displacement; %final angles

i = 1;

% com_base = 0;
% com_arm = 0.3;
% com_drum = 15;
% cmd.position =  [com_base com_arm com_drum];
t0 = tic(); %we need a time variable in order to get the velocities etc
% N_data=5000;
% k=1:N_data;
% com_base = 0.7*(-0.25*(sind(k*0.9*0.125)+0.65*cosd(k*1.95*0.125)));
% com_arm = -0.065*(sind(k*0.85*0.6)+0.54*cosd(k*1.35*0.5));
% com_drum = 0.9*sind(k*0.4);

actuFeedback = group.getNextFeedback();

q0=actuFeedback.position;
%q1=[0.8;0.06;q0(3)+5];
q1=[-0.8;0.9;q0(3)+4];
q1=[-0.4;0;q0(3)-2];
q1=[0;0;0];
q1=[q0(1);q0(2);q0(3)];

t=0:1e-2:4.5;
[qt,qdt,qddt] = my_traj(q0, q1, t);
% qt=[qt;qt(end,:).*ones(500,3)];
% qdt=[qdt;qdt(end,:).*ones(500,3)];
% qddt=[qddt;qddt(end,:).*ones(500,3)];

N_data=length(qt);
time = zeros(1,N_data);
commands = zeros(3,N_data);

while i<=N_data
    
%     com_base = 0.15*(sind(i*0.65)+cosd(i*1.3));
%     com_arm = 0.1*(sind(i*0.45)-cosd(i*0.9));
%     com_drum = 0.9*sind(i*0.2);
%     commands(:,i)=[com_base(i) ; com_arm(i) ; com_drum(i)];
%     cmd.velocity =  [com_base(i) com_arm(i) com_drum(i)]; %Base Arm Drum
    cmd.position=qt(i,:);
    %group.send(cmd);
    cmd.velocity=qdt(i,:);
    group.send(cmd);
    
    %Reads torque from actuators' sensors
    actuFeedback = group.getNextFeedback();
    torque = actuFeedback.effort;
    torque_vec(i,:) = torque;
    
    
    for j = [2 1] % 2 = crane, 1 = payload
        
        RigidBody_ID = j; %Identifictation number of object tracked on Motive
        
        
        %Reads data from OptiTrack
        frameOfData = theClient.GetLastFrameOfData(); 
        rigidBodyData = frameOfData.RigidBodies(RigidBody_ID);
        
        %Computes angles and position of the two objects tracked (boom &
        %payload)
        q = quaternion( rigidBodyData.qx, rigidBodyData.qy, rigidBodyData.qz, rigidBodyData.qw ); % extrnal file quaternion.m
        qRot = quaternion( 0, 0, 0, 1);    % rotate pitch 180 to avoid 180/-180 flip for nicer graphing
        q = mtimes(q, qRot);
        angles = EulerAngles(q,'xyz');

        roll(j) = -angles(2) * 180.0 / pi;
        yaw(j) = -angles(1) * 180.0 / pi;  
        pitch(j) = angles(3) * 180.0 / pi;  
        
        x(j) = -rigidBodyData.y;
        y(j) = -rigidBodyData.x;
        z(j) = rigidBodyData.z;
        
    end
    
    R=[cosd(yaw(2)),-sind(yaw(2)),0 ; sind(yaw(2)),cosd(yaw(2)),0 ; 0,0,1];%Rotation matrix, so that theta1 and theta2 are always 
                                                                       %defined the same way wrt to the crane
    res1 = R*[x(1);y(1);z(1)];
    x(1)=res1(1); y(1)=res1(2); z(1)=res1(3);
    res2 = R*[x(2);y(2);z(2)];
    x(2)=res2(1); y(2)=res2(2); z(2)=res2(3);
    
    %Computes vector that represents the wire (as a rigid body), goes from
    %boom to payload
    delta_x = x(1)-x(2);
    delta_y = y(1)-y(2);
    delta_z = z(1)-z(2);
    
    delta = norm([delta_x delta_y delta_z]); %Length of the wire
    
    %Computes angles measuring vibration of payload
    theta1 = -asind(delta_y/sqrt(delta_x^2 + delta_z^2));
    theta2 = asind(delta_x/sqrt(delta_y^2 + delta_z^2));
    
    yaw_vec(i) = yaw(2);
    pitch_vec(i) = pitch(2);
    roll_vec(i) = roll(2);
    quaternions(i,:) = q; %!!!!!!!!!!!!!!!!!!!!!!!!! invert i and : if not working lol and erase the '
    position(i,:) = [x y z];
    delta_vec(i) = delta;
    theta1_vec(i) = theta1;
    theta2_vec(i) = theta2;
    torque_vec(i,:) = torque;
    
%     command(i,:) = cmd.position * 180/pi;
    pos(i,:) = (actuFeedback.position);
    vel(i,:) = (actuFeedback.velocity);
    
    time(1,i) = toc(t0);
    i = i+1;
    
%     pause(Ts);
end

theClient.Uninitialize

