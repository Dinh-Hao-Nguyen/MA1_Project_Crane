% Old variables
syms th1 th2 th3 th4 d6 dth1 dth2 dth3 dth4 dd6 ddth1 ddth2 ddth3 ddth4 ddd6 l_B m_B I_B

% Generalized coordinates
syms alpha(t) beta(t) theta1(t) theta2(t) d(t)       % (q : position)
syms dalpha(t) dbeta(t) dtheta1(t) dtheta2(t) dd(t)  % (dq: velocity)

% Parameters
syms I_tot        % inertia of the crane
syms l_b m_b I_b  % length, mass and inertia of the boom
syms g m          % gravity and payload mass
syms l_c m_c      % distance and mass of the counterbalance

Y3 = Y(3,:);

to_convert = expand(simplify(expand(Y3)));

to_convert = subs(to_convert, ddth1, diff(dalpha));
to_convert = subs(to_convert, ddth2, diff(dbeta));
to_convert = subs(to_convert, ddd6, diff(dd));
to_convert = subs(to_convert, ddth3, diff(dtheta1));
to_convert = subs(to_convert, ddth4, diff(dtheta2));

to_convert = subs(to_convert, th1, alpha);
to_convert = subs(to_convert, th2, beta);
to_convert = subs(to_convert, d6, d);
to_convert = subs(to_convert, th3, theta1);
to_convert = subs(to_convert, th4, theta2);

to_convert = subs(to_convert, dth1, dalpha);
to_convert = subs(to_convert, dth2, dbeta);
to_convert = subs(to_convert, dth3, dtheta1);
to_convert = subs(to_convert, dth4, dtheta2);

to_convert = subs(to_convert, l_B, l_b);
to_convert = subs(to_convert, m_B, m_b);
to_convert = subs(to_convert, I_B, I_b);

eq2latex = latex(to_convert);
eq2latex = replace(eq2latex,'\left(t\right)','');
eq2latex = replace(eq2latex,' ','');
eq2latex = replace(eq2latex,'\frac{\partial}{\partialt}\mathrm{dalpha}','\ddot{\alpha}');
eq2latex = replace(eq2latex,'\mathrm{dalpha}','\dot{\alpha}');
eq2latex = replace(eq2latex,'\frac{\partial}{\partialt}\mathrm{dbeta}','\ddot{\beta}');
eq2latex = replace(eq2latex,'\mathrm{dbeta}','\dot{\beta}');
eq2latex = replace(eq2latex,'\frac{\partial}{\partialt}\mathrm{dd}','\ddot{d}');
eq2latex = replace(eq2latex,'\mathrm{dd}','\dot{d}');
eq2latex = replace(eq2latex,'\frac{\partial}{\partialt}\mathrm{dtheta}_{1}','\ddot{\theta}_1');
eq2latex = replace(eq2latex,'\mathrm{dtheta}_{1}','\dot{\theta}_1');
eq2latex = replace(eq2latex,'\frac{\partial}{\partialt}\mathrm{dtheta}_{2}','\ddot{\theta}_2');
eq2latex = replace(eq2latex,'\mathrm{dtheta}_{2}','\dot{\theta}_2');
eq2latex = replace(eq2latex,'\left(','{');
eq2latex = replace(eq2latex,'\right)','}');
eq2latex = replace(eq2latex,'\sin','S_');
eq2latex = replace(eq2latex,'\cos','C_');
