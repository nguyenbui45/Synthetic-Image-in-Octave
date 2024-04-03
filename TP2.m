% Testing
%1. Create a zero map
I=zeros(256,256);
%2. Point A(1,1) and B(50,50)
center=[128,128];
%theoryYNaive=[22,24,26,28,30];
%theoryYBresenham=[10,10,11,11,12,12,13,13,14,14,15];
%A=[10,20];
%B=[50,80];

%[L1,merr]=drawCircle(I,center,50,'naive',zeros(1,36));
%disp(["Mean squared error for naive algorithm:" num2str(merr)])
%L2=drawCircle(I,center,20,'middle',zeros(1,15));
%L3=drawCircle(I,center,50,'bresenham',zeros(1,36));
%L4=drawCircleAnimation(I,center,50,'bresenham',1);
L4=drawCircleAnimation(I,center,128,'bresenhamAny');
%[L3,merr]=drawLine(I,A,B,'bresenham',[]);
%disp(["Mean squared error for Bresenham algorithm:" num2str(merr)])

%figure("Name","Draw a line")
%subplot(1,3,1);
%imshow(L1);
%title("Drawing a line by naive algorithm");

%figure("Name","Draw a line")
%subplot(1,3,2)
%imshow(L4);
%title("Drawing a line by middle point algorithm");

%figure("Name","Draw a line")
%subplot(1,3,3)
imshow(L3);
%title("Drawing a line by Brehenham algorithm");
