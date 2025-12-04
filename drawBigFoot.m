function bigFootHandle = drawBigFoot(bigFootSize,bigFootPose,bigFootColor,x,y,thet)
  bigFoot = getBigFoot(bigFootSize,bigFootPose);

  R = getRotate(pi+thet);
  bigFoot = R*bigFoot;

  T = getTranslate(x,y);
  bigFoot = T*bigFoot;



  p1=bigFoot(:,1);
  p2=bigFoot(:,2);

  p3=bigFoot(:,3);
  p4=bigFoot(:,4);
  p5=bigFoot(:,5);

  p6=bigFoot(:,6);
  p7=bigFoot(:,7);
  p8=bigFoot(:,8);

  p9=bigFoot(:,9);
  p10=bigFoot(:,10);
  p11=bigFoot(:,11);

  p12=bigFoot(:,12);
  p13=bigFoot(:,13);
  p14=bigFoot(:,14);


  % create body
  handle1 = drawFilledCircle(p1(1),p1(2),bigFootSize,bigFootColor,2);

  % create face
  handle2 = drawFilledCircle(p2(1),p2(2),bigFootSize/2,bigFootColor,2);

  % fill arm1
  hold on
  arm1x = [p3(1), p4(1), p5(1)];
  arm1y = [p3(2), p4(2), p5(2)];
  handle3 = fill(arm1x, arm1y, bigFootColor);
  hold off

  % fill arm2
  hold on
  arm2x = [p6(1), p7(1), p8(1)];
  arm2y = [p6(2), p7(2), p8(2)];
  handle4 = fill(arm2x, arm2y, bigFootColor);
  hold off

  % fill leg1
  hold on
  leg1x = [p9(1), p10(1), p11(1)];
  leg1y = [p9(2), p10(2), p11(2)];
  handle5 = fill(leg1x, leg1y, bigFootColor);
  hold off

  % fill leg2
  hold on
  leg2x = [p12(1), p13(1), p14(1)];
  leg2y = [p12(2), p13(2), p14(2)];
  handle6 = fill(leg2x, leg2y, bigFootColor);
  hold off



  bigFootHandle = [handle1, handle2, handle3, handle4, handle5, handle6];

endfunction
