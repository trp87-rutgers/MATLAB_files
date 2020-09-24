%Part 1
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

%Part 2
function Data = addData(Data, num)
    Data.values(length(Data.values)+1) = num;
    Data.values = sort(Data.values);
end

%Part 3
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