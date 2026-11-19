A = [-4, -0.2; 10, -10];
B = [2; 0];
C = [0, 1]; 
D = 0;
Q = [1, 0; 
     0, 1]; 
R = 100;         

[K_star, P, E] = lqr(A, B, Q, R);

disp('Optimal Gain Matrix K*:');
disp(K_star);

A_cl = A - B*K_star;
closed_loop_poles = eig(A_cl);

disp('Closed-Loop Poles:');
disp(closed_loop_poles);

sys_cl = ss(A_cl, B, C, D);
figure;
step(sys_cl);
title('Closed-Loop Step Response - Effort Priority');
xlabel('Time (seconds)');
ylabel('Angular Velocity \omega (rad/s)');
grid on;