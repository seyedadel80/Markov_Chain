clc
clear all
close all

%% Data classification:

ping = xlsread("ping_results.xlsx");
data= ping([1:5000], 2:2);

% Calculate the mean and standard deviation of the data
mean_val = mean(data);
std_val = std(data);

% Define the group boundaries
% boundaries = [mean_val + std_val, mean_val + 0.5*std_val, mean_val, mean_val - 0.5*std_val, mean_val - std_val];
boundaries = [mean_val + 0.25*std_val, mean_val + 0.125*std_val, mean_val, mean_val - 0.125*std_val, mean_val - 0.25*std_val];


% Initialize group indices
group_indices = zeros(size(data));

% Classify the data into groups
group_indices(data > boundaries(1)) = 1; % Group 1
group_indices(data > boundaries(2) & data <= boundaries(1)) = 2; % Group 2
group_indices(data > boundaries(3) & data <= boundaries(2)) = 3; % Group 3
group_indices(data > boundaries(4) & data <= boundaries(3)) = 4; % Group 4
group_indices(data > boundaries(5) & data <= boundaries(4)) = 5; % Group 5
group_indices(data <= boundaries(5)) = 6; % Group 6
group_data = group_indices;

% % Plot the data according to their groups
% figure;
% scatter(1:5000, data, [], group_indices, 'filled');
% colormap(jet(6));
% colorbar;
% xlabel('Data Index');
% ylabel('Data Value');
% title('Data Classification Based on Mean and Standard Deviation');
% 
% % Plot the data containing the group numbers on the figure
% figure;
% scatter(1:5000, group_data, [], group_data, 'filled');
% colormap(jet(6));
% colorbar;
% xlabel('Data Index');
% ylabel('Group Number');
% title('Group Numbers Based on Mean and Standard Deviation');

%% Transition Matrix:

num_states = 6;
transition_counts = zeros(num_states);
for i = 1:length(group_data)-1
    transition_counts(group_data(i), group_data(i+1)) = transition_counts(group_data(i), group_data(i+1)) + 1;
end
transition_matrix = transition_counts ./ sum(transition_counts, 2);

disp('Transition counts:');
disp(transition_counts);
disp('Transition Matrix:');
disp(transition_matrix);

%% Second-7th Order Transition Matrix:

% 2
transition_counts2 = zeros(num_states);
for i = 1:length(group_data)-2
    transition_counts2(group_data(i), group_data(i+2)) = transition_counts2(group_data(i), group_data(i+2)) + 1;
end
disp('Transition counts 2:');
disp(transition_counts2);
transition_matrix2=transition_matrix^2;
disp('Transition Matrix 2:');
disp(transition_matrix2);

% 3
transition_counts3 = zeros(num_states);
for i = 1:length(group_data)-3
    transition_counts3(group_data(i), group_data(i+3)) = transition_counts3(group_data(i), group_data(i+3)) + 1;
end
disp('Transition counts 3:');
disp(transition_counts3);
transition_matrix3=transition_matrix^3;
disp('Transition Matrix 3:');
disp(transition_matrix3);

% 4
transition_counts4 = zeros(num_states);
for i = 1:length(group_data)-4
    transition_counts4(group_data(i), group_data(i+4)) = transition_counts4(group_data(i), group_data(i+4)) + 1;
end
disp('Transition counts 4:');
disp(transition_counts4);
transition_matrix4=transition_matrix^4;
disp('Transition Matrix 4:');
disp(transition_matrix4);

% 5
transition_counts5 = zeros(num_states);
for i = 1:length(group_data)-5
    transition_counts5(group_data(i), group_data(i+5)) = transition_counts5(group_data(i), group_data(i+5)) + 1;
end
disp('Transition counts 5:');
disp(transition_counts5);
transition_matrix5=transition_matrix^5;
disp('Transition Matrix 5:');
disp(transition_matrix5);

% 6
transition_counts6 = zeros(num_states);
for i = 1:length(group_data)-6
    transition_counts6(group_data(i), group_data(i+6)) = transition_counts6(group_data(i), group_data(i+6)) + 1;
end
disp('Transition counts 6:');
disp(transition_counts6);
transition_matrix6=transition_matrix^6;
disp('Transition Matrix 6:');
disp(transition_matrix6);

% 7
transition_counts7 = zeros(num_states);
for i = 1:length(group_data)-7
    transition_counts7(group_data(i), group_data(i+7)) = transition_counts7(group_data(i), group_data(i+7)) + 1;
end
disp('Transition counts 7:');
disp(transition_counts7);
transition_matrix7=transition_matrix^7;
disp('Transition Matrix 7:');
disp(transition_matrix7);

e2=transition_counts2*transition_matrix2
e3=transition_counts3*transition_matrix3
e4=transition_counts4*transition_matrix4
e5=transition_counts5*transition_matrix5
e6=transition_counts6*transition_matrix6
e7=transition_counts7*transition_matrix7

%% Chi_square

observed_matrix=e6;
expected_matrix = sum(observed_matrix, 2) * sum(observed_matrix) / sum(sum(observed_matrix));
chi_square_stat = sum(sum((observed_matrix - expected_matrix).^2 ./ expected_matrix));
degrees_of_freedom = (size(observed_matrix, 1) - 1) * (size(observed_matrix, 2) - 1);
alpha = 0.05;
critical_value = chi2inv(1 - alpha, degrees_of_freedom);

disp(['Chi-square test statistic: ', num2str(chi_square_stat)]);
disp(['Degrees of freedom: ', num2str(degrees_of_freedom)]);
disp(['Critical value: ', num2str(critical_value)]);






