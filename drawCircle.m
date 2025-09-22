function handle = drawCircle (x_center, y_center, radius, color, width)
  theta = linspace(0, 2*pi, 360);
  x_coords = radius * cos(theta) + x_center;
  y_coords = radius * sin(theta) + y_center;
  % plot line
  hold on
  handle = plot(x_coords, y_coords, 'linewidth', 5);
  hold off
  % set line color and width
  set(handle,"Color",color);
  set(handle,"LineWidth",width);
endfunction
