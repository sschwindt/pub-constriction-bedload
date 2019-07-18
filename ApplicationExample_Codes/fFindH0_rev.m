function [v, h0, A, P, kst] = fFindH0_rev( w0, beta, D90, J, Q)
% This function finds flow depth h0 numerically for a trapezoidal bed 
%   profile solving manning equation by Newton Raphson method

% PARAMETERS:
% w0 = bed width [m]
% beta = bank slope angle [°]
% kst = bed roughness [m¹´³/s]
% J = bed slope [-]
% Q = river discharge [m³/s]

m = 1/tand(beta); % [-] relative bank slope
h0 = 1;         % [m] initial value for flow depth
err = 1;        % [-] break criterion for while loop
a1 = 6.5;       % [-] Rickenmann-Recking (2011)
a2 = 2.5;       % [-] Rickenmann-Recking (2011)
g = 9.81;       % [m/s²]
kst = 21.1/D90^(1/6);
n=1/kst;
count = 1;

while err > 10^-3
    
    A = w0*h0+m*h0^2;
    P = w0+2*h0/sind(beta);
    
    Rh = A/P;    

    dA_dh = w0+2*m*h0;
    dP_dh = 2*sqrt(m^2+1);
    
    
    Qk = A^(5/3)*sqrt(J)/(n*P^(2/3));
    
    F = n*Q*P^(2/3)-A^(5/3)*sqrt(J);
    
    dF_dh = 2/3*n*Q*P^(-1/3)*dP_dh - 5/3*A^(2/3)*sqrt(J)*dA_dh;
    % compute new value for h0
    h0 = abs(h0 - F/dF_dh);

    % compute relative discharge error
    err = abs(Q-Qk)/Q;
    
    count = count+1;
    if count > 999
        disp(['Break at iteration No. ', num2str(count),' (J = ',num2str(J), ' Q = ', num2str(Q),')'])
        break;
    end
end

A = w0*h0+m*h0^2;
P = w0+2*h0*sqrt(m^2+1);
Qk =  A^(5/3)*sqrt(J)/(n*P^(2/3));
v = Qk/A;
err = abs(Q-Qk)/Q;
disp(['Iteration ended with Qk =  ', num2str(Qk), ' [m³/s] and error = ', num2str(err)])
end

