function bats (frames)

  fps = 2;

  dt = 1/fps;

  batSize = 40;
  batColor = [0.2, 0, 0.8];
  lineWidth = 3;

  batX = 750;
  batY = 200;
  batSpeed = 50;
  batAngularSpeed = pi/2; % radians/sec

  [imageHeight,imageWidth] = drawBackground("spookyForest.png");


  rcheck = true;
  thet = (-pi/2);

  for i=1:frames
    thet = thet + batAngularSpeed*dt;
##      if (batX >= 1200):
##        batX=batX - (2 * (rand > 0.5)*batSpeed);
##      endif
##      if (batY <= 0)
##        batY=batY + (2 * (rand > 0.5)*batSpeed);
##      endif
##    batX=batX + ((2 * (rand > 0.5) - 1)*batSpeed);
##    batY=batY + ((2 * (rand > 0.5) - 1)*batSpeed);
    if (usedframes >= 5)
      batX=batX - batSpeed;
      batY=batY - batSpeed;
      if (usedframes >= 8)
        usedframes = 1;
      endif
    else
      batX=batX + batSpeed;
      batY=batY + batSpeed;
    endif
    batPose = mod(i,2)
    batHandle = drawBat(batSize,batColor,lineWidth,batPose,batX,batY,rcheck,thet);
    pause(dt);
    delete(batHandle);
    usedframes = usedframes + 1;
  endfor
endfunction

