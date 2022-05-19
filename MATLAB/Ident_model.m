

syms th1 th2 th3 th4 real % th1 = alpha / th2 = beta / th3 = delta1 / th4 = delta2
syms d6 positive %cable length
syms dth1 dth2 dth3 dth4 dd6 real %velocity state
syms ddth1 ddth2 ddth3 ddth4 ddd6 real % ddq : acceleration state
syms g %gravity

l_B=0.76;     m=0.190;  l_c=0.23;  m_c=1.022; m_B=0.558;

N_data = length(theta1_vec);
useless = 0;

time=time(useless+1:N_data);
time=time-time(1);  %remove the 
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

%pi_vect = [I_tot ; l_B^2*m_B ; l_B^2*m ; l_B*m ; m ; l_B*m_B ; I_B ; l_c^2*m_c ; l_c*m_c];

% IMPORT MATRIX Y PREVIOUSLY IDENTIFIED

torque_tot=[];
Y_tot=[];
for j=1:length(torque_vec)
    torque_tot = [torque_tot ; torque_vec(j,:)';0;0];
end
f = waitbar(1/N_data,"Progress");
for k=1:N_data-useless
    waitbar(k/N_data,f);
    Y_tot = [Y_tot ; double(subs(Y,[th1 th2 d6 th3 th4 dth1 dth2 dd6 dth3 dth4 ddth1 ddth2 ddd6 ddth3 ddth4 g],[q(:,k)' dq(:,k)' ddq(:,k)' 9.81]))];
end
% torque_tot = [torque_tot ; m*l_B^2 ; l_c^2*m_c ; l_c*m_c ; l_B^2*m_B ; l_B*m ; m ; l_B*m_B];
% Y_tot = [Y_tot;[0,0,1,0,0,0,0,0,0];[0,0,0,0,0,0,0,1,0];[0,0,0,0,0,0,0,0,1];[0,1,0,0,0,0,0,0,0];[0,0,0,1,0,0,0,0,0];[0,0,0,0,1,0,0,0,0];[0,0,0,0,0,1,0,0,0]];
% sol1=lsqr(Y_tot,torque_tot,1e-12,50)

torque_tot = [torque_tot ; m*l_B^2 ; l_c^2*m_c ; l_c*m_c];
Y_tot = [Y_tot;[0,0,1,0,0,0,0,0,0];[0,0,0,0,0,0,0,1,0];[0,0,0,0,0,0,0,0,1]];
sol1 = lsqr(Y_tot,torque_tot,1e-12,50)

for i=1:5
figure;
plot(q(i,:))
figure
plot(dq(i,:))
figure
plot(ddq(i,:))
end
