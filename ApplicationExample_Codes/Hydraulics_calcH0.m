% Script uses function fFindH0 to solve for the flow depth of stations in
% input file
% 
% January 2016, Sebastian SCHWINDT
% EPF Lausanne, LCH
%--------------------------------------------------------------------------

clear all;
close all;

% INPUT
%--------------------------------------------------------------------------
%cd ..
%data = xlsread('PrototypeHydraulics.xls',1,'D5:O125');
g = 9.81;           %[m/s²]
Q = [50;100;200];   %[m³/s]
beta = 22.6199;          %[°] bank slope in line with investigations
w0 = 8;          %[m] bed base width
D50 = 0.09167;      %[m]
D84 = 0.80;        %[m]
D90 = 0.17;        %[m] --> C=27.96 for Q50
Db = 1.;           %[m]
J = 0.02;          %[-]
%cd('Matlab');


% Solve for Flow Depth h0
%--------------------------------------------------------------------------
h0 = nan(size(Q));
v = nan(size(Q));
A = nan(size(Q));
P = nan(size(Q));
kst = nan(size(Q));
hFr07 = nan(size(Q));

for i = 1:numel(Q)
    [v(i), h0(i), A(i), P(i), kst(i)] = fFindH0_rev(w0, beta, D90, J, Q(i));
    hFr07(i) = fGethFr(beta,Q(i),w0);
end

v = Q./A;
Rh = A./P;
n = 1./kst;
C = 1./n .* Rh.^(1/6);
wsurf = w0+2*h0/tand(beta);
b = 0.5*wsurf
a = 0.9*h0(1)

