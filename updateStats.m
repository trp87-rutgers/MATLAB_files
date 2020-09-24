function Data = updateStats(Data)
    Data.values = sort(Data.values);
    
    len = length(Data.values);
    sum = 0;
    for i=1:len
       sum = sum + Data.values(i);
    end
    Data.mean = sum/len;
    
    if mod(len,2) == 0 % even case
        num1 = Data.values(len/2);
        num2 = Data.values(len/2+1);
        Data.median = (num1+num2)/2;  
    else % odd case
        Data.median = Data.values(len/2+.5);
    end
    
    sumv = 0;
    for i=1:len % sum of the difference of the mean squared
       sumv = sumv + (Data.values(i)-Data.mean)^2; 
    end
    Data.variance = sumv / (len-1); % averaged that sum for var
end