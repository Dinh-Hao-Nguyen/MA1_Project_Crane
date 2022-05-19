% Kp=1e6*eye(3);
% Kd=3e2*eye(3);
% % q0=[0;0;50*0.294];
% % qf=[0;0;50*0.294];
% 
% syms k
% 
% base0 = 0.8102;
% arm0 = 1.1386;
% drum0 = 0.4208;
% 
% 
% f_vel_base = 1.4*(-0.25*(sin(k*0.9*0.25*pi/180)+0.65*cos(k*1.95*0.25*pi/180)));
% f_pos_base = (int(f_vel_base,k))*pi/360+base0;
% f_vel_arm = -0.16*(sin(k*0.5*pi/180)-0.64*cos(k*1.45*pi/180));
% f_pos_arm = int(f_vel_arm,k)*pi/360+arm0;
% f_vel_drum = 0.01*sin(k*0.4*pi/180);
% f_pos_drum = int(f_vel_drum,k)*pi/180+drum0;
% 
% tt=0:1e-2:49.89;
% % tt=0:1e-2:10;
% 
% f = waitbar(1/N_data,"Progress");
% vel_base=[]; pos_base=[]; vel_arm=[]; pos_arm=[]; vel_drum=[]; pos_drum=[];
% for i=1:length(tt)
%     vel_base(i) = double(subs(f_vel_base,k,i));
%     pos_base(i) = double(subs(f_pos_base,k,i));
%     vel_arm(i) = double(subs(f_vel_arm,k,i));
%     pos_arm(i) = double(subs(f_pos_arm,k,i));
%     vel_drum(i) = double(subs(f_vel_drum,k,i));
%     pos_drum(i) = double(subs(f_pos_drum,k,i));
%     waitbar(i/length(tt),f);
% end
% vel_base=double(vel_base);
% % q0=q0';
% % qf=q1';
% % tt=t;
% 
% % [q,qd,qdd]=jtraj(q0,qf,tt);
% 
% q=double([pos_base;pos_arm;pos_drum])';
% qd=double([vel_base;vel_arm;vel_drum])';
% % q=double(q)';
% % qd=double(qd)';

q0=[0.8;0.8;20.021];
q1=[0.8;0.2;20.021];

tt=0:1e-2:3.5;

Kp=1e6*eye(3);
Kd=3e2*eye(3);

[q,qd,qdd]=jtraj(q0,q1,tt);
