function L=animationFourPointsPolygon(L,pointPairs,step,angle)
    %frameNumber=196; % imageSize=256 - polygon size=10

    %step is the posistive parameter
    figure("Name","Animation")
    L=drawPolygon(L,pointPairs,1);
    imshow(L);
    %drawnow
    %start first by make polygon moving back and forth in horizontal movement
    i=0;
    while(1)

        pointPairs(:,1)+=step
        %move backward direction if the cube touches the image's boundary
        if(sum(pointPairs(:,1) >= 256)>=1 || sum(pointPairs(:,1) <= 1)>=1)
            step=-step;
            pointPairs(:,1)+=step;
        endif
        L=drawPolygon(zeros(256,256),pointPairs,1);
        imshow(L);
        drawnow
        pause(0.1);

        pointPairs=rotateFunction(pointPairs,angle);
        L=drawPolygon(zeros(256,256),pointPairs,1);
        imshow(L);
        drawnow
        pause(0.1)

    endwhile

endfunction
