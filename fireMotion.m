function fireHandles = fireMotion(fireSize, fireStartX, fireStartY, targetX, targetY, progress)
  % Draw three fire balls moving toward a target with wiggling motion
  % Parameters:
  %   fireSize: size of the largest fire ball
  %   fireStartX, fireStartY: starting position of fire
  %   targetX, targetY: target position to move toward
  %   progress: animation progress from 0 to 1 (0 = start, 1 = target reached)
  % Returns: array of handles for the three fire balls
  
  % Clamp progress to [0, 1]
  progress = max(0, min(1, progress));
  
  % Fire ball sizes (decreasing)
  ball1_radius = fireSize * 0.3;
  ball2_radius = fireSize * 0.2;
  ball3_radius = fireSize * 0.1;
  
  % Calculate base direction toward target
  dx = targetX - fireStartX;
  dy = targetY - fireStartY;
  distance = sqrt(dx^2 + dy^2);
  
  % Normalize direction
  if distance > 0
    dir_x = dx / distance;
    dir_y = dy / distance;
  else
    dir_x = 0;
    dir_y = 0;
  endif
  
  % wiggle direction
  perp_x = -dir_y;
  perp_y = dir_x;
  
  % amplitude, frequency of wiggle. cool, right?
  wiggle_amplitude = fireSize * 0.4;
  wiggle_frequency = 8 * pi;
  wiggle_offset = wiggle_amplitude * sin(wiggle_frequency * progress);
  
  current_distance = distance * progress;
  current_x = fireStartX + dir_x * current_distance + perp_x * wiggle_offset;
  current_y = fireStartY + dir_y * current_distance + perp_y * wiggle_offset;
  
  % Position of fireballs
  ball1_x = current_x;
  ball1_y = current_y;
  
  ball2_x = current_x - dir_x * (ball1_radius + ball2_radius);
  ball2_y = current_y - dir_y * (ball1_radius + ball2_radius);
  
  ball3_x = ball2_x - dir_x * (ball2_radius + ball3_radius);
  ball3_y = ball2_y - dir_y * (ball2_radius + ball3_radius);
  
  % Draw fireballs
  hold on
  fire_color_1 = [1, 0.4, 0]; % Orange
  fire_color_2 = [1, 0.2, 0]; % Red
  fire_color_3 = [1, 0.1, 0]; % more red
  
  handle1 = drawFilledCircle(ball1_x, ball1_y, ball1_radius, fire_color_1, 1);
  handle2 = drawFilledCircle(ball2_x, ball2_y, ball2_radius, fire_color_2, 1);
  handle3 = drawFilledCircle(ball3_x, ball3_y, ball3_radius, fire_color_3, 1);
  
  hold off
  
  % Return all handles
  fireHandles = [handle1, handle2, handle3];
endfunction
