function [L, merr]=drawCircle(Im,centerPoint,radius,option,theoryY)
    switch (option)
	case"naive"
	    [L, merr]=naiveAlgorithm(Im,centerPoint,radius,theoryY);
	case "middle"
	    [L,merr]=middlePointAlgorithm(Im,centerPoint,radius);
	case "bresenham"
	    [L,merr]=bresenhamAlgorithm(Im,centerPoint,radius,theoryY);
	case "xiaolin"
	    [L,merr]=xiaolinAlgorithm(Im,centerPoint,radius);
	case "animation"
	    L=bresenhamAlgorithmAnimation(Im,centerPoint,radius,clockwise=1);
	otherwise
	    error("option parameter should be one of these string 'naive','middle','bresenham','xiaolin' ");
    endswitch

endfunction

%swap function
%function [element2,element1]=swap(element1,element2)
%endfunction

%calculate mean squared error
function merr=mse(theoryY,practicalY)
    merr=mean(power(theoryY-practicalY,2));
endfunction

%2. Naive algorithm WITH mse calculation
function [L, merr]=naiveAlgorithm(Im,centerPoint,radius,theoryY)
    L=Im(:,:);
    practicalY=[];
    % declare the vector to store practicalY and its index
    indexPracticalY=1;
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
	practicalY(indexPracticalY)=i;
	indexPracticalY+=1;
    endfor
    merr=mse(theoryY,practicalY);
endfunction

%3. Midde point algorithm
function [L,merr]=middlePointAlgorithm(Im,pointA,pointB)
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

%4. Besenher algorithm
function [L,merr]=bresenhamAlgorithm(Im,centerPoint,radius,theoryY)
    L=Im(:,:);
    %find the xmax
    xmax = round(1+cos(pi/4)*radius);

    d=3-2*radius;
    j=0;
    i=radius;
    practicalY=[]
    indexPracticalY=1;
    w=0;
    while(j <= i)
	L(i+centerPoint(2),j+centerPoint(1))=1;
	L(-i+1+centerPoint(2),-j+1+centerPoint(1))=1;
	L(-i+1+centerPoint(2),j+centerPoint(1))=1;
	L(i+centerPoint(2),-j+1+centerPoint(1))=1;
	
	L(j+centerPoint(2),i+centerPoint(1))=1;
	L(-j+1+centerPoint(2),-i+1+centerPoint(1))=1;
	L(-j+1+centerPoint(2),i+centerPoint(1))=1;
	L(j+centerPoint(2),-i+1+centerPoint(1))=1;
	if (d<0)
	    d=d+4*j+6;
	else
	    i=i-1;
	    d=d + 4*(j-i) +10;
	end
	j+=1;	
        practicalY(indexPracticalY)=i;
        indexPracticalY+=1;
	
    endwhile
    merr=mse(theoryY,practicalY);
endfunction

