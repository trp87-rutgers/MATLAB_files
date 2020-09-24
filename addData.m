function Data = addData(Data, num)
    Data.values(length(Data.values)+1) = num;
    Data.values = sort(Data.values);
end