A = [-4, -0.2; 10, -10];
B = [2; 0];
C = [0, 1]; 
D = 0;

% DESIGN 1: SPEED PRIORITY
Q1 = [1, 0; 
      0, 1000]; 
R1 = 1;         
[K1, P1, E1] = lqr(A, B, Q1, R1);
A_cl1 = A - B*K1;
sys_cl1 = ss(A_cl1, B, C, D);

% DESIGN 2: EFFORT PRIORITY
Q2 = [1, 0; 
      0, 1]; 
R2 = 100;     
[K2, P2, E2] = lqr(A, B, Q2, R2);
A_cl2 = A - B*K2;
sys_cl2 = ss(A_cl2, B, C, D);

disp('--- Design 1: Speed Priority ---');
disp('Optimal Gain Matrix K*:');
disp(K1);
disp('Closed-Loop Poles:');
disp(E1);
disp('--- Design 2: Effort Priority ---');
disp('Optimal Gain Matrix K*:');
disp(K2);
disp('Closed-Loop Poles:');
disp(E2);

figure;
step(sys_cl1, 'r', sys_cl2, 'b');
title('LQR Step Response: Speed vs. Effort Priority');
xlabel('Time (seconds)');
ylabel('Angular Velocity \omega (rad/s)');
legend('Design 1: Speed Priority (Fast/High Voltage)', 'Design 2: Effort Priority (Slow/Low Voltage)', 'Location', 'Southeast');
grid on;