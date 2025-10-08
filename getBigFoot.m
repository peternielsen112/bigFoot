function bigFoot = getBigFoot(bigFootSize,bigFootPose)
  bigFoot = zeros(3,14);


  if (bigFootPose == 0)
    % body centerpoint
    bigFoot(:,1)=[0;0;1];
    % head centerpoint
    bigFoot(:,2)=[0;bigFootSize*1.5;1];
    % arm 1
    bigFoot(:,3)=[-0.75*bigFootSize;0;1];
    bigFoot(:,4)=[-1.5*bigFootSize;0.25*bigFootSize;1];
    bigFoot(:,5)=[-1*bigFootSize,2.25*bigFootSize,1];
    % arm 2
    bigFoot(:,6)=[0.75*bigFootSize;0;1];
    bigFoot(:,7)=[1.5*bigFootSize;0.25*bigFootSize;1];
    bigFoot(:,8)=[1*bigFootSize,2.25*bigFootSize,1];
    % leg 1
    bigFoot(:,9)=[-0.75*bigFootSize,-0.75*bigFootSize,1];
    bigFoot(:,10)=[-0.5*bigFootSize,-2*bigFootSize,1];
    bigFoot(:,11)=[-0.2*bigFootSize,-2*bigFootSize,1];
    % leg 2
    bigFoot(:,12)=[0.75*bigFootSize,-0.75*bigFootSize,1];
    bigFoot(:,13)=[0.5*bigFootSize,-2*bigFootSize,1];
    bigFoot(:,14)=[0.2*bigFootSize,-2*bigFootSize,1];
  elseif (bigFootPose == 1)
    % body centerpoint
    bigFoot(:,1)=[0;0;1];
    % head centerpoint
    bigFoot(:,2)=[0;bigFootSize*1.5;1];
    % arm 1
    bigFoot(:,3)=[-0.75*bigFootSize;0.75*bigFootSize;1];
    bigFoot(:,4)=[-1.5*bigFootSize;bigFootSize;1];
    bigFoot(:,5)=[-1*bigFootSize,2.5*bigFootSize,1];
    % arm 2
    bigFoot(:,6)=[0.75*bigFootSize;0.75*bigFootSize;1];
    bigFoot(:,7)=[1.5*bigFootSize;bigFootSize;1];
    bigFoot(:,8)=[1*bigFootSize,2.5*bigFootSize,1];
    % leg 1
    bigFoot(:,9)=[-0.5*bigFootSize,-0.75*bigFootSize,1];
    bigFoot(:,10)=[-0.75*bigFootSize,-2*bigFootSize,1];
    bigFoot(:,11)=[-0.1*bigFootSize,-2*bigFootSize,1];
    % leg 2
    bigFoot(:,12)=[0.5*bigFootSize,-0.75*bigFootSize,1];
    bigFoot(:,13)=[0.75*bigFootSize,-2*bigFootSize,1];
    bigFoot(:,14)=[0.1*bigFootSize,-2*bigFootSize,1];
  endif
endfunction
