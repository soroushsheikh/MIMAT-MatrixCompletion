% Comparison of Matrix Completion Algorithms: MIMAT, SVT, and FPC
%{
    This code has been developed to compare the relative recovery error of the following algorithms:
      MIMAT
      SVT
      FPC
%}

clear;
clc;

% Initialize arrays
results = zeros(42, 4);
averages = zeros(42, 4);
iterations = 30;
startPercent = 15;
endPercent = 91;
stepPercent = 2;

% % MIMAT algorithm
% for index = 1:iterations
%     i = 1;
%     for percent = startPercent:stepPercent:endPercent
%         error = MIMATDriver(percent, index);
%         results(i, 1) = 100 - percent;
%         results(i, 2) = error * 100;
%         i = i + 1;
%     end
%     averages(:, 2) = averages(:, 2) + results(:, 2);
% end
% averages(:, 2) = averages(:, 2) / iterations;

% SVT algorithm
% for index = 1:(iterations / 5)
%     i = 1;
%     for percent = startPercent:stepPercent:endPercent
%         error = SVTDriver(percent);
%         results(i, 1) = 100 - percent;
%         results(i, 3) = error * 100;
%         i = i + 1;
%     end
%     averages(:, 3) = averages(:, 3) + results(:, 3);
% end
% averages(:, 3) = averages(:, 3) / (iterations / 5);

% FPC algorithm
for index = 1:(iterations / 10)
    i = 1;
    for percent = startPercent:stepPercent:endPercent
        error = FPCDriver(percent);
        results(i, 1) = 100 - percent;
        results(i, 4) = error * 100;
        i = i + 1;
    end
    averages(:, 4) = averages(:, 4) + results(:, 4);
end
averages(:, 4) = averages(:, 4) / (iterations / 10);

% Show results
figure;
hold on;
grid on;
plot(results(:, 1), averages(:, 2), 'LineWidth', 2, 'DisplayName', 'MIMAT');
plot(results(:, 1), averages(:, 3), '--', 'LineWidth', 2, 'DisplayName', 'SVT');
plot(results(:, 1), averages(:, 4), '-.', 'LineWidth', 2, 'DisplayName', 'FPC');
xlabel('Percent Completion');
ylabel('Relative Recovery Error (%)');
legend('show');