function game
% main game code

% using global variable cmd to connect with keyboard listener
  global cmd;
  cmd = "null";
% initialize variable to hold most recent keyboard command.
  lastcom = 'null';

% frames per second. increase or decrease by powers of 2
  fps = 8;
  dt = 1/fps;

% bat init variables
  batSize = 40;
  batColor = [0.2, 0, 0.8];
  lineWidth = 3;
  batX = 750;
  batY = 200;
  batSpeed = 25;
  batAngularSpeed = pi/2; % in radians/sec

% init frame number for counting.
  frames = 0;

% bigfoot init variables
  bigFootX = 750;
  bigFootY = 900;
  bigFootPose = 0;
  bigFootSpeed = 15;
  bigFootTheta = pi/6;
  bfThet = 0;
  bigFootOnGround = 1;
  bigFootFalling = 0;
  bigFootHealth = 100;

% initialize climbing routes. these will change based on location
  climbRoute1 = 475;
  climbRoute2 = 1270;
  climbRoute3 = 140;
  climbRouteRadius = 50;
  climbRouteMaxHeight = 4*batSize;

%  [signal, sampleRate] = audioread('spooky_forest_bat.wav');
%  player = audioplayer(signal,sampleRate);
%  play(player);

% background/scene change init
  [imageHeight,imageWidth] = drawBackground("spookyForest.png");
  change = false;
  changeTimes = 0;

% frame counter for circular bat rotation; rotation variables
  usedframes = 1;
  rcheck = true;
  thet = (-pi/2);

% main loop. 'k' to quit while running
  while (cmd != 'k')

%    if (!isplaying(player))
%      stop(player);
%      play(player);
%    endif

% check climbing, falling potential; change if necessary
    if (abs(climbRoute1 - bigFootX) < climbRouteRadius )
      canClimb = 1;
    elseif (abs(climbRoute2 - bigFootX) < climbRouteRadius)
      canClimb = 1;
    elseif (abs(climbRoute3 - bigFootX) < climbRouteRadius)
      canClimb = 1;
    else
      canClimb = 0;
    endif

    if (bigFootY > 750)
      bigFootOnGround = 1;
    else
      bigFootOnGround = 0;
    endif

    if (bigFootOnGround)
      bigFootFalling =0;
    elseif (canClimb == 1)
      bigFootFalling = 0;
    else
      bigFootFalling =1;
    endif
% make BigFoot fall if the variables demand it.
    if (bigFootFalling)
      bigFootFallTime = bigFootFallTime + 1;
      bigFootY = bigFootY + bigFootFallTime*bigFootFallTime;
    else
      bigFootFallTime = 0;
    endif

% check for background change? if yes change to cave, reset change to false, and reset characters. if already in cave, activate win condition
    if (change == true)
      if (changeTimes == 2)
        text(500, 500,"You Won!!!",'FontSize', 50,'Color',[1 0 0]);
        pause(5);
        break;
      endif
      [imageHeight,imageWidth] = drawBackground("cave.png");
      change = false;
      bigFootX = 750;
      bigFootY = 900;
      bigFootPose = 0;
      bigFootSpeed += 8;
      batX = 750;
      batY = 200;
      climbRoute1 = 200;
      climbRoute2 = 1375;
      climbRoute3 = -500;
      climbRouteMaxHeight = 420;
    endif

% rotate the bat
    thet = thet + batAngularSpeed*dt;

% check if bat out of bounds and move bat randomly.
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

    if (bigFootY <= 185)
      bigFootY=bigFootY + (2 * (rand > 0.5)*batSpeed);
    elseif (bigFootY >= 900)
      bigFootY=bigFootY - (2 * (rand > 0.5)*batSpeed);
    endif

    if (bigFootX >= 1400)
      bigFootX=bigFootX - (2 * (rand > 0.5)*batSpeed);
    elseif (bigFootX <= 145)
      bigFootX=bigFootX + (2 * (rand > 0.5)*batSpeed);
    endif

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
      lastcom = 'a';
      bigFootX -= bigFootSpeed;
      cmd = "null";
      bigFootPose = mod(frames,2);
    elseif (cmd == "d")
      bigFootX += bigFootSpeed;
      cmd = "null";
      lastcom = 'd';
      bigFootPose = mod(frames,2);
    elseif (cmd == "q")
      bfThet -= bigFootTheta;
    elseif (cmd == "e")
      bfThet += bigFootTheta;
    elseif( cmd == 'x' && bigFootOnGround ) %jump vertically
      bigFootFalling = 1;
      bigFootY = bigFootY - 40*rand*bigFootSpeed;
    elseif( cmd == 'x' && bigFootOnGround == false ) % leap sideways
      bigFootFalling = 1;
      if (lastcom == 'a')
        bigFootX = bigFootX - 240;
      elseif (lastcom == 'd')
        bigFootX = bigFootX + 240;
      endif
      bigFootY = bigFootY - rand*bigFootSpeed;

      cmd = "null";
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
    if (batX <= bigFootX+50) && (batX >=bigFootX-50) && (batY <= bigFootY+50) && (batY >= bigFootY-50)
      change = true;
      changeTimes += 1;
    endif
  endwhile
  clf();
endfunction

