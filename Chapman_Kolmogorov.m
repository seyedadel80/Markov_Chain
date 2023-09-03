clc
clear all
close all

%% Calculation Of Transition Matrix:

ping = xlsread("ping_results.xlsx");
data= ping([1:5000], 2:2);

% Calculate the mean and standard deviation of the data
mean_val = mean(data);
std_val = std(data);

% Define the group boundaries
boundaries = [mean_val + 0.25*std_val, mean_val + 0.125*std_val, mean_val, mean_val - 0.125*std_val, mean_val - 0.25*std_val];

group_indices = zeros(size(data));
group_indices(data > boundaries(1)) = 1; % Group 1
group_indices(data > boundaries(2) & data <= boundaries(1)) = 2; % Group 2
group_indices(data > boundaries(3) & data <= boundaries(2)) = 3; % Group 3
group_indices(data > boundaries(4) & data <= boundaries(3)) = 4; % Group 4
group_indices(data > boundaries(5) & data <= boundaries(4)) = 5; % Group 5
group_indices(data <= boundaries(5)) = 6; % Group 6
group_data = group_indices;

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

%% Calculation Of Second Order Transition Matrix:

data = group_data';
transition_counts2 = zeros(num_states);
for i = 1:length(group_data)-2
    transition_counts2(group_data(i), group_data(i+2)) = transition_counts2(group_data(i), group_data(i+2)) + 1;
end
secondOrderMatrix = transition_counts2 ./ sum(transition_counts2, 2);

disp('Second Order Transition counts:');
disp(transition_counts2);
disp('Second Order Transition Matrix:');
disp(secondOrderMatrix);

%% Check The Chapman-Kolmogorov Equation:

s=0;
p = 0;
t = 1;
Result = 1;
for i = 1:num_states
    for j = 1:num_states
        for k = 1:num_states
            p1 = transition_matrix(i, k);
            p2 = transition_matrix(k, j);
            a = p1 * p2;
            p = p + a;
            a=0;
        end
        p3 = secondOrderMatrix(i,j);
        
        s= s+abs(p - p3);
        
        plot(t, p, 'r.');
        hold on
        plot(t, p3, 'b.');
        plot(t, abs(p - p3), 'go');
        % M2(i,j) = zigma( M(i,k)M(k,j) )
        
        legend('M(i,k)M(k,j)', 'M2(i,j)', 'Error');
        grid on;
        
        if abs(p - p3) > 0.1
            Result = 0;
        end
        p = 0;
        t = t + 1;
    end
end

if Result
    disp('The data exhibits Markovian characteristics.');
else
    disp('The data does not exhibit Markovian characteristics.');
end




