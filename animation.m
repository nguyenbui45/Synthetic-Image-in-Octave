function animationFourPointsPolygon(L,pointPairs,speed)
    %speed is the posistive parameter
    figure("Name","Animation")

    %start first by make polygon moving back and forth in horizontal movement
    while(1)
        pointPairs(:,1)+=speed;
        L=drawPolygon(L,pointPairs,1);
        imshow(L);
        drawnow
    endwhile

endfunction
