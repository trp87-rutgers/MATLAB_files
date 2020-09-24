function [outputM] = mirror(inputM)
    [yDim, xDim] = size(inputM);
    outputM(yDim, xDim) = 0;
    temp(yDim,1) = 0;
    y = xDim;
    if (mod(xDim,2))  % odd case
            for i=1:1:(y/2-.5)
                temp = inputM(:,xDim);
                outputM(:,xDim) = inputM(:,i);
                outputM(:,i) = temp;
                xDim = xDim -1;
            end
            outputM(:,(y/2+.5)) = inputM(:,(y/2+.5));
    else  % even case
        for i=1:1:(y/2+1)
            outputM(:,xDim) = inputM(:,i);
            temp = inputM(:,xDim);
            xDim = xDim-1;
            outputM(:,i) = temp;
        end
    end 
end