% Testing
%1. Create a zero map
I=zeros(100,100);
%2. Point A(1,1) and B(50,50)
A=[10,20];
B=[15,30];
theoryYNaive=[22,24,26,28,30];
theoryYBresenham=[10,10,11,11,12,12,13,13,14,14,15];
%A=[10,20];
%B=[50,80];

[L1,merr]=drawLine(I,A,B,'naive',theoryYNaive);
disp(["Mean squared error for naive algorithm:" num2str(merr)])
L2=drawLine(I,A,B,'middle',[]);
[L3,merr]=drawLine(I,A,B,'bresenham',theoryYBresenham);
disp(["Mean squared error for Bresenham algorithm:" num2str(merr)])

figure("Name","Draw a line")
%subplot(1,3,1);
imshow(L1);
title("Drawing a line by naive algorithm");

figure("Name","Draw a line")
%subplot(1,3,2)
imshow(L2);
title("Drawing a line by middle point algorithm");

figure("Name","Draw a line")
%subplot(1,3,3)
imshow(L3);
title("Drawing a line by Brehenham algorithm");
