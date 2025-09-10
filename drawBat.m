% body: (-size/2, 0, 1); (size/2, -size/8, 1); (size/2, size/8, 1)
% upperwing: (0, 2size, 1), (0,0,1), (size,size,1), (size/2, size, 1)
% lowerwing: (0, -2size, 1), (0,0,1), (size,-size,1), (size/2, -size, 1)

% create function batHandle
function batHandle = drawBat(batSize, batColor, width, batPose,x,y)
  bat = getBat(batSize,batPose);

  T = getTranslate(x,y)
  bat = T*bat;

  p1=bat(:,1);
  p2=bat(:,2);
  p3=bat(:,3);
  p4=bat(:,4);

  p5=bat(:,5);
  p6=bat(:,6);
  p7=bat(:,7);

  p8=bat(:,8);
  p9=bat(:,9);
  p10=bat(:,10);
  p11=bat(:,11);
  p12=bat(:,12);
  p13=bat(:,13);
  p14=bat(:,14);
  p15=bat(:,15);



  % fill body
  hold on
  bodyX = [p2(1), p3(1), p4(1)];
  bodyY = [p2(2), p3(2), p4(2)];
  handle1 = fill(bodyX, bodyY, batColor);
  hold off

  % wing1
  hold on
  wing1x = [p1(1),p5(1),p6(1),p7(1)];
  wing1y = [p1(2),p5(2),p6(2),p7(2)];
  handle2 = fill(wing1x, wing1y, batColor);
  hold off


  % wing2
  hold on
  wing2x = [p1(1),p8(1),p9(1),p10(1)];
  wing2y = [p1(2),p8(2),p9(2),p10(2)];
  handle3 = fill(wing2x, wing2y, batColor);
  hold off


  % ear1
  hold on
  ear1x = [p11(1),p12(1),p13(1)];
  ear1y = [p11(2),p12(2),p13(2)];
  handle4 = fill(ear1x,ear1y, batColor);
  hold off

  % ear2
  hold on
  ear2x = [p11(1),p14(1),p15(1)];
  ear2y = [p11(2),p14(2),p15(2)];
  handle5 = fill(ear2x,ear2y, batColor);
  hold off

%  batHandle = [fill(bodyX, bodyY, batColor),fill(wing1x, wing1y, batColor),fill(wing2x, wing2y, batColor),fill(ear1x,ear1y, batColor),fill(ear2x,ear2y, batColor)];
  batHandle = [handle1, handle2, handle3, handle4, handle5];

endfunction
