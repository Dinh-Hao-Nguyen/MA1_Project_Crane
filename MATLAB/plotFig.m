close all;

%% run part of Ident_model

N_data = length(theta1_vec);
useless = 0;

time=time(1,useless+1:N_data);
% torque_vec=[-torque_vec(:,1),torque_vec(:,2:3)];
torque_vec=torque_vec(useless+1:N_data,:);
torque_vec=(Matrix_filt(torque_vec'))';

q=[(yaw_vec(useless+1:N_data)); (pitch_vec(useless+1:N_data)) ; delta_vec(useless+1:N_data) ; theta1_vec(useless+1:N_data) ; theta2_vec(useless+1:N_data)];
q=correct_data(q);
[time,q]=correct_time(time,q);
q=Matrix_filt(q-q(:,1))+q(:,1); %we make the data start at zero, otherwise the butterworth filter induces distorsion.
q=[q(1:2,:)*pi/180 ; q(3,:) ; q(4:5,:)*pi/180]; %convert to rad
q=[q(1:3,:);q(4,:)-q(4,1);q(5,:)-q(5,1)];
qt=qt+([q(1:2,1);50*q(3,1)]'-[qt(1,1:2),qt(1,3)]);
%time=0:0.01:49.89;
mat_time=[time;time;time;time;time];
dq=TIME_DERIVATIVE(q,mat_time);
dq=Matrix_filt(dq);
ddq=TIME_DERIVATIVE(dq,mat_time);
ddq=Matrix_filt(ddq);
%%

Kp = 1e6*eye(3);
Kd = 3e2*eye(3);

figure('Name','alpha');

plot(t,q(1,:));
grid on;
hold on;
plot(save_time, save_pos(:,1));
plot(time_s, pos(:,1));
%plot(time_ss, pos_old(:,1));
xlabel('time (s)'); ylabel('position (rad)');
%legend('data from cameras', 'simulation with consideration of the counterbalance', 'simulation without consideration of the counterbalance');
legend('data from cameras', 'simulation with consideration of the counterbalance', 'simulation without consideration of the counterbalance');

title('Slew angle \alpha of the base');

figure('Name','beta');
plot(t,q(2,:));
grid on;
hold on;
plot(save_time, save_pos(:,2));
plot(time_s, pos(:,2));
%plot(time_ss, pos_old(:,2));
xlabel('time (s)'); ylabel('position (rad)');
%legend('data from cameras', 'simulation with consideration of the counterbalance', 'simulation without consideration of the counterbalance');
legend('data from cameras', 'simulation with consideration of the counterbalance', 'simulation without consideration of the counterbalance');
title('Luff angle \beta of the boom');

figure('Name','d');
plot(t,q(3,:));
grid on;
hold on;
plot(save_time, save_pos(:,3)/50);
plot(time_s, pos(:,3)/50);
%plot(time_ss, pos_old(:,3)/50);
xlabel('time (s)'); ylabel('position (m)');
%legend('data from cameras', 'simulation with consideration of the counterbalance', 'simulation without consideration of the counterbalance');
legend('data from cameras', 'simulation with consideration of the counterbalance', 'simulation without consideration of the counterbalance');
title('Length of the rope: d');

figure('Name','theta1');
plot(t,q(4,:));
grid on;
hold on;
plot(save_time, save_pos(:,4));
plot(time_s, pos(:,4));
%plot(time_ss, pos_old(:,4));
xlabel('time (s)'); ylabel('position (rad)');
%legend('data from cameras', 'simulation with consideration of the counterbalance', 'simulation without consideration of the counterbalance');
legend('data from cameras', 'simulation with consideration of the counterbalance', 'simulation without consideration of the counterbalance');
title('Tangential oscillation \theta_1');

figure('Name','theta2');
plot(t,q(5,:));
grid on;
hold on;
plot(save_time, save_pos(:,5));
plot(time_s, pos(:,5));
%plot(time_ss, pos_old(:,5));
xlabel('time (s)'); ylabel('position (rad)');
%legend('data from cameras', 'simulation with consideration of the counterbalance', 'simulation without consideration of the counterbalance');
legend('data from cameras', 'simulation with consideration of the counterbalance', 'simulation without consideration of the counterbalance');
title('Radial oscillation \theta_2');
