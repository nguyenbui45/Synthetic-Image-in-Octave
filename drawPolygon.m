function L=drawPolygon(Im,pointPairs,fill)
  L=Im(:,:);
  % ... (rest of the code for drawing polygon edges)
  A=pointPairs(1,:);
  B=pointPairs(2,:);
  C=pointPairs(3,:);
  D=pointPairs(4,:);

  %draw Image
  L=drawLine(L,A,B,'bresenham');
  L=drawLine(L,B,C,'bresenham');
  L=drawLine(L,C,D,'bresenham');
  L=drawLine(L,D,A,'bresenham');

  ymin=min(pointPairs(:,2));
  ymax=max(pointPairs(:,2));
  xmin=min(pointPairs(:,1));
  xmax=max(pointPairs(:,1));

  if(fill)
    activeEdgeTable=[];
    numActiveEdges = 0; % track number of active edges

    edgeTable=constructEdgeTable(pointPairs,ymin,ymax);

    for scanline=ymin:1:ymax
        activeEdges = edgeTable{scanline - ymin + 1};
        activeEdgeTable = [activeEdgeTable; activeEdges];

        % Sort the active edge table based on the x-coordinate
        activeEdgeTable = sortrows(activeEdgeTable, 2);

        % Remove edges that have reached their maximum y-coordinate
        activeEdgeTable = activeEdgeTable(activeEdgeTable(:, 1) ~= scanline, :);

        % Fill the pixels between pairs of edges in the active edge table
        for i = 1:2:size(activeEdgeTable, 1)
            x1 = ceil(activeEdgeTable(i, 2));
            x2 = ceil(activeEdgeTable(i + 1, 2));
            L(scanline, x1:x2)=1;
        end

        % Increment x-coordinates of edges in the active edge table
        activeEdgeTable(:, 2) = activeEdgeTable(:, 2) + activeEdgeTable(:, 3);
    endfor
  endif
endfunction

% function to calculate the intersection of polygon's edges and scanline
function edgeTable=constructEdgeTable(vertices,ymin,ymax)
    edgeTable=cell(ymax-ymin+1,1);
    %iterate over each polygon edge
     for i = 1:size(vertices, 1)
        x1 = vertices(i, 1);
        y1 = vertices(i, 2);
        x2 = vertices(mod(i, size(vertices, 1)) + 1, 1); %the last edge will be the connection between point D and point A
        y2 = vertices(mod(i, size(vertices, 1)) + 1, 2); % mod(4,5)=1 => point A

        if y1~=y2
            slope_inverse = (x2 - x1) / (y2 - y1);

            % Assign edge to corresponding y-coordinate in the edge table
            if y1 < y2
                edgeTable{y1 - ymin + 1} = [edgeTable{y1 - ymin + 1}; y2, x1, slope_inverse];
            else
                edgeTable{y2 - ymin + 1} = [edgeTable{y2 - ymin + 1}; y1, x2, slope_inverse];
            endif
         endif
     endfor
endfunction

imshow(L); % Display the result
