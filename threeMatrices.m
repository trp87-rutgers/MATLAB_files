function [D, A, B] = threeMatrices(inputMatrix)
    [x,y] = size(inputMatrix);
    D(x,y) = 0;
    A(x,y) = 0;
    B(x,y) = 0;
    for i = 1:1:x
        for j = 1:1:y
            % Matrix D
            if (i == j)
                D(i,j) = inputMatrix(i,j);
            end
            % Matrix A
            if ( (i<j) && ~(i==j))
                A(i,j) = inputMatrix(i,j);
            end
            % Matrix B
            if ( (i>j) && ~(i==j))
                B(i,j) = inputMatrix(i,j);
            end
        end
    end
    
    
end