% "abbIrb120" ?? ABB IRB 120 6-axis robot
% "abbIrb120T" ?? ABB IRB 120T 6-axis robot
% "kinovaGen3" ?? KINOVA® Gen3 robot
% "kinovaJacoJ2N6S200" ?? KINOVA JACO® 2-fingered 6 DOF robot with non-spherical wrist
% "kinovaJacoJ2N6S300" ?? KINOVA JACO® 3-fingered 6 DOF robot with non-spherical wrist
% "kinovaJacoJ2N7S300" ?? KINOVA JACO® 3-fingered 7 DOF robot with non-spherical wrist
% "kinovaJacoJ2S6S300" ?? KINOVA JACO® 3-fingered 6 DOF robot with spherical wrist
% "kinovaJacoJ2S7S300" ?? KINOVA JACO® 3-fingered 7 DOF robot with spherical wrist
% "kinovaJacoTwoArmExample" ?? Two KINOVA JACO® 3 Fingered 6 DOF robots with non-spherical wrist
% "kinovaMicoM1N4S200" ?? KINOVA MICO® 4 DOF 2-fingered robot
% "kinovaMicoM1N6S200" ?? KINOVA MICO® 6 DOF 2-fingered robot
% "kinovaMicoM1N6S300" ?? KINOVA MICO® 6 DOF 3-fingered robot
% "rethinkBaxter" ?? Rethink Robotics Baxter 2-armed robot
% "willowgaragePR2" ??Willow Garage PR2 2-armed robot

gen3 = loadrobot('kinovagen3');
show(gen3);