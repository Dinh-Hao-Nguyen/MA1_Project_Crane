function Matrix_filt = Matrix_filt(Matrix)
% The function returns the filtered version of Matrix.
% Matrix collects the time history of a vector (it is a thin matrix). 
% Its rows are the samples, its colums are different components of the 
% vector.

[num_of_components, N_data] = size(Matrix);

% b = ones(1,100)/100;
% a = 1;

% D_theta = designfilt('lowpassiir', 'FilterOrder', 2, ...
%              'PassbandFrequency', 100/90, 'PassbandRipple', 0.08,...
%              'SampleRate', 100);
% D_rest = designfilt('lowpassiir', 'FilterOrder', 2, ...
%              'PassbandFrequency', 0.25, 'PassbandRipple', 0.08,...
%              'SampleRate', 100);

% [b,a]=butter(2,10/(100/2),'low');
% [b_t,a_t]=butter(2,10/(100/2),'low');

order=2;
fs=100; % sampling frequency in Hz
tresh=0.1;

freq=100*(0:(N_data-1)/2)/N_data;

              
for j = 1 : num_of_components
    
      fftt = fft(Matrix(j,:));
      sp = abs(fftt(1:(N_data-1)/2+1));
      [maxi,ind] = max(sp);
      I = find(sp(ind:length(sp))<tresh*maxi);
      i = I(1);
      fc = freq(i) %cuttoff freq
%       [b,a] = butter(order,fc/(fs/2),'low');
        D = designfilt('lowpassiir', 'FilterOrder', order, ...
             'PassbandFrequency', fc, 'PassbandRipple', 0.08,...
             'SampleRate', fs);

      Matrix_filt(j,:) = filtfilt(D,Matrix(j,:));
      
      
%       
%     Matrix_filt(j,:) = filtfilt(b,a,Matrix(j,:));
%         if (j==4 | j==5)
%             Matrix_filt(j,:) = filtfilt(D_theta,Matrix(j,:));
%         else
%             Matrix_filt(j,:) = filtfilt(D_rest,Matrix(j,:));
%         end
%         if (j==4 | j==5)
%             Matrix_filt(j,:) = lowpass(Matrix(j,:),10,100);
%         else
%             Matrix_filt(j,:) = lowpass(Matrix(j,:),5,100);
%         end
%      
% 
%         if (j==4 | j==5)
%             Matrix_filt(j,:) = filter(b_t,a_t,Matrix(j,:));
%         else
%             Matrix_filt(j,:) = filter(b,a,Matrix(j,:));
%         end

end
end