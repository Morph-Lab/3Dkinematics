theta = 30; %rotation angle

aRb = [cosd(30) -sind(30) 0;...
     sind(30) cosd(30) 0;...
     0 0 1] % The rotation matrix from frame B to frame A
 
aPb = [10;5;0] %The vector to the origin of frame B from the origin of frame A

aTb = [aRb aPb;...
       zeros(1,3) 1] %The transformation matrix from frame B to frame A
   
Pb = [3;7;0;1]

Pa = aTb*Pb

plot([0 aPb(1)],[0 aPb(2)],'r','linewidth',3);
hold on
plot([aPb(1) Pa(1)],[aPb(2) Pa(2)],'b','linewidth',3);
plot([0 Pa(1)],[0 Pa(2)],'g','linewidth',3);
xlabel('x');
ylabel('y')
legend('aPb','Pb','Pa','Location','NorthWest')
set(gca,'fontsize',18)
 