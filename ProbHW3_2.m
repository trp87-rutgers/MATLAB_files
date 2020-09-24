function ProbHW3_2()
    n = [20, 200, 2000];
    mu = 0; sigma = 1; % definition of std normal
    x1 = evrnd(mu,sigma,n(1),1); % create distribution with n = 10
    x2 = evrnd(mu,sigma,n(2),1); % create distribution with n = 100
    x3 = evrnd(mu,sigma,n(3),1); % create distribution with n = 1000
    
    cdfplot(x1)
    hold on % keep everything on one graph
    cdfplot(x2)
    cdfplot(x3)
    x = linspace(-9,9,10000000); % made n as big as possible
    plot(x,evcdf(x,mu,sigma)) % plot theoretical using evcdf built in function
    xlim([-9 9]);
    legend('n = 20', 'n = 200', 'n = 2000', 'Theoretical', 'Location', 'NW')

end