function [time_corr,q_corr] = correct_time(time,q)

    % The function allows to detect and deal with anormally long time
    % delays
    
    upper_bound=1.2;
    lower_bound=0.8;
    
    N_data = length(time);
    dt = time(1,2:N_data)-time(1,1:N_data-1);
    q_corr=q;
    t=time(1,1);
    time_corr(1)=t;
    t=t+dt(1);
    time_corr(2)=t;
%     t=t+dt(2);
%     time_corr(3)=t;
    
    for k=2:length(dt)
        if(dt(k)>upper_bound*dt(k-1))
            dt(k)=upper_bound*dt(k-1);
            q_corr(:,k+1) = q_corr(:,k)+(q_corr(:,k)-q_corr(:,k-1)); % we just keep the same slope than before the peak
        end
        if(dt(k)<lower_bound*dt(k-1))
            dt(k)=lower_bound*dt(k-1);
            q_corr(:,k+1) = q_corr(:,k)+(q_corr(:,k)-q_corr(:,k-1)); % we just keep the same slope than before the peak
        end
        t = t+dt(k);
        time_corr(k+1) = t;
    end
