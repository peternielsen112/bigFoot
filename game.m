function game
% main game code

% using global variable cmd to connect with keyboard listener
  global cmd;
  cmd = "null";

% frames per second. up by powers of 2
  fps = 8;
  dt = 1/fps;

% bat init variables
  batSize = 40;
  batColor = [0.2, 0, 0.8];
  lineWidth = 3;
  frames = 0;
  batX = 750;
  batY = 200;
  batSpeed = 25;
  batAngularSpeed = pi/2; % radians/sec

% bigfoot init variables
  bigFootX = 750;
  bigFootY = 900;
  bigFootPose = 0;
  bigFootSpeed = 15;
  bigFootTheta = pi/6;
  bfThet = 0;

% background/scene change init
  [imageHeight,imageWidth] = drawBackground("spookyForest.png");
  change = false;

% frame counter for circular bat rotation; rotation variables
  usedframes = 1;
  rcheck = true;
  thet = (-pi/2);

% main loop. k to quit while running
  while (cmd != 'k')
    % check for background change? then change to cave. reset change to false and reset characters.
    if (change == true)
      [imageHeight,imageWidth] = drawBackground("cave.png");
      change = false;
      bigFootX = 750;
      bigFootY = 900;
      bigFootPose = 0;
      bigFootSpeed += 8;
      batX = 750;
      batY = 200;
    endif
    % bat rotation stuff
    thet = thet + batAngularSpeed*dt;
    % check if bat out of bounds and move bat.
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
    %OLD IGNORE
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
    % check keyboard cmd (global variable). WASD normal movement; Q/E for rotation.
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
    elseif (cmd == "q")
      bfThet -= bigFootTheta;
    elseif (cmd == "e")
      bfThet += bigFootTheta;
    else
      cmd = "null";
    endif
    % change bat pose; draw bat.
    batPose = mod(frames,2);
    batHandle = drawBat(batSize,batColor,lineWidth,batPose,batX,batY,rcheck,thet);
    % draw bigfoot.
    bigFootHandle = drawBigFoot(batSize,bigFootPose,"red",bigFootX,bigFootY,bfThet);
    % break between frames.
    pause(dt);
    % clear characters for next frame.
    delete(batHandle);
    delete(bigFootHandle);
    % up frame counters
    usedframes = usedframes + 1;
    frames = frames + 1;
    % check collision for scene change?
    if (batX <= bigFootX+50)
      if (batX >=bigFootX-50)
        if (batY <= bigFootY+50)
          if (batY >= bigFootY-50)
            change = true;
          endif
        endif
      endif
    endif
  endwhile
endfunction

