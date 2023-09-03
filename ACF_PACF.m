clc
clear all
close all

ping = xlsread("ping_results.xlsx");
time= ping([1:5000], 1:1);
data= ping([1:5000], 2:2);
N = length(data);

%% tetahat

A = [time, ones(N, 1)];

% least squares solution
tetaHat= inv(transpose(A)*A)*transpose(A)*data;

% Extract the slope and intercept
slope = tetaHat(1);
intercept = tetaHat(2);
Line= slope*time + intercept;

% equation = sprintf('y = %.2fx + %.2f', slope, intercept);
% disp(equation);

plot(time, data, 'o-');
% hold on;
% fitted_line = slope*time + intercept; % equation of the fitted line
% plot(time, fitted_line); % plot the fitted line
% title('Least Squares Fit');
% legend('Data', 'Fitted Line');

NewData= data-Line;
% plot(time, NewData, 'r.');
% hold on
% plot(time, data, 'b.');
% legend('Data without trend component', 'Main data');

%% ACF:

% % Compute the autocorrelation using the autocorr function
% lag = 15;  % Maximum lag to consider
% acf = autocorr(NewData, lag);
% 
% % Compute the 5% significance limits
% % significance_limit = 1.96 / sqrt(N);
% significance_limit = 0.2;
% 
% % Plot the ACF
% figure(1);
% stem(acf);
% title('Autocorrelation Function (ACF)');
% xlabel('Lag');
% ylabel('Autocorrelation');
% 
% % Add significance limits to the plot
% hold on;
% line([0, lag+1], [significance_limit, significance_limit], 'Color', 'r', 'LineStyle', '--');
% line([0, lag+1], [-significance_limit, -significance_limit], 'Color', 'r', 'LineStyle', '--');
% hold off;
% grid on;
% 
% % Perform the Markov test with ACF
% if max(abs(acf(3:end))) < significance_limit
%     fprintf('ACF test:\n The data exhibits Markovian characteristics.\n');
% else
%     fprintf('ACF test\n The data does not exhibit Markovian characteristics.\n');
% end
% 
% 
% %% PACF:
% 
% pacf = parcorr(NewData, lag);
% 
% % Plot the PACF
% figure(2);
% stem(pacf);
% title('Partial Autocorrelation Function  (PACF)');
% xlabel('Lag');
% ylabel('Partial Autocorrelation');
% 
% % Add significance limits to the plot
% hold on;
% line([0, lag+1], [significance_limit, significance_limit], 'Color', 'r', 'LineStyle', '--');
% line([0, lag+1], [-significance_limit, -significance_limit], 'Color', 'r', 'LineStyle', '--');
% hold off;
% grid on;
% 
% % Perform the Markov test with PACF
% if max(abs(pacf(3:end))) < significance_limit
%     fprintf('\nPACF test:\n The data exhibits Markovian characteristics.\n');
% else
%     fprintf('\nPACF test\n The data does not exhibit Markovian characteristics.\n');
% end

%% ARMA model

% train_data = data(1:4000);
% test_data = data(4001:5000);
% 
% % Specify the order of the ARMA model
% p = 1; % AR order
% q = 1; % MA order
% model = arima(p,0,q);
% 
% estimatedModel = estimate(model, train_data);
% simulatedData = simulate(estimatedModel, 1000);
% 
% plot(4001:5000, test_data, 'b');
% hold on;
% plot(4001:5000, simulatedData, 'r');
% legend('Test Data','Predictions');
% grid on
% title('ARMA(1,1) model');
% hold off;





