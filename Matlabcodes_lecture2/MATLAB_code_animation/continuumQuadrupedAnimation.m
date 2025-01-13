function []= continuumQuadrupedAnimation()

clc;
n=20;
[L1,L2,L3,L4]=tragGen_discnt_gait(n);
L1=[L1 L1];
L2=[L2 L2];
L3=[L3 L3];
L4=[L4 L4];

% Generate transformation matrices for each leg
Tr1=TrArm(.075,-.12,pi/2,0);
Tr2=TrArm(-.075,-.12,-pi/2,pi);
Tr3=TrArm(-.075,.12,-pi/2,pi);
Tr4=TrArm(.075,.12,pi/2,0);
T=[zeros(1,12*n);
    .1*ones(1,2*n) .1-.045*linspace(0,1,n) .055*ones(1,2*n) .055-.045*linspace(0,1,n) .01*ones(1,2*n) .01-.045*linspace(0,1,n) -.035*ones(1,2*n) -.035-.045*linspace(0,1,n);
    .12*ones(1,12*n)];

name='test.avi';

scrsz = get(0,'ScreenSize');
figure('Position',[1 scrsz(4)/3 scrsz(3)/3 scrsz(4)/3],'visible','on')
writerObj=VideoWriter(name);
writerObj.FrameRate=10;
open(writerObj);

%animation
for i=1:12*n % 2*n times for cyclic leg movements
    voxel(T(:,i)'+[-.075 -.15 -.02],[.15 .3 .04],'r',.5); % draw the box
    axis('equal')
    axis([-.4 .4 -.5 .5  -.02 0.16 ])
    set(gca,'xticklabel',[],'yticklabel',[],'zticklabel',[])
    grid on
    view(30,15);
    tmpT=[1 0 0 T(1,i);
        0 1 0 T(2,i);
        0 0 1 T(3,i);
        0 0 0 1];
    hold on;
    
    drawArm(L1(:,i),tmpT*Tr1,15,.0125,'summer');
    drawArm(L2(:,i),tmpT*Tr2,15,.0125,'summer');
    drawArm(L3(:,i),tmpT*Tr3,15,.0125,'summer');
    drawArm(L4(:,i),tmpT*Tr4,15,.0125,'summer');
    
    hold off;
    
    cdata = print('-RGBImage');
    
    % writ the figure to the video object
    writeVideo(writerObj,im2frame(cdata));
    clf;
    
end
close(writerObj);
close all;

    function T=TrArm(x,y,thetay,phiz)
        T=[1 0 0 0;0 1 0 y;0 0 1 0;0 0 0 1]*[1 0 0 x;0 1 0 0;0 0 1 0;0 0 0 1]*[cos(thetay) 0 sin(thetay) 0;0 1 0 0; -sin(thetay) 0 cos(thetay) 0;0 0 0 1]*[cos(phiz) -sin(phiz) 0 0;sin(phiz) cos(phiz) 0 0;0 0 1 0;0 0 0 1];
    end

    function drawArm(y,Tr,n,SecRadius,cmap)
        set(gca,'nextplot','replacechildren','FontSize',18,'fontweight','b');
        
        x=zeros(3,n);
        xi=linspace(0,1,n);
        
        for k=1:n
            tmp=Tr*[P(y,xi(k));1];
            x(:,k)=tmp(1:3);
        end
        
        for k=1:n-1
            R=SecRadius;
            [X,Y,Z]=cylinder2P(R, 15,x(:,k)',x(:,k+1)');
            colormap(cmap)
            hold on;
            surf(X,Y,Z);
        end
    end

    function  [L1,L2,L3,L4]=tragGen_discnt_gait(n)
        
        L1=genJointLength(n,1,5);
        L2=genJointLength(n,2,6);
        L3=genJointLength(n,2,3);
        L4=genJointLength(n,1,5);
        % STEP 2
        L1=[L1 genJointLength(n,1,5)];
        L2=[L2 genJointLength(n,2,3)];
        L3=[L3 genJointLength(n,2,4)];
        L4=[L4 genJointLength(n,1,5)];
        % STEP 3
        L1=[L1 genJointLength(n,1,2)];
        L2=[L2 genJointLength(n,2,1)];
        L3=[L3 genJointLength(n,2,1)];
        L4=[L4 genJointLength(n,1,2)];
        % STEP 4
        L1=[L1 genJointLength(n,1,6)];
        L2=[L2 genJointLength(n,2,5)];
        L3=[L3 genJointLength(n,2,5)];
        L4=[L4 genJointLength(n,1,3)];
        % STEP 5
        L1=[L1 genJointLength(n,1,3)];
        L2=[L2 genJointLength(n,2,5)];
        L3=[L3 genJointLength(n,2,5)];
        L4=[L4 genJointLength(n,1,4)];
        % STEP 6
        L1=[L1 genJointLength(n,1,1)];
        L2=[L2 genJointLength(n,2,2)];
        L3=[L3 genJointLength(n,2,2)];
        L4=[L4 genJointLength(n,1,1)];
    end

    function y=genJointLength(n,legNo,MovNo)
        
        t=linspace(0,1,n);
        y=zeros(3,n);
        switch legNo
            case 1
                switch MovNo
                    case 1
                        t=t/2;
                        y(1,:)=0.03979*t.^2-0.04159*t+0.01981;
                        y(2,:)=0.03666*t.^2-0.04881*t+0.04879;
                        y(3,:)=0.03665*t.^2-0.02795*t+0.03823;
                    case 2
                        t=.5+t/2;
                        y(1,:)=0.03979*t.^2-0.04159*t+0.01981;
                        y(2,:)=0.03666*t.^2-0.04881*t+0.04879;
                        y(3,:)=0.03665*t.^2-0.02795*t+0.03823;
                    case 3
                        y(1,:)=0.0018*t+0.0180;
                        y(2,:)=0.03665*t.^2-0.02795*t+0.03823;
                        y(3,:)=0.03666*t.^2-0.04881*t+0.04879;
                    case 4
                        y(1,:)=0.01981*ones(1,n);
                        y(2,:)=0.04879*ones(1,n);
                        y(3,:)=0.03823*ones(1,n);
                    case 5
                        y(1,:)=0.0090*ones(1,n);
                        y(2,:)=0.0335*ones(1,n);
                        y(3,:)=0.0334*ones(1,n);
                    case 6
                        y(1,:)=0.0180*ones(1,n);
                        y(2,:)=0.03823*ones(1,n);
                        y(3,:)=0.04879*ones(1,n);
                end
            case 2
                switch MovNo
                    case 1
                        t=t/2;
                        y(1,:)=0.03979*t.^2-0.03799*t+0.01801;
                        y(2,:)=0.03665*t.^2-0.02795*t+0.03823;
                        y(3,:)=0.03666*t.^2-0.04881*t+0.04879;
                    case 2
                        t=.5+t/2;
                        y(1,:)=0.03979*t.^2-0.03799*t+0.01801;
                        y(2,:)=0.03665*t.^2-0.02795*t+0.03823;
                        y(3,:)=0.03666*t.^2-0.04881*t+0.04879;
                    case 3
                        y(1,:)=-0.0018*t+0.01981;
                        y(2,:)=0.03666*t.^2-0.04881*t+0.04879;
                        y(3,:)=0.03665*t.^2-0.02795*t+0.03823;
                    case 4
                        y(1,:)=0.01801*ones(1,n);
                        y(2,:)=0.03823*ones(1,n);
                        y(3,:)=0.04879*ones(1,n);
                    case 5
                        y(1,:)=0.0090*ones(1,n);
                        y(2,:)=0.0334*ones(1,n);
                        y(3,:)=0.0335*ones(1,n);
                    case 6
                        y(1,:)=0.0198*ones(1,n);
                        y(2,:)=0.04879*ones(1,n);
                        y(3,:)=0.03823*ones(1,n);
                end
            otherwise
        end
    end
end

