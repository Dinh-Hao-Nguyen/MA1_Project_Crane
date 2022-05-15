

syms th1 th2 th3 th4 real % th1 = alpha / th2 = beta / th3 = delta1 / th4 = delta2
syms d6 positive %cable length
syms dth1 dth2 dth3 dth4 dd6 real %velocity state
syms ddth1 ddth2 ddth3 ddth4 ddd6 real % ddq : acceleration state
syms g %gravity

I_tot=0.08;   l_B=5;     m_B=2;     I_B=0.01;   m=1;  l_c=l_B/5;  m_c=m_B/2;
a=size(pos);
N_data = a(1);

%pi_vect = [I_tot ; l_B^2*m_B ; l_B^2*m ; l_B*m ; m ; l_B*m_B ; I_B ; l_c^2*m_c ; l_c*m_c];

% IMPORT MATRIX Y PREVIOUSLY IDENTIFIED

torque_tot=[];
Y_tot=[];
for j=1:N_data
    torque_tot = [torque_tot ; trq(j,:)'];
end
f = waitbar(1/N_data,"Progress");
for k=1:N_data
    Y_tot = [Y_tot ; double(subs(Y,[th1 th2 d6 th3 th4 dth1 dth2 dd6 dth3 dth4 ddth1 ddth2 ddd6 ddth3 ddth4 g],[pos(k,:) vel(k,:) acc(k,:) 9.81]))];
    waitbar(k/N_data,f);
end
torque_tot = [torque_tot ; m*l_B^2 ; l_c^2*m_c ; l_c*m_c];
Y_tot = [Y_tot;[0,0,1,0,0,0,0,0,0];[0,0,0,0,0,0,0,1,0];[0,0,0,0,0,0,0,0,1]];
sol1=lsqr(Y_tot,torque_tot,1e-12,50)