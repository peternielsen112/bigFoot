function bat = getBat(batSize, batPose)
  bat = zeros(3,10);
  if (batPose == 0)
    bat(:,1)=[0;0;1];
    bat(:,2)=[batSize/2;batSize/3;1];
    bat(:,3)=[-batSize/2;0;1];
    bat(:,4)=[batSize/2;-batSize/3;1];

    bat(:,5)=[batSize,batSize,1];
    bat(:,6)=[0,2*batSize,1];
    bat(:,7)=[batSize/2,batSize,1];

    bat(:,8)=[batSize,-batSize,1];
    bat(:,9)=[0,-2*batSize,1];
    bat(:,10)=[batSize/2,-batSize,1];

    bat(:,11)=[batSize/4;0;1];

    bat(:,12)=[batSize;batSize/4;1];
    bat(:,13)=[0.75*batSize,batSize/8,1];

    bat(:,14)=[batSize;-batSize/4;1];
    bat(:,15)=[0.75*batSize,-batSize/8,1];
  endif
  if (batPose == 1)
    bat(:,1)=[0;0;1];
    bat(:,2)=[batSize/2;batSize/3;1];
    bat(:,3)=[-batSize/2;0;1];
    bat(:,4)=[batSize/2;-batSize/3;1];

    bat(:,5)=[0,batSize,1];
    bat(:,6)=[-batSize,2*batSize,1];
    bat(:,7)=[-batSize/2,batSize,1];

    bat(:,8)=[0,-batSize,1];
    bat(:,9)=[-batSize,-2*batSize,1];
    bat(:,10)=[-batSize/2,-batSize,1];

    bat(:,11)=[batSize/4;0;1];

    bat(:,12)=[batSize;batSize/4;1];
    bat(:,13)=[0.75*batSize,batSize/8,1];

    bat(:,14)=[batSize;-batSize/4;1];
    bat(:,15)=[0.75*batSize,-batSize/8,1];
  endif
endfunction
