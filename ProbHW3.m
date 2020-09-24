function ProbHW3()
    x= linspace(-3,3,1000); % x values to plot
    cdfFunc=normcdf(x,0,1); % get y values using normcdf function

    plot(x, cdfFunc) % plot x vs y
    title('CDF, Normal')  % give it a title
end