function L=drawLine(Im,pointA,pointB,option)
    switch (option)
	case"naive"
	    L=naiveAlgorithm(Im,pointA,pointB);
	case "middle"
	    L=middlePointAlgorithm(Im,pointA,pointB);
	case "bresenham"
	    L=bresenhamAlgorithm(Im,pointA,pointB);
	case "xiaolin"
	    L=xiaolinAlgorithm(Im,pointA,pointB);
	otherwise
	    error("option parameter should be one of these string 'naive','middle','bresenham','xiaolin' ");
    endswitch

endfunction

%swap function
function [element2,element1]=swap(element1,element2)
endfunction

%calculate mean squared error
function merr=mse(theoryY,practicalY)
    merr=mean(power(theoryY-practicalY,2));
endfunction

%2. Naive algorithm WITH mse calculation
function L=naiveAlgorithm(Im,pointA,pointB)
    L=Im(:,:);
    if(pointB(1) == pointA(1)) % x1=x2 => vertical line
	for i=pointA(2):1:pointB(2)
	    L(i,pointA(1))=1;
	endfor
    elseif(pointB(2) == pointA(2)) %y1=y2 => case horizontal line
	for j=pointA(1):1:pointB(1)
	    L(pointA(1),j)=1;
        endfor
    else %normal case
	a = (pointB(2) - pointA(2))/(pointB(1) - pointA(1));
	b = pointA(2) - a*pointA(1);
	swapFlag=0;
	if(pointA(1) > pointB(1))
	    [pointA(1),pointB(1)]=swap(pointA(1),pointB(1));
	    [pointA(2),pointB(2)]=swap(pointA(2),pointB(2));
	    swapFlag=1;
	endif

	% recalculate a and b if change happend 
	if (swapFlag)
	    a = (pointB(2) - pointA(2))/(pointB(1) - pointA(1));
	    b = pointA(2) - a*pointA(1);
	endif
	
	% declare the vector to store practicalY and its index
	i=pointA(2);
	L(i,pointA(1))=1;
	for j=pointA(1)+1:1:pointB(1)
	    i=round(i+a);
	    L(i,j)=1;
	endfor
	 %merr=mse(theoryY,practicalY);
    endif
endfunction

%3. Midde point algorithm
function L=middlePointAlgorithm(Im,pointA,pointB)
    L=Im(:,:);
    merr=0
    if(pointB(1) == pointA(1)) % x1=x2 => vertical line
	for i=pointA(2):1:pointB(2)
	    L(i,pointA(1))=1;
	endfor
    elseif(pointB(2) == pointA(2)) %y1=y2 => case horizontal line
	for j=pointA(1):1:pointB(1)
	    L(pointA(1),j)=1;
	endfor
    else %normal case
	a=(pointA(2)-pointB(2)); % y0 - y1
	b=(pointB(1) - pointA(1)); % x1 - x0
	swapFlag=0;
	% check if the line is draw from right to left, we swap the starting point and ending point
	if(pointA(1) > pointB(1))
	    [pointA(1),pointB(1)]=swap(pointA(1),pointB(1));
	    [pointA(2),pointB(2)]=swap(pointA(2),pointB(2));
	    swapFlag=1;
	endif
	% check if the line is so steep, we swap x to y
	if(abs(a) > abs(b))
	    [pointA(1),pointA(2)]=swap(pointA(1),pointA(2));
	    [pointB(1),pointB(2)]=swap(pointB(1),pointB(2));
	    swapFlag=1;
	endif
	
	% recalculate a and b if change happend 
	if (swapFlag)
	    a=(pointA(2)-pointB(2)); % y0 - y1
	    b=(pointB(1)-pointA(1)); % x1 - x0
	endif
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
    endif
endfunction

%4. Besenher algorithm
function L=bresenhamAlgorithm(Im,pointA,pointB)
    L=Im(:,:);
    
    % swap position of 2 points if the first point is on the left of the second point
    if(pointA(1) > pointB(1) || pointA(2) > pointB(2))
        [pointA(1),pointB(1)]=swap(pointA(1),pointB(1));
	[pointA(2),pointB(2)]=swap(pointA(2),pointB(2));
    endif
    pointA
    pointB

    dx=pointB(1) - pointA(1);
    dy=pointB(2) - pointA(2);
    increaseY=sign(dy);
    increaseX=sign(dx);

    if(dx==0) % x1=x2 => vertical line
	for i=pointA(2):1:pointB(2)
	    L(i,pointA(1))=1;
	endfor
    elseif(dy==0) %y1=y2 => case horizontal line
	for j=pointA(1):1:pointB(1)
	    L(pointA(2),j)=1;
	endfor
    elseif(abs(dx) >=abs(dy))
	disp("More horizontal than vertical");
	i=pointA(2);
	slope = double(abs(dy/dx));
	err=slope-1;
	for j=pointA(1):increaseX:pointB(1)
	    L(i,j)=1;
	    if(err>=0)
		i+=(increaseY);
		err-=1;
	    endif
	    err+=slope;
	    %mse+=power(err,2);
	endfor
	%merr=mse(theoryY,practicalY);
    else
	disp("More vertical than horizontal");
	i=pointA(1);
	slope = double(abs(dx/dy));
	err=slope-1;
	for j=pointA(2):increaseY:pointB(2)
	    L(j,i)=1;
	    if(err>=0)
		i+=(increaseX);
		err-=1;
	    endif
	    err+=slope;
	endfor
	%merr=mse(theoryY,practicalY);
    endif
endfunction


