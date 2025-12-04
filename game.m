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

% dragon init variables
  dragonSize = 50;
  dragonColor = [0, 0.5, 0];
  dragonX = 1420;
  dragonY = 120;
  dragonRot = true;
  dragonThet = pi/2; % initial rotation angle
  dragonPresent = false;
  
% fire init variables
  fireSpawnInterval = 7.5;
  fireLifespan = 5;
  fireSpawnTimer = 0;
  fireSize = 20;
  fireQueue = {}; % queue of active fire projectiles [fireHandle, spawnTime]. a little complex but works fine.

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
  % projectile speed for fire (slightly faster than BigFoot)
  fireSpeed = bigFootSpeed * 1.2;
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

% see if this works - play music!
  [signal, sampleRate] = audioread('spooky_forest_bat.wav');
  player = audioplayer(signal,sampleRate);
  play(player);

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

    if (!isplaying(player))
      stop(player);
      play(player);
    endif

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
        [signal2, sampleRate2] = audioread('medieval_fanfare.wav');
        player2 = audioplayer(signal2,sampleRate2);
        stop(player);
        play(player2);
        text(500, 500,"You Won!!!",'FontSize', 50,'Color',[1 0 0]);
        pause(5);
        break;
      elseif (changeTimes == 3)
        stop(player);
        text(500, 500,"You LOSE!!",'FontSize', 50,'Color',[1 1 0]);
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
      dragonPresent = true;
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
      bigFootY = bigFootY - 20*rand*bigFootSpeed;
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
% draw the dragon!
    if (dragonPresent)
      dragonHandle = drawDragon(dragonSize, dragonColor, dragonX, dragonY, dragonRot, dragonThet);
      
      % update fire spawn timer
      fireSpawnTimer = fireSpawnTimer + dt;
      
      % makiing some fire here
      if (fireSpawnTimer >= fireSpawnInterval)
        % Fire spawn position
        fireSpawnX = 1420;
        fireSpawnY = 215;
        
        % make fire! store target snapshot so projectile speed is consistent
        fireQueue{end+1} = {fireSpawnX, fireSpawnY, frames, bigFootX, bigFootY};
        % play dragon roar sound when spawning fire (reduced volume)
        [signal3, sampleRate3] = audioread('dragon_roar.wav');
        % reduce volume to 40%
        signal3 = 0.4 * signal3;
        player3 = audioplayer(signal3,sampleRate3);
        play(player3);
        fireSpawnTimer = 0;
      endif
      
      % Delete previous frame's fire handles (stops bleed)
      for fireIdx = 1:length(fireQueue)
        if (length(fireQueue{fireIdx}) > 5)
          delete(fireQueue{fireIdx}{6});
        endif
      endfor
      
      % update fire
      fireIndicesToRemove = [];
      for fireIdx = 1:length(fireQueue)
        fireData = fireQueue{fireIdx};
        fireSpawnX = fireData{1};
        fireSpawnY = fireData{2};
        fireSpawnFrame = fireData{3};
        targetX = fireData{4};
        targetY = fireData{5};

        % Determine travel progress based on consistent speed (stored target)
        dx_tot = targetX - fireSpawnX;
        dy_tot = targetY - fireSpawnY;
        totalDist = sqrt(dx_tot^2 + dy_tot^2);
        fireAge = (frames - fireSpawnFrame) * dt;
        if (totalDist > 0)
          travelTime = totalDist / fireSpeed;
          fireProgress = min(1, fireAge / travelTime);
        else
          fireProgress = 1;
        endif

        % draw fire again
        if (fireProgress <= 1)
          fireHandle = fireMotion(fireSize, fireSpawnX, fireSpawnY, targetX, targetY, fireProgress);
          fireQueue{fireIdx}{6} = fireHandle; % Store handle for deletion

          % compute current projectile position (along stored path)
          if (totalDist > 0)
            dir_x = dx_tot / totalDist;
            dir_y = dy_tot / totalDist;
            currDist = totalDist * fireProgress;
            currX = fireSpawnX + dir_x * currDist;
            currY = fireSpawnY + dir_y * currDist;
          else
            currX = fireSpawnX;
            currY = fireSpawnY;
          endif

          % collision check using current projectile position
          fireCollisionRadius = 150;
          dxc = currX - bigFootX;
          dyc = currY - bigFootY;
          distanceToBF = sqrt(dxc^2 + dyc^2);

          if (distanceToBF < fireCollisionRadius)
            bigFootHealth = bigFootHealth - 25;
            % play sizzle sound on hit (left as-is elsewhere if desired)
            fireIndicesToRemove = [fireIndicesToRemove, fireIdx];
          endif
        else
          fireIndicesToRemove = [fireIndicesToRemove, fireIdx];
        endif
      endfor
      % remove bad fire
      for i = length(fireIndicesToRemove):-1:1
        idx = fireIndicesToRemove(i);
        fireQueue(idx) = [];
      endfor
    endif
% break between frames.
    pause(dt);
% clear characters for next frame.
    delete(batHandle);
    delete(bigFootHandle);
    if (dragonPresent)
      delete(dragonHandle);
    endif
% up frame counters
    usedframes = usedframes + 1;
    frames = frames + 1;
% check collision for scene change?
    if (batX <= bigFootX+50) && (batX >=bigFootX-50) && (batY <= bigFootY+50) && (batY >= bigFootY-50)
      change = true;
      changeTimes += 1;
    elseif bigFootHealth <= 0
      changeTimes = 3
    endif
  endwhile
  clf();
endfunction

