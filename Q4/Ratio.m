A = [-4, -0.2; 10, -10];
B = [2; 0];
C = [0, 1]; 
D = 0;

% Using 50 points between 0.1 and 10 for a smooth curve
ratio_range = linspace(0.1, 10, 50);
rise_times = zeros(length(ratio_range), 1);
overshoots = zeros(length(ratio_range), 1);
Q11 = 1; %(small penalty on current)

for i = 1:length(ratio_range)
    R = 1;
    Q22 = ratio_range(i) * R;
    Q = [Q11, 0; 
         0, Q22];
    K = lqr(A, B, Q, R);
    A_cl = A - B*K;
    sys_cl = ss(A_cl, B, C, D);
    info = stepinfo(sys_cl);
    rise_times(i) = info.RiseTime;
    overshoots(i) = info.Overshoot;
end

figure;
subplot(2,1,1);
plot(ratio_range, rise_times, 'b-', 'LineWidth', 2);
title('Effect of Q_{22}/R Ratio on Rise Time');
xlabel('Ratio (Q_{22} / R)');
ylabel('Rise Time (seconds)');
grid on;

subplot(2,1,2);
plot(ratio_range, overshoots, 'r-', 'LineWidth', 2);
title('Effect of Q_{22}/R Ratio on Overshoot');
xlabel('Ratio (Q_{22} / R)');
ylabel('Overshoot (%)');
grid on;