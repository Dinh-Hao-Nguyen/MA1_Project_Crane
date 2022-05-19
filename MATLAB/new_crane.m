function aux = new_crane(v)
   
    
   
    I_tot=0.08;   l_B=0.76;     m=0.190;  l_c=0.23;  m_c=1.022; m_B=0.558;     I_B = 0.5;  g=9.81;   
   
   u = v(1:3);
   q = v(4:8);
   dq = v(9:13);
   
   th1 = q(1);
   th2 = q(2);
   d6 = q(3)/50;
   th3 = q(4);
   th4 = q(5);
   
   dth1 = dq(1);
   dth2 = dq(2);
   dd6 = dq(3)/50;
   dth3 = dq(4);
   dth4  = dq(5);
  
   %%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
   Mm = [I_tot + d6^2*m + l_B^2*m*cos(th2)^2 + (l_B^2*m_B*cos(th2)^2)/4 + l_c^2*m_c*cos(th2)^2 - d6^2*m*cos(th3)^2*cos(th4)^2 + 2*d6*l_B*m*cos(th2)*sin(th4),                         d6*l_B*m*cos(th4)*sin(th2)*sin(th3),                             l_B*m*cos(th2)*cos(th4)*sin(th3), d6*m*cos(th3)*cos(th4)*(l_B*cos(th2) + d6*sin(th4)),                -d6*m*sin(th3)*(d6 + l_B*cos(th2)*sin(th4));
                                                                                                                d6*l_B*m*cos(th4)*sin(th2)*sin(th3),                   I_B + l_B^2*m + (l_B^2*m_B)/4 + l_c^2*m_c, - l_B*m*sin(th2)*sin(th4) - l_B*m*cos(th2)*cos(th3)*cos(th4),                 d6*l_B*m*cos(th2)*cos(th4)*sin(th3), -d6*l_B*m*(cos(th4)*sin(th2) - cos(th2)*cos(th3)*sin(th4));
                                                                                                                   l_B*m*cos(th2)*cos(th4)*sin(th3), -m*(l_B*sin(th2)*sin(th4) + l_B*cos(th2)*cos(th3)*cos(th4)),                                                            m,                                                   0,                                                          0;
                                                                                                d6*m*cos(th3)*cos(th4)*(l_B*cos(th2) + d6*sin(th4)),                         d6*l_B*m*cos(th2)*cos(th4)*sin(th3),                                                            0,                            -d6^2*m*(sin(th4)^2 - 1),                                                          0;
                                                                                                        -d6*m*sin(th3)*(d6 + l_B*cos(th2)*sin(th4)),  -d6*l_B*m*(cos(th4)*sin(th2) - cos(th2)*cos(th3)*sin(th4)),                                                            0,                                                   0,                                                     d6^2*m];
 
   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   Cc = [                                                 2*d6*dd6*m - dth2*l_B^2*m*sin(2*th2) - (dth2*l_B^2*m_B*sin(2*th2))/4 - dth2*l_c^2*m_c*sin(2*th2) - 2*d6*dd6*m*cos(th3)^2*cos(th4)^2 + 2*dd6*l_B*m*cos(th2)*sin(th4) + 2*d6*dth4*l_B*m*cos(th2)*cos(th4) - 2*d6*dth2*l_B*m*sin(th2)*sin(th4) + 2*d6^2*dth3*m*cos(th3)*cos(th4)^2*sin(th3) + 2*d6^2*dth4*m*cos(th3)^2*cos(th4)*sin(th4),                                                                                                                                                                      dd6*l_B*m*cos(th4)*sin(th2)*sin(th3) + d6*dth2*l_B*m*cos(th2)*cos(th4)*sin(th3) + d6*dth3*l_B*m*cos(th3)*cos(th4)*sin(th2) - d6*dth4*l_B*m*sin(th2)*sin(th3)*sin(th4),                                                                                                                   dth3*l_B*m*cos(th2)*cos(th3)*cos(th4) - dth2*l_B*m*cos(th4)*sin(th2)*sin(th3) - dth4*l_B*m*cos(th2)*sin(th3)*sin(th4), d6*m*cos(th3)*cos(th4)*(dd6*sin(th4) - dth2*l_B*sin(th2) + d6*dth4*cos(th4)) + dd6*m*cos(th3)*cos(th4)*(l_B*cos(th2) + d6*sin(th4)) - d6*dth3*m*cos(th4)*sin(th3)*(l_B*cos(th2) + d6*sin(th4)) - d6*dth4*m*cos(th3)*sin(th4)*(l_B*cos(th2) + d6*sin(th4)),                                                                                                                                                - dd6*m*sin(th3)*(d6 + l_B*cos(th2)*sin(th4)) - d6*m*sin(th3)*(dd6 + dth4*l_B*cos(th2)*cos(th4) - dth2*l_B*sin(th2)*sin(th4)) - d6*dth3*m*cos(th3)*(d6 + l_B*cos(th2)*sin(th4));
                                                           (dth1*l_B^2*m*sin(2*th2))/2 + (dth1*l_B^2*m_B*sin(2*th2))/8 + (dth1*l_c^2*m_c*sin(2*th2))/2 + (3*dd6*l_B*m*cos(th4)*sin(th2)*sin(th3))/2 + d6*dth1*l_B*m*sin(th2)*sin(th4) + (d6*dth2*l_B*m*cos(th2)*cos(th4)*sin(th3))/2 + (3*d6*dth3*l_B*m*cos(th3)*cos(th4)*sin(th2))/2 - (3*d6*dth4*l_B*m*sin(th2)*sin(th3)*sin(th4))/2,                                                                                                      (dd6*m*(l_B*cos(th2)*sin(th4) - l_B*cos(th3)*cos(th4)*sin(th2)))/2 + (d6*dth4*l_B*m*(cos(th2)*cos(th4) + cos(th3)*sin(th2)*sin(th4)))/2 - (d6*dth1*l_B*m*cos(th2)*cos(th4)*sin(th3))/2 + (d6*dth3*l_B*m*cos(th4)*sin(th2)*sin(th3))/2, (dth2*l_B*m*cos(th3)*cos(th4)*sin(th2))/2 - dth4*l_B*m*cos(th4)*sin(th2) - (dth2*l_B*m*cos(th2)*sin(th4))/2 + dth3*l_B*m*cos(th2)*cos(th4)*sin(th3) + dth4*l_B*m*cos(th2)*cos(th3)*sin(th4) + (dth1*l_B*m*cos(th4)*sin(th2)*sin(th3))/2,                                  dd6*l_B*m*cos(th2)*cos(th4)*sin(th3) + d6*dth3*l_B*m*cos(th2)*cos(th3)*cos(th4) + (d6*dth1*l_B*m*cos(th3)*cos(th4)*sin(th2))/2 - (d6*dth2*l_B*m*cos(th4)*sin(th2)*sin(th3))/2 - d6*dth4*l_B*m*cos(th2)*sin(th3)*sin(th4), dd6*l_B*m*cos(th2)*cos(th3)*sin(th4) - dd6*l_B*m*cos(th4)*sin(th2) - (d6*dth2*l_B*m*cos(th2)*cos(th4))/2 + d6*dth4*l_B*m*sin(th2)*sin(th4) + d6*dth4*l_B*m*cos(th2)*cos(th3)*cos(th4) - (d6*dth2*l_B*m*cos(th3)*sin(th2)*sin(th4))/2 - d6*dth3*l_B*m*cos(th2)*sin(th3)*sin(th4) - (d6*dth1*l_B*m*sin(th2)*sin(th3)*sin(th4))/2;
                                                                                                          d6*dth4*m*sin(th3) - d6*dth1*m + d6*dth1*m*cos(th3)^2*cos(th4)^2 - dth1*l_B*m*cos(th2)*sin(th4) + (dth3*l_B*m*cos(th2)*cos(th3)*cos(th4))/2 - d6*dth3*m*cos(th3)*cos(th4)*sin(th4) - (3*dth2*l_B*m*cos(th4)*sin(th2)*sin(th3))/2 - (dth4*l_B*m*cos(th2)*sin(th3)*sin(th4))/2,                                                                                                dth2*l_B*m*cos(th3)*cos(th4)*sin(th2) - (dth4*l_B*m*cos(th4)*sin(th2))/2 - dth2*l_B*m*cos(th2)*sin(th4) + (dth3*l_B*m*cos(th2)*cos(th4)*sin(th3))/2 + (dth4*l_B*m*cos(th2)*cos(th3)*sin(th4))/2 - (dth1*l_B*m*cos(th4)*sin(th2)*sin(th3))/2,                                                                                                                                                                                                                                       0,                                                                                                                      d6*dth3*m*(sin(th4)^2 - 1) - (dth1*m*cos(th3)*cos(th4)*(l_B*cos(th2) + 2*d6*sin(th4)))/2 - (dth2*l_B*m*cos(th2)*cos(th4)*sin(th3))/2,                                                                                                                                                                                               (dth2*l_B*m*(cos(th4)*sin(th2) - cos(th2)*cos(th3)*sin(th4)))/2 - d6*dth4*m + (dth1*m*sin(th3)*(2*d6 + l_B*cos(th2)*sin(th4)))/2;
2*d6^2*dth4*m*cos(th3)*cos(th4)^2 - (d6^2*dth4*m*cos(th3))/2 + (dd6*l_B*m*cos(th2)*cos(th3)*cos(th4))/2 + 2*d6*dd6*m*cos(th3)*cos(th4)*sin(th4) - (d6^2*dth3*m*cos(th4)*sin(th3)*sin(th4))/2 - d6^2*dth1*m*cos(th3)*cos(th4)^2*sin(th3) - (3*d6*dth2*l_B*m*cos(th3)*cos(th4)*sin(th2))/2 - (d6*dth3*l_B*m*cos(th2)*cos(th4)*sin(th3))/2 - (d6*dth4*l_B*m*cos(th2)*cos(th3)*sin(th4))/2,                                                                                                           (dd6*l_B*m*cos(th2)*cos(th4)*sin(th3))/2 + (d6*dth3*l_B*m*cos(th2)*cos(th3)*cos(th4))/2 - (d6*dth1*l_B*m*cos(th3)*cos(th4)*sin(th2))/2 - d6*dth2*l_B*m*cos(th4)*sin(th2)*sin(th3) - (d6*dth4*l_B*m*cos(th2)*sin(th3)*sin(th4))/2,                                                                                                                                                                            -(l_B*m*cos(th2)*cos(th4)*(dth1*cos(th3) + dth2*sin(th3)))/2,                                                                               (d6*dth1*m*cos(th4)*sin(th3)*(l_B*cos(th2) + d6*sin(th4)))/2 - 2*d6^2*dth4*m*cos(th4)*sin(th4) - 2*d6*dd6*m*(sin(th4)^2 - 1) - (d6*dth2*l_B*m*cos(th2)*cos(th3)*cos(th4))/2,                                                                                                                                                                                                                             (d6*dth1*m*cos(th3)*(d6 + l_B*cos(th2)*sin(th4)))/2 + (d6*dth2*l_B*m*cos(th2)*sin(th3)*sin(th4))/2;
                               (3*d6*dth2*l_B*m*sin(th2)*sin(th3)*sin(th4))/2 - (d6^2*dth3*m*cos(th3))/2 - d6^2*dth3*m*cos(th3)*cos(th4)^2 - (dd6*l_B*m*cos(th2)*sin(th3)*sin(th4))/2 - d6*dth1*l_B*m*cos(th2)*cos(th4) - d6^2*dth1*m*cos(th3)^2*cos(th4)*sin(th4) - (d6*dth3*l_B*m*cos(th2)*cos(th3)*sin(th4))/2 - (d6*dth4*l_B*m*cos(th2)*cos(th4)*sin(th3))/2 - 2*d6*dd6*m*sin(th3), (dd6*l_B*m*cos(th2)*cos(th3)*sin(th4))/2 - (dd6*l_B*m*cos(th4)*sin(th2))/2 - d6*dth2*l_B*m*cos(th2)*cos(th4) + (d6*dth4*l_B*m*sin(th2)*sin(th4))/2 + (d6*dth4*l_B*m*cos(th2)*cos(th3)*cos(th4))/2 - d6*dth2*l_B*m*cos(th3)*sin(th2)*sin(th4) - (d6*dth3*l_B*m*cos(th2)*sin(th3)*sin(th4))/2 + (d6*dth1*l_B*m*sin(th2)*sin(th3)*sin(th4))/2,                                                                                                                       (dth2*(l_B*m*cos(th4)*sin(th2) - l_B*m*cos(th2)*cos(th3)*sin(th4)))/2 + (dth1*l_B*m*cos(th2)*sin(th3)*sin(th4))/2,                                                                                                      d6^2*dth3*m*cos(th4)*sin(th4) + (d6*dth1*m*cos(th3)*(d6 - 2*d6*cos(th4)^2 + l_B*cos(th2)*sin(th4)))/2 + (d6*dth2*l_B*m*cos(th2)*sin(th3)*sin(th4))/2,                                                                                                                                                                                                 2*d6*dd6*m - (d6*dth2*l_B*m*(sin(th2)*sin(th4) + cos(th2)*cos(th3)*cos(th4)))/2 + (d6*dth1*l_B*m*cos(th2)*cos(th4)*sin(th3))/2];
 

 %%%%%
 
 Gg = [
 
                                             0
(g*cos(th2)*(2*l_B*m + l_B*m_B - 2*l_c*m_c))/2
                        -g*m*cos(th3)*cos(th4)
                      d6*g*m*cos(th4)*sin(th3)
                      d6*g*m*cos(th3)*sin(th4)]; 
   
%%%

u_1 = u(1) + Gg(1);
u_2 = u(2) + Gg(2);
u_3 = u(3) + Gg(3);


input = [u_1;u_2;u_3;0;0];

y = inv(Mm)*(-Cc*dq  - Gg + input); %computes ddq


aux = [y;input];
