function hdl = mj_drawPose3DITOP(jnt, hdl, colorK, drawpars)
% hdl = mj_drawPose3DITOP(jnt, hdl, colorK, drawpars)
%
% Input:
%  - jnt: vector with 3D coordinates, [105, 1]
%  - hdl:
%  - colorK: color letter for plot. Def. 'k'
%  - drawpars: struct with fields
%     .segments: def. true
%     .numbers: def. true
%
% (c) MJMJ/2018

if ~exist('hdl', 'var')
   hdl = figure;
else
   hdl = figure(hdl);
end

if ~exist('colorK', 'var')
   colorK = 'k';
end

if ~exist('drawpars', 'var')
   drawpars.segments = true;
   drawpars.numbers = true;
   drawpars.plaincolor = false;
end

jnt = double(jnt);

%% Draw coordinates
hold on
plot3(jnt(1:3:end), jnt(2:3:end), jnt(3:3:end), ['o' colorK], 'LineWidth',3);

if drawpars.numbers
   for ix = 1:15
      text(jnt((ix-1)*3+1), jnt((ix-1)*3+2), jnt((ix-1)*3+3),['   ' ...
         num2str(ix)],'HorizontalAlignment','left','FontSize',8);
   end
end

if drawpars.segments
   % Limbs definition
   segments = [1,2
      2,3
      2,4
      2,9
      9,10
      9,11];
   segmentsR = [3,5
      5,7      
      10,12
      12,14
      ];
   segmentsL = [4,6
      6,8       
      11,13
      13,15
      ];
   
   for ix = 1:size(segments,1)      
      a = segments(ix,1);
      b = segments(ix,2);
      pt1 = jnt((a-1)*3+1:(a-1)*3+3);
      pt2 = jnt((b-1)*3+1:(b-1)*3+3);

      plot3([pt1(1), pt2(1)], [pt1(2), pt2(2)], [pt1(3), pt2(3)] , ['-' colorK], 'LineWidth',2);

   end % ix
   
   for ix = 1:size(segmentsL,1)      
      a = segmentsL(ix,1);
      b = segmentsL(ix,2);
      pt1 = jnt((a-1)*3+1:(a-1)*3+3);
      pt2 = jnt((b-1)*3+1:(b-1)*3+3);
      if drawpars.plaincolor
         plot3([pt1(1), pt2(1)], [pt1(2), pt2(2)], [pt1(3), pt2(3)] , ['-' colorK], 'LineWidth',2);
      else         
         plot3([pt1(1), pt2(1)], [pt1(2), pt2(2)], [pt1(3), pt2(3)] , ['-r'], 'LineWidth',2);
      end
   end % ix   
   
   for ix = 1:size(segmentsR,1)      
      a = segmentsR(ix,1);
      b = segmentsR(ix,2);
      pt1 = jnt((a-1)*3+1:(a-1)*3+3);
      pt2 = jnt((b-1)*3+1:(b-1)*3+3);
      
      if drawpars.plaincolor
         plot3([pt1(1), pt2(1)], [pt1(2), pt2(2)], [pt1(3), pt2(3)] , ['-' colorK], 'LineWidth',2);
      else
         plot3([pt1(1), pt2(1)], [pt1(2), pt2(2)], [pt1(3), pt2(3)] , ['-b'], 'LineWidth',2);
      end
   end % ix
end

axis image