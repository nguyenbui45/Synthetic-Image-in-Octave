function L=drawCircleAnimation(Im,centerPoint,radius,option,clockwise)
    switch (option)
	case"naive"
	    L=naiveAlgorithmAnimation(Im,centerPoint,radius,clockwise);
	case "middle"
	    L=middlePointAlgorithmAnimation(Im,centerPoint,radius,clockwise);
	case "bresenham"
	    L=bresenhamAlgorithmAnimation(Im,centerPoint,radius,clockwise);
	case "bresenhamAny"
	    L=bresenhamAlgorithmAnimationAny(Im,centerPoint,radius);
	case "xiaolin"
	    L=xiaolinAlgorithm(Im,centerPoint,radius,clockwise);
	otherwise
	    error("option parameter should be one of these string 'naive','middle','bresenham','xiaolin' ");
    endswitch

endfunction


%2. Naive algorithm WITH mse calculation
function L=naiveAlgorithm(Im,centerPoint,radius,clockwise)
    L=Im(:,:);
    % declare the vector to store practicalY and its index
    i=1; % y of start point
    %find the xmax
    xmax = 1+cos(pi/4)*radius;
    % declare the vector to store practicalY and its index
    for j=1:1:xmax
	i=round(sqrt(power(radius+1,2) - power(j,2)));
	L(i+centerPoint(2),j+centerPoint(1))=1;
	L(-i+1+centerPoint(2),-j+1+centerPoint(1))=1;
	L(-i+1+centerPoint(2),j+centerPoint(1))=1;
	L(i+centerPoint(2),-j+1+centerPoint(1))=1;
	
	L(j+centerPoint(2),i+centerPoint(1))=1;
	L(-j+1+centerPoint(2),-i+1+centerPoint(1))=1;
	L(-j+1+centerPoint(2),i+centerPoint(1))=1;
	L(j+centerPoint(2),-i+1+centerPoint(1))=1;
    endfor
endfunction

%3. Midde point algorithm
function L=middlePointAlgorithmAnimation(Im,pointA,pointB,clockwise)
    L=Im(:,:);
    merr=0
	i=pointA(2);
	d= a+0.5*b; %-45
	for j=pointA(1):1:pointB(1)
	    if(swapFlag)
		L(j,i)=1;
	    else
		L(i,j)=1;
	    end
	    %disp([num2str(j) "," num2str(i)]);
	    if (d<0)
		i=i+1;
		d=d+a+b; % (y0 - y1) + (x1 - x0)
	    else
		d=d+a; % (y0-y1)
	    endif
	endfor
endfunction

%bresenham animation in clockwise
function L=bresenhamAlgorithmAnimation(Im,centerPoint,radius,clockwise)
    L=Im(:,:);
    pointAmount=round(radius*cos(pi/4));
    NxPy=zeros(pointAmount,2);
    NyPx=zeros(pointAmount,2);
    PxPy=zeros(pointAmount,2);
    PyPx=zeros(pointAmount,2);
    PxNy=zeros(pointAmount,2);
    PyNx=zeros(pointAmount,2);
    NxNy=zeros(pointAmount,2);
    NyNx=zeros(pointAmount,2);
    
    NxPyFlicker=[];
    NyPxFlicker=[];
    PxPyFlicker=[];
    PyPxFlicker=[];
    PxNyFlicker=[];
    PyNxFlicker=[];
    NxNyFlicker=[];
    NyNxFlicker=[];
    idx=1;

    d=3-2*(radius);
    j=0;
    i=radius;
   
    % param for animation
    windowWidth = size(Im,2);  % Get image width
    windowHeight = size(Im,1);  % Get image height
   
    f=figure("Name","Circle animation");
    axis([1 windowWidth 1 windowHeight]);
    hold on;
    
    %Assign plot to a frame
    frame = getframe(f);
    % Convert frame to RGB image (3 dimensional) 
    im = frame2im(frame);   
    % Transform RGB samples to 1 dimension with a color map "cm". 
    %[imIdx,map] = rgb2ind(im); 
    % Create GIF file
    %imwrite(im,"circleAnimationFlicker2.gif",'gif');
    
    while(j <= i)
	NxPy(idx,:)=[-i+centerPoint(2)+1,j+centerPoint(1)];
	NyPx(idx,:)=[-j+centerPoint(1)+1,i+centerPoint(2)];
	PyPx(idx,:)=[j+centerPoint(1),i+centerPoint(2)];
	PxPy(idx,:)=[i+centerPoint(2),j+centerPoint(1)];
	PxNy(idx,:)=[i+centerPoint(2),-j+centerPoint(1)+1];
	PyNx(idx,:)=[j+centerPoint(2),-i+centerPoint(1)+1];
	NyNx(idx,:)=[-j+centerPoint(1)+1,-i+centerPoint(2)+1];
	NxNy(idx,:)=[-i+centerPoint(2)+1,-j+centerPoint(1)+1];   
	if(i+centerPoint(2) == windowHeight || j + centerPoint(1) == windowWidth)
	    NxPyFlicker=[NxPyFlicker; [-i+centerPoint(2)+1,j+centerPoint(1)]];
	    NyPxFlicker=[NyPxFlicker;[-j+centerPoint(1)+1,i+centerPoint(2)]];
	    PyPxFlicker=[PyPxFlicker;[j+centerPoint(1),i+centerPoint(2)]];
	    PxPyFlicker=[PxPyFlicker;[i+centerPoint(2),j+centerPoint(1)]];
	    PxNyFlicker=[PxNyFlicker;[i+centerPoint(2),-j+centerPoint(1)+1]];
	    PyNxFlicker=[PyNxFlicker;[j+centerPoint(2),-i+centerPoint(1)+1]];
	    NyNxFlicker=[NyNxFlicker;[-j+centerPoint(1)+1,-i+centerPoint(2)+1]];
	    NxNyFlicker=[NxNyFlicker;[-i+centerPoint(2)+1,-j+centerPoint(1)+1]];
	endif

	idx+=1;
	if (d<0)
	    d=d+4*j+6;
	else
	    i=i-1;
	    d=d + 4*(j-i) +10;
	end
	j+=1;
	    

    endwhile
    %pixel value
    value=0.5;
    valueFlicker=1;
    f=1
    if(clockwise)
	L=plotCircle(L,NxPy,0,f,value);
	L=plotCircle(L,NyPx,1,f,value);
	L=plotCircle(L,PyPx,0,f,value);
	L=plotCircle(L,PxPy,1,f,value);
	L=plotCircle(L,PxNy,0,f,value);
	L=plotCircle(L,PyNx,1,f,value);
	L=plotCircle(L,NyNx,0,f,value);
	L=plotCircle(L,NxNy,1,f,value);
    else
	L=plotCircle(L,NxNy,0,f,value);
	L=plotCircle(L,NyNx,1,f,value);
	L=plotCircle(L,PyNx,0,f,value);
	L=plotCircle(L,PxNy,1,f,value);
	L=plotCircle(L,PxPy,0,f,value);
	L=plotCircle(L,PyPx,1,f,value);
	L=plotCircle(L,NyPx,0,f,value);
	L=plotCircle(L,NxPy,1,f,value);
    endif
    
    if(!clockwise)
	L=plotCircleFlicker(L,NxPyFlicker,0,f,valueFlicker,value);
	L=plotCircleFlicker(L,NyPxFlicker,1,f,valueFlicker,value);
	L=plotCircleFlicker(L,PyPxFlicker,0,f,valueFlicker,value);
	L=plotCircleFlicker(L,PxPyFlicker,1,f,valueFlicker,value);
	L=plotCircleFlicker(L,PxNyFlicker,0,f,valueFlicker,value);
	L=plotCircleFlicker(L,PyNxFlicker,1,f,valueFlicker,value);
	L=plotCircleFlicker(L,NyNxFlicker,0,f,valueFlicker,value);
	L=plotCircleFlicker(L,NxNyFlicker,1,f,valueFlicker,value);
    else
	L=plotCircleFlicker(L,NxNyFlicker,0,f,valueFlicker,value);
	L=plotCircleFlicker(L,NyNxFlicker,1,f,valueFlicker,value);
	L=plotCircleFlicker(L,PyNxFlicker,0,f,valueFlicker,value);
	L=plotCircleFlicker(L,PxNyFlicker,1,f,valueFlicker,value);
	L=plotCircleFlicker(L,PxPyFlicker,0,f,valueFlicker,value);
	L=plotCircleFlicker(L,PyPxFlicker,1,f,valueFlicker,value);
	L=plotCircleFlicker(L,NyPxFlicker,0,f,valueFlicker,value);
	L=plotCircleFlicker(L,NxPyFlicker,1,f,valueFlicker,value);
    endif

endfunction

%plot function
function L=plotCircle(L,circlePoint,fromback,fig,value)
    if (!fromback)
	for ite=1:1:size(circlePoint)(1)
	    L(circlePoint(ite,2),circlePoint(ite,1))=value;
	endfor
    else
	for ite=size(circlePoint)(1):-1:1
	    L(circlePoint(ite,2),circlePoint(ite,1))=value;
	endfor
    endif
	    imshow(L);
	    drawnow;
	    frame = getframe(fig);
	    im = frame2im(frame);   
	    [imIdx,map] = rgb2ind(im); 
	    imwrite(im,"circleAnimationFlicker2.gif",'gif','WriteMode','append');
endfunction

%plot flickering function
function L=plotCircleFlicker(L,circlePoint,fromback,fig,valueFlicker,value)
    if (!fromback)
	for ite=1:1:size(circlePoint)(1)
	    if(ite == 1)
		L(circlePoint(ite,2),circlePoint(ite,1))=valueFlicker;
	    % draw the image
	    else
		L(circlePoint(ite,2),circlePoint(ite,1))=valueFlicker;
		L(circlePoint(ite-1,2),circlePoint(ite-1,1))=value;
	    endif

	    imshow(L);
	    drawnow;
	    
	    frame = getframe(fig);
	    im = frame2im(frame);   
	    [imIdx,map] = rgb2ind(im); 
	    imwrite(im,"circleAnimationFlicker2.gif",'gif','WriteMode','append');
	    
	endfor
	L(circlePoint(size(circlePoint)(1),2),circlePoint(size(circlePoint)(1),1))=value;

    else
	for ite=size(circlePoint)(1):-1:1
	    if(ite == size(circlePoint)(1))
		L(circlePoint(ite,2),circlePoint(ite,1))=valueFlicker;
	    else
		L(circlePoint(ite,2),circlePoint(ite,1))=valueFlicker;
		L(circlePoint(ite+1,2),circlePoint(ite+1,1))=value;
	    endif
	    % draw the image
	    imshow(L);
	    drawnow;
	   
	    frame = getframe(fig);
	    im = frame2im(frame);   
	    [imIdx,map] = rgb2ind(im); 
	    imwrite(im,"circleAnimationFlicker2.gif",'gif','WriteMode','append');
	endfor
	L(circlePoint(1,2),circlePoint(1,1))=value;
    endif
endfunction


% Draw circle in any direction
function [L,merr]=bresenhamAlgorithmAnimationAny(Im,centerPoint,radius)
    L=Im(:,:);

    d=3-2*radius;
    j=0;
    i=radius;
    windowWidth = size(Im,2);  % Get image width
    windowHeight = size(Im,1);  % Get image height

    f=figure("Name","Circle animation");
    axis([1 100 1 100]);
    hold on;
    % Create the time axis
    
    %Assign plot to a frame
    %frame = getframe(f);
    % Convert frame to RGB image (3 dimensional) 
    %im = frame2im(frame);   
    % Transform RGB samples to 1 dimension with a color map "cm". 
    %[imIdx,map] = rgb2ind(im); 
    % Create GIF file
    %imwrite(imIdx,map,"circleAnimationAny.gif",'gif','DelayTime', 0.001);
    while(j <= i)
	L = plotPoint(L,centerPoint,j,i,0.5);
	if (d<0)
	    d=d+4*j+6;
	else
	    i=i-1;
	    d=d + 4*(j-i) +10;
	end
	j+=1;

	% draw the image
	imshow(L);
	drawnow;
	%pause(0.01);
	    %frame = getframe(f);
	    %im = frame2im(frame);   
	    %[imIdx,map] = rgb2ind(im); 
	    %imwrite(imIdx,map,"circleAnimationAny.gif",'gif','WriteMode','append','DelayTime', 0.001 , 'Compression' , 'lzw');
	
    endwhile
    
endfunction

function L=plotPoint(L,centerPoint,i,j,value)
	L(i+centerPoint(2),j+centerPoint(1))=1;
	L(-i+1+centerPoint(2),-j+1+centerPoint(1))=1;
	L(-i+1+centerPoint(2),j+centerPoint(1))=1;
	L(i+centerPoint(2),-j+1+centerPoint(1))=1;
	
	L(j+centerPoint(2),i+centerPoint(1))=1;
	L(-j+1+centerPoint(2),-i+1+centerPoint(1))=1;
	L(-j+1+centerPoint(2),i+centerPoint(1))=1;
	L(j+centerPoint(2),-i+1+centerPoint(1))=1;
endfunction

