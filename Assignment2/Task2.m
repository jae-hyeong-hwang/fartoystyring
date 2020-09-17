%%

close all; 
A = [   -0.322  0.052   0.028   -1.12   0.002;
        0       0       1       -0.001  0;
        -10.6   0       -2.87   0.46    -0.65;
        6.87    0       -0.04   -0.32   -0.02;
        0       0       0       0       -7.5];

a_p1 = -A(3,3);
a_p2 = A(3,5);

k_dp1 = 1;
d = deg2rad(1.5);

pSys = tf([a_p2], [1, a_p1]);
pFeedbackLoop = pSys/(1+k_dp1*pSys);
figure();
rlocus(pFeedbackLoop);
%%
k_dp = 500*k_dp1;
pFeedbackLoop = pSys/(1+k_dp*pSys);

k_ip1 = 0.7
k_pp1 = 1


phiController = tf([k_ip1], [1, 0])+ k_pp1;
phiFeedbackLoop = phiController*pFeedbackLoop/(1+phiController*pFeedbackLoop)
rlocus(phiFeedbackLoop);
%%
gain = 400;
k_ip = gain*k_ip1;
k_pp = gain*k_pp1;

phiController = tf([k_ip], [1, 0])+ k_pp;
phiFeedbackLoop = phiController*pFeedbackLoop/(1+phiController*pFeedbackLoop)

k_ic1 = 0.7;
k_pc1 = 1;
chiController = tf([k_ic1], [1, 0])+ k_pc1;
chiFeedbackLoop = chiController*phiFeedbackLoop/(1+chiController*phiFeedbackLoop)
rlocus(chiFeedbackLoop);
k_ic = gain*k_ic1;
k_pc = gain*k_pc1;

