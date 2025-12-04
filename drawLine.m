function handle = drawLine (p, q, color, width) % from canvas
  % This function draws a line between two points p and q in homogeneous coordinates.
  % extract x coord from points
  x = [p(1) ; q(1)];
  % extract y coord from points
  y = [p(2) ; q(2)];
  % plot line
  handle = line(x,y);
  % set line color and width
  set(handle,"Color",color);
  set(handle,"LineWidth",width);
endfunction