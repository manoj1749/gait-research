% Define the folder structure
folder = '/Users/manoj/Documents/mind-and-brain/Final_Dataset/Abhay';
files = {'LA.csv', 'LH.csv', 'LK.csv', 'RA.csv', 'RH.csv', 'RK.csv'};
fullPaths = fullfile(folder, files);

% Sampling frequency
Fs = 100; % adjust based on your data
window_size = 5; % for moving average filter

% Design low pass Butterworth filter
[b, a] = butter(4, 5/(Fs/2), 'low'); % 5 Hz cutoff frequency

data = [];

% Load and process the data
for i = 1:length(fullPaths)
    fileData = readtable(fullPaths{i}, 'VariableNamingRule', 'preserve');
    
    % Display variable names to check how they were truncated
    disp(fileData.Properties.VariableNames);
    
    % Access the columns using the original names from VariableDescriptions
    time_var = 'Time (s)';
    accel_vars = {'X (m/s2)', 'Y (m/s2)', 'Z (m/s2)'};
    angle_var = 'Theta (deg)';
    
    % Find the indices of the variables in the table
    time_idx = find(strcmp(fileData.Properties.VariableDescriptions, time_var));
    accel_idxs = find(contains(fileData.Properties.VariableDescriptions, accel_vars));
    angle_idx = find(strcmp(fileData.Properties.VariableDescriptions, angle_var));
    
    % Access the columns using the found indices
    time = fileData{:, time_idx};
    accel_data = fileData{:, accel_idxs};
    angle_data = fileData{:, angle_idx};
    
    % Filter data
    filtered_angle = filtfilt(b, a, angle_data);
    filtered_angle = movmean(filtered_angle, window_size);
    
    data = [data; filtered_angle];
end

% Prepare input and target data for the neural network
input_data = [];
target_data = [];
for i = 1:length(data) - 101
    input_data = [input_data; data(i:i+99)'];
    target_data = [target_data; data(i+100)];
end

% Split data into training (60%), validation (20%), and testing (20%)
num_samples = size(input_data, 1);
idx = randperm(num_samples);
train_idx = idx(1:round(0.6*num_samples));
val_idx = idx(round(0.6*num_samples)+1:round(0.8*num_samples));
test_idx = idx(round(0.8*num_samples)+1:end);

train_input = input_data(train_idx, :);
train_target = target_data(train_idx, :);
val_input = input_data(val_idx, :);
val_target = target_data(val_idx, :);
test_input = input_data(test_idx, :);
test_target = target_data(test_idx, :);

% Create and train neural network
net = feedforwardnet(10, 'trainlm');
net.divideParam.trainRatio = 0.6;
net.divideParam.valRatio = 0.2;
net.divideParam.testRatio = 0.2;
net.trainParam.epochs = 1000;

try
    net = train(net, train_input', train_target', 'useParallel', 'yes');
    
    % Test neural network
    predicted_output = net(test_input');
    
    % Debugging: Check predicted_output structure and content
    disp(class(predicted_output));
    disp(size(predicted_output));

    % Ensure predicted_output is numeric
    if isstruct(predicted_output)
        error('predicted_output is a structure. Check net architecture or test data.');
    end
    
    mse = mean((predicted_output - test_target').^2);
    fprintf('Mean Squared Error: %.4f\n', mse);

    % Validate with Pearson's correlation coefficient
    [r, p] = corr(predicted_output', test_target');
    fprintf('Pearson Correlation: r = %.4f, p = %.4e\n', r, p);

    % Plot actual vs predicted
    figure;
    plot(test_target, 'b');
    hold on;
    plot(predicted_output, 'r');
    title('Actual vs Predicted Gait Angles');
    xlabel('Time (samples)');
    ylabel('Angle (degrees)');
    legend('Actual', 'Predicted');
    hold off;
    
catch ME
    disp(getReport(ME));
end
