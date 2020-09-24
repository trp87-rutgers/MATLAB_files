function ProbHW3_3()
    a=-1; b=1; n=10; z=10000; 
    k=zeros(z,1); 

    
    for i=1:z
        t=zeros(n,1); % Fix this prob better way
        for w=1:n
            t(w,1) = (b-a)*rand(1,1)+a;
        end 
        var = ((b-a)^2)/12;
        k(i,1) = sum(t)./sqrt(n*var);
    end 
    g=hist(k); 
    i=g/sum(g); 
    P=cumsum(i); 
    plot(P);
    title ('CDF')
end