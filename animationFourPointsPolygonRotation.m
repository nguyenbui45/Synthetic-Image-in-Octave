function L=animationFourPointsPolygonRotation(L,pointPairs,angle)
    %angle default is positive, which makes that object rotates in clockwise direction
    figure("Name","Animation rotation")
    %start first by make polygon moving back and forth in horizontal movement
    L=drawPolygon(L,pointPairs,1);
    imshow(L);
    drawnow
    while(1)
        pointPairs=rotateFunction(pointPairs,angle);
        % in order to make the rotation go around the center of object, we need
        % a translation operation.
        L=drawPolygon(zeros(256,256),pointPairs,1);
        imshow(L);
        drawnow
    endwhile
endfunction




