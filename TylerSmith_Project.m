%Numerical Conduction Analysis
%Tyler Smith
%ME 324 - B

Lx = 0.1; %y dimension of cross section in meter
Ly = 0.1; %y dimension of cross section in meter
k = 15; %Thermal conductivity in W/m.K
Tleft = 40; %Left temperature in degrees Celcius
Tbottom = 70; %Bottom temperature in degrees Celcius
Tinf = 20; %Ambient temperature on top in degrees Celcius
h = 30; %Convection coefficient in W/m^2.K

Nx = 10; %Array x dimension
Ny = 10; %Array y dimension

deltax = Lx/Nx; %Width of cells in meter
deltay = Ly/Ny; %Height of cells in meter

%Iniitalize coefficient and constant vectors with zeros
A = zeros(Nx*Ny);
C = zeros(Nx*Ny,1);

%Initial guess for temperature distribution
T(1:Nx*Ny,1) = 40;

%Build coefficient and constant vectors
%Inner nodes:
for n = 2:(Ny-1) %increment y index
   for m = 2:(Nx-1) %increment x index
       i = (n-1)*Nx + m;
       A(i,i+Nx) = 1;
       A(i,i-Nx) = 1;
       A(i,i+1) = 1;
       A(i,i-1) = 1;
       A(i,i) = -4;
   end
end

%Along bottom side:
for m = 2:(Nx-1) 
    i = m;
    A(i,i+Nx) = 1;
    A(i,i+1) = 1;
    A(i,i-1) = 1;
    A(i,i) = -4;
    C(i) = -Tbottom;
end

%Along the top side:
for m = 2:(Nx-1)
    i = (Ny-1)*Nx + m;
    A(i,i-Nx) = 2;
    A(i,i+1) = 1;
    A(i,i-1) = 1;
    A(i,i) = -2*((h*deltax/k)+2);
    C(i) = -(2*h*deltax/k)*Tinf;
end

%Along left side:
for n = 2:(Ny-1)
    i = (n-1)*Nx + 1;
    A(i,i+Nx) = 1;
    A(i,i-Nx) = 1;
    A(i,i-1) = 1;
    A(i,i) = -4;
    C(i) = -Tleft;
end

%Along right side - adiabatic wall:
for n = 2:(Ny-1) 
    i = (n-1)*Nx + Nx;
    A(i,i+Nx) = 1;
    A(i,i+1) = 1;
    A(i,i-1) = 2;
    A(i,i) = -4;
end

%Bottom left corner:
i = 1;
A(i,i+Nx) = 1;
A(i,i+1) = 1;
A(i,i) = -4;
C(i) = -(Tbottom + Tleft);

%Bottom right corner:
i = Nx; 
A(i,i+Nx) = 1;
A(i,i+1) = 1;
A(i,i) = -4;
C(i) = -Tbottom;

% %Top left corner:
i = (Ny-1)*Nx + 1;
A(i,i+Nx) = 1;
A(i,i+1) = 1;
A(i,i) = -4;
C(i) = -(Tleft + Tinf);

% %Top right corner:
i = Nx*Ny;
A(i,i+Nx) = 1;
A(i,i+1) = 1;
A(i,i) = -4;
C(i) = -Tinf;

%Solve Gauss-Seidel
residual = 100;
iterations = 0;

while (residual>0.0001)
    iterations = iterations + 1;
    for n = 1:Ny
        for m = 1:Nx
            i = (n-1)*Nx + m;
            Told(i,1) = T(i);
        end
    end
    
    %Update estimate of the temperature distribution
    tolerance = 0.0001;
    while (residual > tolerance) % You select the value of tolerance
    % Transfer the previously computed temperatures to an array Told
        for n = 1:Ny
             for m = 1:Nx
                 i = (n-1)*Nx + m;
                 Told(i,1) = T(i);
             end
        end
        
        % iterate through all of the equations
        for n = 1:Ny
            for m = 1:Nx
                i = (n-1)*Nx + m;
            %sum the terms based on updated temperatures
                sum1 = 0;
                for j = 1:(i-1)
                    sum1 = sum1 + A(i,j)*T(j);
                end
                
                %sum the terms based on temperatures not yet updated
                sum2 = 0;
                for j = (i+1) : (Nx*Ny)
                    sum2 = sum2 + A(i,j)*Told(j);
                end
                
                % update the temperature for the current node
                T(i) = (1/A(i,i)) * (C(i) - sum1 - sum2);
            end
        end
            residual = max (abs(T(i) - Told(i)));
    end
        %compute residual
    deltaT = abs(T-Told);
    residual = max(deltaT);
end

% iterations % report the number of iterations that were executed
%Now transform T into 2-D network so it can be plotted.
for n = 1:Ny
    for m = 1:Nx
        i = (n-1)*Nx + m;
        T2d(n,m) = T(i); 
        x(m) = m*deltax;
        y(n) = n*deltay;
    end
end
contourf(x,y,T2d,20)
colormap(jet)
title('Tyler Sucks Balls')
colorbar