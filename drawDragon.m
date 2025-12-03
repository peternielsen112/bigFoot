function dragonHandle = drawDragon(dragonSize, dragonColor, x, y, rot, thet)
  
  % Base positions (relative coordinates before transformation)
  % Sizes for all parts
  body_radius = dragonSize * 0.8;
  head_radius = dragonSize * 0.5;
  tail1_radius = dragonSize * 0.4;
  tail2_radius = dragonSize * 0.3;
  eye_radius = dragonSize * 0.12;
  
  body_x = 0;
  body_y = 0;
  
  % Head positioned to touch body (right side, slightly offset vertically for overlap)
  head_x = body_radius + head_radius;
  head_y = 0;
  
  % Tail segments connected to body (left side, forming a chain)
  tail1_x = -(body_radius + tail1_radius);
  tail1_y = 0;
  tail2_x = tail1_x - tail1_radius - tail2_radius;
  tail2_y = dragonSize * 0.3;
  
  % Eyes positioned on head surface
  eye1_x = head_x + head_radius * 0.6;
  eye1_y = head_y + head_radius * 0.4;
  eye2_x = head_x + head_radius * 0.6;
  eye2_y = head_y - head_radius * 0.4;
  
  % Apply rotation if enabled
  if rot
    R = getRotate(thet);
    
    % Rotate body position
    pos_body = R * [body_x; body_y; 1];
    body_x = pos_body(1);
    body_y = pos_body(2);
    
    % Rotate head position
    pos_head = R * [head_x; head_y; 1];
    head_x = pos_head(1);
    head_y = pos_head(2);
    
    % Rotate tail positions
    pos_tail1 = R * [tail1_x; tail1_y; 1];
    tail1_x = pos_tail1(1);
    tail1_y = pos_tail1(2);
    
    pos_tail2 = R * [tail2_x; tail2_y; 1];
    tail2_x = pos_tail2(1);
    tail2_y = pos_tail2(2);
    
    % Rotate eye positions
    pos_eye1 = R * [eye1_x; eye1_y; 1];
    eye1_x = pos_eye1(1);
    eye1_y = pos_eye1(2);
    
    pos_eye2 = R * [eye2_x; eye2_y; 1];
    eye2_x = pos_eye2(1);
    eye2_y = pos_eye2(2);
  endif
  
  % Apply translation
  body_x = body_x + x;
  body_y = body_y + y;
  head_x = head_x + x;
  head_y = head_y + y;
  tail1_x = tail1_x + x;
  tail1_y = tail1_y + y;
  tail2_x = tail2_x + x;
  tail2_y = tail2_y + y;
  eye1_x = eye1_x + x;
  eye1_y = eye1_y + y;
  eye2_x = eye2_x + x;
  eye2_y = eye2_y + y;
  
  % Draw body (large circle)
  hold on
  handle1 = drawFilledCircle(body_x, body_y, dragonSize * 0.8, dragonColor, 2);
  
  % Draw head (medium circle, slightly different hue)
  head_color = dragonColor + [0.1, 0.1, -0.1];  % Slightly lighter/adjusted
  head_color = max(0, min(1, head_color));  % Clamp to [0,1]
  handle2 = drawFilledCircle(head_x, head_y, dragonSize * 0.5, head_color, 2);
  
  % Draw tail segments (smaller circles)
  handle3 = drawFilledCircle(tail1_x, tail1_y, dragonSize * 0.4, dragonColor, 2);
  handle4 = drawFilledCircle(tail2_x, tail2_y, dragonSize * 0.3, dragonColor, 2);
  
  % Draw eyes (small filled circles, black)
  handle5 = drawFilledCircle(eye1_x, eye1_y, dragonSize * 0.12, [0, 0, 0], 1);
  handle6 = drawFilledCircle(eye2_x, eye2_y, dragonSize * 0.12, [0, 0, 0], 1);
  
  hold off
  
  % Return all handles
  dragonHandle = [handle1, handle2, handle3, handle4, handle5, handle6];
endfunction