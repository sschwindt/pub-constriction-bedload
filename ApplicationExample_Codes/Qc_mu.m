% June 2016, Sebastian Schwindt
% EPF Lausanne, LCH

% Follow up of application case 
%--------------------------------------------------------------------------
close all;
clear all;

wc = 8.;
alphac = 22.6199;
m = 1/tand(alphac);
a = 1.2;

g = 9.81;

Q = 55;
Fr = 0.05;
eps_mu = 1;
count_mu = 0;

h0 = (Q/wc/sqrt(g)/Fr)^(2/3);
mu_it = 0.6;
while eps_mu > 0.001
    mu = 0.38*Fr+0.48;
    eps_mu = abs(mu_it-mu)/mu;
    mu_it = mu;
    count_mu = count_mu + 1;
    if count_mu > 10^3
        disp('Iteration break (mu).')
        break;
    end

    H0 = 4/3*(Q/wc/sqrt(g)/Fr)^(2/3);
    eps = 1;
    count = 1;
    while eps > 0.000001
        H0_it = (Q/(mu*sqrt(8*g)*...
            wc/(3*H0)*(1-(1-a/H0)^(3/2))+...
              2/3/tand(alphac)*(1-(1-a/H0)^(3/2))-...
                2/5/tand(alphac)*(1-(1-a/H0)^(5/2))))^(2/5);
	eps = abs(H0_it-H0)/H0;
        H0 = H0_it;
        count = count + 1;
        if count > 10^3
            disp('Iteration break (H0).')
            break;
        end
    end
    eps = 1;
    count = 1;
    h0 = H0*2/3;
    while eps > 0.000001
        A0 = h0*(wc+h0*m);
        h0_it = H0 - Q^2/(A0^2*2*g);
	eps = abs(h0_it-h0)/h0;
        h0 = h0_it;
        count = count + 1;
        if count > 10^3
            disp('Iteration break (h0).')
            break;
        end
    end

    Fr = Q*sqrt(wc+2*h0/tand(alphac))/(h0*(wc+ h0/tand(alphac)))^(3/2)/sqrt(g)
end
H0
mu
h0
Fr


ax = a/h0

zeta_Fr = 0.51*Fr^-0.86-0.46

eta_Fr = 0.74*Fr^1.592

