function [imageHeight,imageWidth] = drawBackground (imageName)

  % remove all figures
  clf;

  % create a figure
  figure(1);

  % read image
  image = imread(imageName);
  [imageHeight,imageWidth] = size(image);

  % display image
  imshow(image);
  axis image;

  %make the image full screen
  set(gca, "position", [0 0 1 1]);  % make the axes fill the figure
  set(gcf, "units", "normalized", "outerposition", [0 0 1 1]);

endfunction

