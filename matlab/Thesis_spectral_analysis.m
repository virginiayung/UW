% read CSV file. Year, month, day, number_new_ticket
clear all; close all;
% filename='zendesk_new_ticket_monthly.csv'; 
filename2 = 'zendesk_new_ticket_weekly.csv';
% M = importdata(filename)
W = importdata(filename2)
% 
% % D =datenum(M.textdata(:,1))
% % 
W_Ticket = W.data(:,2)
week = W.data(:,1)
W_User = W.data(:,3)
%  Ticket = M.data (:,3)
% Year = M.data (:,1)
% Month = M.data(:,2)
% Yr = Year + (Month-0.5)/12; % Decimal year at center of given month
% % plot num_ticket
% figure (1)
%     plot(Yr,Ticket); hold on
%     xlabel('Year')
%   ylabel('Zendesk New Ticket')
%    
% % plot log(num_ticket)
% figure(2)
%     semilogy(Yr,Ticket);hold on
%         xlabel('Time')
%         ylabel('Log of Zendesk New Ticket')
%       xlim([Year(1),Year(end)+1])

% 
% figure(1)
% plot(W_Ticket); hold on
% xlabel('Week')
% ylabel('New Support Ticket')
% figure (2)
% semilogy(W_Ticket); hold on
% xlabel('Week')
% ylabel('Log of New Support Ticket')


 for i=1:7
       firstweek(:,i) = W_Ticket(13 + 52*(i-1))
  end
  
%   % relative increase
%   firstannual_increase= W_Ticket(62)-W_Ticket(11)
%   for i=1:6
%       annualincrase(:,i)= W_Ticket(62+(52*(i-1)))-W_Ticket(11+(52*(i-1)))
%    
%   end
%   
% %   % calculate the mean annual rate of increase
% %   firstannual_increase= sp500(48)-sp500(37);
% %   for i=1:49
% %       
% %       annual_increase= abs(sp500(48+(12*i))-sp500(37+(12*i)));
% %       
% %   end
% avg_annual_icrease= mean(annualincrease)
%   Ticketmean = mean(W_Ticket);

% 
  % part 2 Detrended log sp500
logsp_firstweek=log(firstweek)
x= linspace(week(13),week(326),7)
u = linspace(x(1),x(end),1000)';

plot(x,logsp_firstweek,'o');
yinterp1 = interp1(x,logsp_firstweek,u,'linear');
plot(x,logsp_firstweek,'bo',u,yinterp1,'r-');
week_ticket=W_Ticket(13:325);
week_time=week(13:325);

slope(1)=(logsp_firstweek(2)-logsp_firstweek(1))/(week(65)-week(13));
slope(2)=(logsp_firstweek(3)-logsp_firstweek(2))/(week(117)-week(65));
slope(3)=(logsp_firstweek(4)-logsp_firstweek(3))/(week(169)-week(117));
slope(4)=(logsp_firstweek(5)-logsp_firstweek(4))/(week(221)-week(169));
slope(5)=(logsp_firstweek(6)-logsp_firstweek(5))/(week(273)-week(221));
slope(6)=(logsp_firstweek(7)-logsp_firstweek(6))/(week(325)-week(273));


b(1)= logsp_firstweek(1)-(week(13)*slope(1));
b(2)= logsp_firstweek(2)-(week(65)*slope(2));
b(3)= logsp_firstweek(3)-(week(117)*slope(3));
b(4)= logsp_firstweek(4)-(week(169)*slope(4));
b(5)= logsp_firstweek(5)-(week(221)*slope(5));
b(6)= logsp_firstweek(6)-(week(273)*slope(6));




for i=13:64
    linear_function(:,i)= (week(i)*slope(1))+b(1);
end;
for i=65:116
    linear_function(:,i)= (week(i)*slope(2))+b(2);
end
for i=117:168
    linear_function(:,i)= (week(i)*slope(3))+b(3);
end
for i=169:220
    linear_function(:,i)= (week(i)*slope(4))+b(4);
end
for i=221:272
    linear_function(:,i)= (week(i)*slope(5))+b(5);
end
for i=273:325
    linear_function(:,i)= (week(i)*slope(6))+b(6);
end
for i= 326:340
    linear_function(:,i)= 0;
end
     
linear_function= reshape(linear_function(13:325),313,1)
logspd= log(week_ticket)-linear_function;

% xlabel('First Month of the Decade')
% ylabel ('log(decade_sp500)')
% title ('The connect-the-dots interpolant, using interp1')

figure(2)
  plot(week_time,log(week_ticket));
  legend('Original log(weekly_ticket)','Location','northwest');
 
 trend=log(week_ticket)-logspd;
  mean(logspd);
  hold on 
  plot(week_time,trend,':r')
  plot(week_time, logspd,'m')
  plot(week_time,zeros(size(week_time)),':k')
  legend('Original log(weekly_ticket)','Trend','Detrended log(weekly_ticket)','mean(Detrended)','Location','northwest');
  title('Detrended Time Series logspd versus Original log(weekly_ticket)');
  xlim([week(1) week(end)])
  xlabel('Week 13~325');
  ylabel('Ticket Volume');
  
  
  
    
  %vertical lines through each decade
for i=1:7
    plot([week(13 + 52*(i-1)) week(13 + 52*(i-1))], [-2.0 10],'c--')

end
hold off
%variance of logspd within each decade

annual_var(1)= var(logspd(1:52));
annual_var(2)= var(logspd(53:104));
annual_var(3)= var(logspd(105:156));
annual_var(4)= var(logspd(157:208));
annual_var(5)= var(logspd(209:260));
annual_var(6)= var(logspd(261:313));



% Part 3 Fourier Analysis of logspd
N = length(logspd);
M = [0:(N/2 - 1) -N/2:-1];
logspdhat=fft(logspd);
logspdA = real(ifft(logspdhat));

  vartot = mean(logspd.^2);

  Nw = 52; % Window length in days
  figure(1)
  clf
  subplot(2,1,1)
  plot(week_time,logspdA,'k')
  ylabel('logspdA [C]')
  xlim([12 313])
  
 
  Nw2 = Nw/2;  % Half-window length
  t = 1:Nw;
  icolor = 'rmgcbyk';  % Colors used for different window periods
  logspdAw = zeros(Nw,7);  % Windowed logspdA
  for iw = 1:7
figure (3)
    ioff = (iw-1)*Nw/2;  % Index offset
    subplot(2,1,1)
    iwc = mod(iw-1,7)+1;  % Cycle through the 5 colors
   subplot(2,1,2)
    logspdAw(:,iw) = logspdA(ioff+t);
    plot(week_time(ioff+t),logspdA(ioff+t),icolor(iwc)); hold on
    ylabel('Windowed logspdA [C]')
    xlim([13 325])
    hold on
  end
  hold off
  logspdAwhat = fft(logspdAw); % Spectrum simultaneously computed
                         % column-wise for all windows
   % Windowed power spectra

  Mw=[0:(Nw/2-1) -Nw/2:-1]; % Harmonics for windowed DFT
  for iw = 1:6
    Sw = abs(logspdAwhat/Nw).^2;
    iwc = mod(iw-1,5)+1;  % Cycle through the 5 colors
    figure(4)
    plot(Mw,abs(Sw(:,iw)),[icolor(iwc) 'o'])
    legend('13~64','65~116','117~168', '169~220','221~272','273~325')
    xlabel('M_w')
    ylabel('Spectral power [C^2]')
    hold on
  end
%   hold off
%   title('logspdA power spectrum, each window')
  
  
  
%   
%   %%Prblem 4
% % Calculate directly and plot
%   
%   row1 = 0:(Nw-1);
%   indx = repmat(row1,Nw,1);
%   col1 = row1';
%   indx = indx + repmat(col1,1,Nw);
%   indx = mod(indx,Nw);
%   indx = indx+1;
%   
%   for k=1:6
%     logspdAw_k=logspdAw(:,k)
%     logspdAwlagmx = logspdAw_k(indx);
%     covmx = cov(logspdAwlagmx,1);
%     acvs = covmx(:,1);
%     iwc = mod(k-1,7)+1;  % Cycle through the 7 colors
%     figure(5)
%     subplot(2,1,1)
%     plot(0:(Nw/2-1),acvs(1:Nw/2),[icolor(iwc) '.']); hold on
%     xlabel('Lag [months]');
%     ylabel('Autocovariance [C^2]');
%     title ('Lagged Autocovariance Sequence for Each Year');
%     legend('13~64','65~116','117~168','169~220','221~272','273~325');
%     
%     %fit red noise
%     maxlag = 60;
%     subplot(2,1,2)
%     p = 0:(maxlag-1);
%     dt = 1;
%     tau = 24;
%     plot(p,acvs(p+1)/acvs(1),[icolor(iwc) '.'],[0 maxlag],exp(-1)*[1 1],'g--',...
%         p,exp(-p*dt/tau),'r-'); hold on
%     plot((0:maxlag),0,'k--')
%     xlabel('Lag [months]')
%     ylabel('Autocorrelation')
%     xlim([0 maxlag])
%     legend('Decades','Exponential','red noise')
%     
%     acvs_check(:,k)= acvs
%     
%    
%   end
% 
% %    % Verify same result from IDFT of power spectrum
% %   acvs2 = ifft(abs( logspdAwhat).^2)/Nw;
% %   relerr_acvs = norm(acvs_check-acvs2)/norm(acvs2)
% 
% 
% 
