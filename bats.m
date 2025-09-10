function bats (frames)

  fps = 2;

  dt = 1/fps;

  batSize = 40;
  batColor = [0.2, 0, 0.8];
  lineWidth = 3;

  batX = 750;
  batY = 200;
  batSpeed = 50;

  [imageHeight,imageWidth] = drawBackground("spookyForest.png");

  for i=1:frames
    batX=batX + ((2 * (rand > 0.5) - 1)*batSpeed);
    batY=batY + ((2 * (rand > 0.5) - 1)*batSpeed);
    batPose = mod(i,2)
    batHandle = drawBat(batSize,batColor,lineWidth,batPose,batX,batY);
    pause(dt);
    delete(batHandle);
  endfor
endfunction

