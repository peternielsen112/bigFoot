function fireHandles = fireMotion(fireSize, fireX, fireY, targetX, targetY, fireSpeed)
  
  % fire balls
  ball1_radius = fireSize * 0.3;
  ball2_radius = fireSize * 0.2;
  ball3_radius = fireSize * 0.1;
  
  % direction to target
  dx = targetX - fireX;
  dy = targetY - fireY;
  distance = sqrt(dx^2 + dy^2);
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
  
  % amplitude and frequency of wiggle
  wiggle_amplitude = fireSize * 0.4;
  wiggle_frequency = 8 * pi;
  time_offset = mod(fireX + fireY, 1.0); % Use position as pseudo-time for wiggle
  wiggle_offset = wiggle_amplitude * sin(wiggle_frequency * time_offset);
  
  % Current position of lead fire ball
  current_x = fireX + perp_x * wiggle_offset;
  current_y = fireY + perp_y * wiggle_offset;
  
  % Position of fireballs
  ball1_x = current_x;
  ball1_y = current_y;
  
  ball2_x = fireX - dir_x * (ball1_radius + ball2_radius);
  ball2_y = fireY - dir_y * (ball1_radius + ball2_radius);
  
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