function handle = drawFilledCircle (x_center, y_center, radius, color, width)
  theta = linspace(0, 2*pi, 360);
  x_coords = radius * cos(theta) + x_center;
  y_coords = radius * sin(theta) + y_center;
  % draw filled circle (patch)
  hold on
  handle = fill(x_coords, y_coords, color);
  hold off
  % set face/edge color and edge width
  set(handle, "FaceColor", color);
  set(handle, "EdgeColor", color);
  set(handle, "LineWidth", width);
endfunction
