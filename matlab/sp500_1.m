clear all;close all;
load('SP500.mat');

  % Plot SP 
  yr = year + (month-0.5)/12; % Decimal year at center of given month
 %figure (1)
%     % plot(yr,sp500); hold on
% figure(2)
%   semilogy(yr, sp500);hold on
%   xlabel('Year')
%   ylabel('S&P500 Stock Index')
%   xlim([year(1),year(end)+1])
 
%   %Calculate index for first month of each decade
%   

  for i=1:6
       firstmonth(:,i) = sp500(37 + 120*(i-1))
  end
%   
% %   % relative increase
% %   firstdecade_increase= sp500(156)-sp500(37)
% %   for i=1:5
% %       decadeincrase(:,i)= sp500(156+(120*(i-1)))-sp500(37+(120*(i-1)))
% %    
% %   end
% %   
% %   % calculate the mean annual rate of increase
% %   firstannual_increase= sp500(48)-sp500(37);
% %   for i=1:49
% %       
% %       annual_increase= abs(sp500(48+(12*i))-sp500(37+(12*i)));
% %       
% %   end
% %   avg_annual_icrease= mean(annual_increase)
% %   SPmean = mean(sp500);
% %   SPstd = std(sp500);
% 
% 
  % part 2 Detrended log sp500
logsp_firstmonth=log(firstmonth)
x= linspace(yr(37),yr(637),6)
u = linspace(x(1),x(end),1000)';

plot(x,logsp_firstmonth,'o');
yinterp1 = interp1(x,logsp_firstmonth,u,'linear');
plot(x,logsp_firstmonth,'bo',u,yinterp1,'r-');
decade_sp500=sp500(37:636);
decade_yr=yr(37:636);

slope(1)=(logsp_firstmonth(2)-logsp_firstmonth(1))/(yr(157)-yr(37));
slope(2)=(logsp_firstmonth(3)-logsp_firstmonth(2))/(yr(277)-yr(157));
slope(3)=(logsp_firstmonth(4)-logsp_firstmonth(3))/(yr(397)-yr(277));
slope(4)=(logsp_firstmonth(5)-logsp_firstmonth(4))/(yr(517)-yr(397));
slope(5)=(logsp_firstmonth(6)-logsp_firstmonth(5))/(yr(637)-yr(517));


b(1)= logsp_firstmonth(1)-(yr(37)*slope(1));
b(2)= logsp_firstmonth(2)-(yr(157)*slope(2));
b(3)= logsp_firstmonth(3)-(yr(277)*slope(3));
b(4)= logsp_firstmonth(4)-(yr(397)*slope(4));
b(5)= logsp_firstmonth(5)-(yr(517)*slope(5));


for i=37:156
    linear_function(:,i)= (yr(i)*slope(1))+b(1);
end;
for i=157:276
    linear_function(:,i)= (yr(i)*slope(2))+b(2);
end
for i=277:396
    linear_function(:,i)= (yr(i)*slope(3))+b(3);
end
for i=397:516
    linear_function(:,i)= (yr(i)*slope(4))+b(4);
end
for i=517:636
    linear_function(:,i)= (yr(i)*slope(5))+b(5);
end
for i=637:672
    linear_function(:,i)= 0;
end
linear_function= reshape(linear_function(37:636),600,1)
logspd= log(decade_sp500)-linear_function;

% xlabel('First Month of the Decade')
% ylabel ('log(decade_sp500)')
% title ('The connect-the-dots interpolant, using interp1')

figure(2)
  plot(decade_yr,log(decade_sp500));
  legend('Original log(sp500)','Location','northwest');
 
 trend=log(decade_sp500)-logspd;
  mean(logspd);
  hold on 
  plot(decade_yr,trend,':r')
  plot(decade_yr, logspd,'m')
  plot(decade_yr,zeros(size(decade_yr)),':k')
  legend('Original log(sp500)','Trend','Detrended log(sp500)','mean(Detrended)','Location','northwest');
  title('Detrended Time Series logspd versus Original log(sp500)');
  xlim([yr(1) yr(end)])
  xlabel('Year 1960~2010');


  
  %vertical lines through each decade
for i=1:6
    plot([yr(37 + 120*(i-1)) yr(37 + 120*(i-1))], [-0.8 8],'c--')

end
hold off
%variance of logspd within each decade

decade_var(1)= var(logspd(1:120));
decade_var(2)= var(logspd(121:240));
decade_var(3)= var(logspd(241:360));
decade_var(4)= var(logspd(361:480));
decade_var(5)= var(logspd(481:600));

% Part 3 Fourier Analysis of logspd
N = length(logspd);
M = [0:(N/2 - 1) -N/2:-1];
logspdhat=fft(logspd);
logspdA = real(ifft(logspdhat));

  vartot = mean(logspd.^2);

  Nwyr = 10; % Window length in years

  figure(1)
  clf
  subplot(2,1,1)
  plot(decade_yr,logspdA,'k')
  ylabel('logspdA [C]')
  xlim([1960 2010])