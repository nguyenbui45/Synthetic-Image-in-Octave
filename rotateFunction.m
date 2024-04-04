function pointPairsTransform=rotateFunction(pointPairs,angle)
  if(abs(angle) > 2*pi)
    angle=deg2rad(angle);
  endif
  %find the center of the object
  %centerX=round((pointPairs(2,1)-pointPairs(1,1))/2);
  %centerY=round((pointPairs(4,2)-pointPairs(1,2))/2);
    centerX = mean(pointPairs(:, 1));
    centerY = mean(pointPairs(:, 2));
  translationMatrix=[[1 0 -centerX];
                    [0 1 -centerY];
                    [0 0 1]];
  rotationMatrix= [[cos(-angle) -sin(-angle) centerX];
                  [sin(-angle) cos(-angle) centerY];
                  [0 0 1]];
  %perform rotation
  % rotation x': xcos(-angle) - ysin(-angle)
  % rotation y': xsin(-angle) + ycos(-angle)

  pointPairs(:,3)=1; % [x; y; 1]
  pointPairsTransform=zeros(3,4);
  for i=1:1:4
    pointPairsTransform(:,i)=translationMatrix*pointPairs(i,:)';
    pointPairsTransform(:,i)=rotationMatrix*pointPairsTransform(:,i);
  endfor
  pointPairsTransform=round((pointPairsTransform')(:,1:2))
endfunction
