function game

  global cmd;
  cmd = "null";

  fps = 8;

  dt = 1/fps;

  batSize = 40;
  batColor = [0.2, 0, 0.8];
  lineWidth = 3;
  frames = 0;
  batX = 750;
  batY = 200;
  batSpeed = 25;
  batAngularSpeed = pi/2; % radians/sec

  bigFootX = 750;
  bigFootY = 900;
  bigFootPose = 0;
  bigFootSpeed = 15;

  [imageHeight,imageWidth] = drawBackground("spookyForest.png");

  usedframes = 1;

  rcheck = true;
  thet = (-pi/2);

  while (cmd != 'q')
    thet = thet + batAngularSpeed*dt;
    if (batX >= 1400)
      batX=batX - (2 * (rand > 0.5)*batSpeed);
    elseif (batX <= 145)
      batX=batX + (2 * (rand > 0.5)*batSpeed);
    else
      batX=batX + ((2 * (rand > 0.5) - 1)*batSpeed);
    endif
    if (batY <= 185)
      batY=batY + (2 * (rand > 0.5)*batSpeed);
    elseif (batY >= 750)
      batY=batY - (2 * (rand > 0.5)*batSpeed);
    else
      batY=batY + ((2 * (rand > 0.5) - 1)*batSpeed);
    endif
%    batX=batX + ((2 * (rand > 0.5) - 1)*batSpeed);
%    batY=batY + ((2 * (rand > 0.5) - 1)*batSpeed);
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
    if (cmd == "w")
      bigFootY -= bigFootSpeed;
      cmd = "null";
      bigFootPose = mod(frames,2);
    elseif (cmd == "s")
      bigFootY += bigFootSpeed;
      cmd = "null";
      bigFootPose = mod(frames,2);
    elseif (cmd == "a")
      bigFootX -= bigFootSpeed;
      cmd = "null";
      bigFootPose = mod(frames,2);
    elseif (cmd == "d")
      bigFootX += bigFootSpeed;
      cmd = "null";
      bigFootPose = mod(frames,2);
    else
      cmd = "null";
    endif
    batPose = mod(frames,2);
 %   bigFootPose = mod(i,2);
    batHandle = drawBat(batSize,batColor,lineWidth,batPose,batX,batY,rcheck,thet);
    bigFootHandle = drawBigFoot(batSize,bigFootPose,"red",bigFootX,bigFootY);
    pause(dt);
    delete(batHandle);
    delete(bigFootHandle);
    usedframes = usedframes + 1;
    frames = frames + 1;
  endwhile
endfunction

