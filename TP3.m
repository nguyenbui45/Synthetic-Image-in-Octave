Im=zeros(256,256);

%Define 4 points
pointPairs=zeros(4,2);
pointPairs(1,:)=[50 50];
pointPairs(2,:)=[60 50];
pointPairs(3,:)=[60 60];
pointPairs(4,:)=[50 60];

L1=drawPolygon(Im,pointPairs,1);
%L2=animationFourPointsPolygon(L1,pointPairs,4);
%L3=animationFourPointsPolygonRotation(L1,pointPairs,30);
L4=animationFourPointsPolygon(L1,pointPairs,4,30);
%figure("Name","Drawing polygon")
%imshow(L1);
%title("Polygon image");

