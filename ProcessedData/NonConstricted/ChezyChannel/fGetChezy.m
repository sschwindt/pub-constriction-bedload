function [ ck, kst ] = fGetChezy( h, w, alpha, DX, DZ, Q, xlsName, dq, Qb )
% This returns the evaluation of the Chezy coefficient under quasi
% non-uniform flow conditions in the 4 sections between the 5 ultrasonic
% probes

dw = w(1:end-1)-w(2:end);            %[m] section base width change
dalpha = alpha(1:end-1)-alpha(2:end);%[deg] section bank slope
Jf = DZ ./ DX;   %[-] channel bed slope

% set dx according to Peclet Number < 1.5 (Pe = u*dx/diff)
diff = 0.01;        %[m²/s] exp. diffusion coefficient
dx = 1.5*diff/2.0;    %[m] u=2.0 highest measured flow velocity


% prepare updates of channel sections
A = h.*(w+h./tand(alpha));
P = w+2*h./sind(alpha);

% set initial value of chezy
ck = Q*sqrt(P(1))/A(1)^(3/2)/sqrt(DZ(1)/DX(1));

k = 1;
eps = 1;
while eps > .001
    
    hi = ones(1,4);
    for i = 1:4     % looop over sections
        wi = w(i);
        alphai = alpha(i);
        nx = ceil(DX(i)/dx);   %[-] INT number of subsections
        hij = nan(nx,1);
        hij(1) = h(i);
        for j = 2:nx
            
            wij = wi-j/nx*dw(i);
            alphaij = alphai-j/nx*dalpha(i);
            hij(j)=fFindH0(Jf(i), ck(k), hij(j-1), wij, alphaij, Q);
        end
        hi(i) = hij(end);
    end
    hk(k) = mean(hi);
    ck(k+1)=fEvaldhk(hk,mean(h),ck, k);
    eps = abs(mean(h)-hk(k))/mean(h);
    k = k+1;
    if k > 10^4
        break;
    end
end
if not(Qb)
    writeData1 = [mean(h), hk(k-1)]; % mean error
    writeData2 = [h(end), hi(end)];  % downstream error
    xlswrite(xlsName,writeData1, 3, ['C',num2str(dq+4),':',...
                        'D',num2str(dq+4)]); % accuracy report
    xlswrite(xlsName,writeData2, 3, ['F',num2str(dq+4),':',...
                        'G',num2str(dq+4)]); % accuracy report
end
%disp(['---> SECTION ', num2str(i), '-', num2str(i+1), ' finished.'])
ck=ck(k);

wm = mean(w);
alpham = mean(alpha);
Rh = mean(hi)*(wm+mean(hi)/tand(alpham))/(wm+2*mean(hi)/sind(alpham));
kst = ck/Rh^(1/6);
end

