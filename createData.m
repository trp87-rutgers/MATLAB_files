function Data = createData(input)
    Data.values = sort(input);
    input = sort(input); % ascending order
    
    sum = 0;
    len = length(input);
    for i=1:len % summing the values
       sum = sum + input(i);
    end
    Data.mean = sum/len;
    
    if mod(len,2)==0 % even length case
        num1 = input(len/2);
        num2 = input(len/2+1);
        Data.median = (num1 +num2)/2;
    else % odd length case
        Data.median = input(len/2+.5);
    end
    
    sumv = 0;
    for i=1:len % sum of the difference of the mean squared
       sumv = sumv + (input(i)-Data.mean)^2; 
    end
    Data.variance = sumv / (len-1); % averaged that sum for var
end