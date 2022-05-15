clc,close all,clear

% Symbolic Variables Definition

syms alpha(t) beta(t) delta1(t) delta2(t) l_R(t) % (q : position) 
syms dalpha(t) dbeta(t) ddelta1(t) ddelta2(t) dl_R(t) % (dq: velocity)
syms I_tot % Inertia Base
syms l_B m_B I_B % Data Boom Arm
syms g m % gravity and payload mass
syms l_c m_c %counterbalance
 
% %%% System ParametersI_tot + d6^2*m + l_B^2*m*cos(th2)^2 + (l_B^2*m_B*cos(th2)^2)/4 + l_c^2*m_c*cos(th2)^2 - d6^2*m*cos(th3)^2*cos(th4)^2 + 2*d6*l_B*m*cos(th2)*sin(th4)

par_sym = [I_tot, l_B, m_B, I_B,g, m];
%par_val = [1, 1, 2, 0.3,9.81, 0.3];
par_val = [1, 1, 2, 0.3,9.81, 0.185];
save('par_val','par_val');
%I_tot = par_val(1); l_B = par_val(2); m_B = par_val(3); I_B = par_val(4); g = par_val(5); m = par_val(6);
% 
% %%%%%%

q = formula([alpha; beta; l_R; delta1; delta2]); %mapping position vector state
dq = formula([dalpha; dbeta; dl_R; ddelta1; ddelta2]); %mapping velocity vecotor state

% position tip of boom
x_B = l_B*cos(beta)*cos(alpha); 
y_B = l_B*cos(beta)*sin(alpha);
z_B = l_B*sin(beta);

% position counterbalance
x_c = -l_c*cos(beta)*cos(alpha); 
y_c = -l_c*cos(beta)*sin(alpha);
z_c = -l_c*sin(beta);

%position payload (relative)
dz = -l_R*cos(delta2)*cos(delta1);
dr = l_R*sin(delta2);
drp = l_R*cos(delta2)*sin(delta1);

%position payload (absolute)
x_M = x_B + cos(alpha)*dr-sin(alpha)*drp;
y_M = y_B + sin(alpha)*dr+cos(alpha)*drp;
z_M = z_B + dz;

T = 0.5*m_B*(diff(x_B)^2+diff(y_B)^2+diff(z_B)^2)/4 + ...
    0.5*m*(diff(x_M)^2+diff(y_M)^2+diff(z_M)^2) + ...
    0.5*I_tot*diff(alpha)^2 + ...
    0.5*I_B*diff(beta)^2 + ...
    0.5*m_c*(diff(x_c)^2+diff(y_c)^2+diff(z_c)^2); 
T = subs(T, diff(q), dq); %Kinematic Energy

V = m_B*g*z_B/2 + m*g*z_M - m_c*g*l_c*sin(beta); % Potential Energy  

%%%% Inertia Matrix Code

D = sym(zeros(length(q)));
for k = 1:length(q)
    partial = functionalDerivative(T, dq(k));
    for j = 1:length(q)
        coeff = formula(coeffs(partial, dq(j), 'All'));
        if length(coeff) > 2
            error("Equation doesn't fit the expected form")
        elseif length(coeff) < 2
            D(k, j) = 0;
        else
            D(k, j) = coeff(1);
        end
    end
    
    check = D*dq;
    if(simplify(expand(check(k)-partial)) ~= 0)
        error(sprintf("Wrong matrix decomposition for k=%d", k));
    end
end

M = simplify(D); %Inertia Matrix

C = diff(M); %Coriolis Matrix

G = sym(zeros(length(q), 1)); %Gravity Vector
for k=1:length(q)
    G(k) = functionalDerivative(V, q(k));
    
    for j = 1:length(q)
        for i = 1:length(q)
            C(k, j) = C(k, j)-functionalDerivative(M(i, j), q(k))*dq(i)/2;
        end
    end
end

% Model simplify
M = simplify(M);
C = simplify(subs(C, diff(q), dq));
G = simplify(G);


% Check Skew-Symmetric
dM = subs(diff(M), diff(q), dq);
simplify((dq.'*(dM-2*C)*dq)) %Must be zero

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Rewrite the above Matrices without the time dependece 

syms th1 th2 th3 th4 real % th1 = alpha / th2 = beta / th3 = delta1 / th4 = delta2
syms d6 positive %cable length
syms dth1 dth2 dth3 dth4 dd6 real %velocity state
syms T1 T2 F6 real % Input: T1 -> th1 / T2 ->th2 / F6 -> d6
syms ddth1 ddth2 ddth3 ddth4 ddd6 real % ddq : acceleration state
x = [th1 th2 d6 th3 th4 dth1 dth2 dd6 dth3 dth4]'; % state system 
u = formula([T1; T2; F6; 0; 0]); %Mapping input 

M = subs(M, [q; dq], x);
C = subs(C, [q; dq], x);
G = subs(G, [q; dq], x);
dq = subs(dq, dq, x(6:end));



% %%%%%%%%%%%%%%%%% LQR %%%%%%%%%%%%%%%%%%%%%55
% 
% M_inv = inv(M);
% parfor i = 1:numel(M_inv)
%      M_inv(i) = simplify(M_inv(i));
% end
% 
% theta_dd = M_inv*(u -C*dq -G);
% % dx = [dq; d2q];
% 
% eq = [dth1, dth2, dd6, dth3, dth4, theta_dd(1), theta_dd(2), theta_dd(3),theta_dd(4),theta_dd(5)];
% var = x;
% 
% Jac_A= jacobian(eq,var);
% Jac_B= jacobian(eq,[T1,T2,F6]);
% 
% Jac_A = subs(Jac_A,par_sym,par_val);
% Jac_B= subs(Jac_B,par_sym,par_val);
% 
% 
% eq_p = [0, pi/3, 0.1, 0, 0, 0, 0, 0, 0, 0];
% 
% u_eq_1 = 0;
% u_eq_2 = double(subs(G(2),[par_sym x'],[par_val eq_p]));
% u_eq_3 = double(subs(G(3),[par_sym x'],[par_val eq_p]));
% 
% 
% Jac_A_2 = double(subs(Jac_A,[x' T1 T2 F6],[eq_p u_eq_1 u_eq_2 u_eq_3]));
% Jac_B_2 = double(subs(Jac_B,[x' T1 T2 F6],[eq_p u_eq_1 u_eq_2 u_eq_3]));
% 
% Al = double(Jac_A_2);
% Bl = double(Jac_B_2);
% rank(ctrb(Al,Bl))
% 
% Cl = eye(10);
% Dl = zeros(10,3);
% Lin_sys = ss(Al,Bl,Cl,Dl,0.01);
% 
% %q_val = [10 100 10 10 10 10 10 10 0.5 0.5]; 
% %q_val = [10 100 10 10 10 10 10 10 0.85 0.85];
% q_val = [10 100 10 10 10 10 10 10 1 1];
% %q_val = [10 10 10 1 0.1 0.1 1 1 0.01 0.01];
% Q = diag(q_val);
% %R = diag([1 1 1]);
% R = diag([1 1 1]);
% [K,S,E]=lqr(Al,Bl,Q,R);
% 
% K
% 
% %save('K_Lqr','K');
% %save('Lqr_Parameters_heavierOSCILLATIONReaction','Q','R');
% %Lin_sys_close = ss(Al-Bl*K,Bl,Cl,Dl);
% 

