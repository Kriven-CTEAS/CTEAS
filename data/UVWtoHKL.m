function [HKL]=UVWtoHKL(lsfits,UVW,Temp)

%CTERun License

%Copyright (c) 2012, The Kriven Research Group. All rights reserved.

%Redistribution and use in source and binary forms, with or without
%modification, are permitted provided that the following conditions are met: 

%1. Redistributions of source code must retain the above copyright notice, this
%   list of conditions and the following disclaimer. 
%2. Redistributions in binary form must reproduce the above copyright notice,
%   this list of conditions and the following disclaimer in the documentation
%   and/or other materials provided with the distribution. 

%THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
%ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
%WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
%DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
%ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
%(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
%LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
%ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
%(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
%SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

%The views and conclusions contained in the software and documentation are those
%of the authors and should not be interpreted as representing official policies, 
%either expressed or implied, of the FreeBSD Project.

%using equations from Andrews et al. (1971)
a=getLPTemp(lsfits.a,Temp);
b=getLPTemp(lsfits.b,Temp);
c=getLPTemp(lsfits.c,Temp);
alpha=getLPTemp(lsfits.alpha,Temp)*(pi/180);
beta=getLPTemp(lsfits.beta,Temp)*(pi/180);
gamma=getLPTemp(lsfits.gamma,Temp)*(pi/180);
U=UVW(1);
V=UVW(2);
W=UVW(3);

Hden=(U*a^2+V*a*b*cos(gamma)+W*c*a*cos(beta));
Kden=(U*a*b*cos(gamma)+V*b^2+W*b*c*cos(alpha));
Lden=(U*c*a*cos(beta)+V*b*c*cos(alpha)+W*c^2);

%H/Hden=K/Kden=L/Lden, assume H+K+L==1 to solve for an HKL.
H=1/(1+(Kden/Hden)+(Lden/Hden));
K=(H/Hden)*Kden;
L=(H/Hden)*Lden;
%Truncation error elimination
%any number less than 1e-10 is effectively zero.
if H<=10^-10
    H=0;
end
if K<=10^-10
    K=0;
end
if L<=10^-10
    L=0;
end
HKL=[H;K;L];
end
%% Retrive lattice parameters for a temperature
function lpout=getLPTemp(fit1,T1)
    lpoutln=0;
    T0=25;
    for ctr1=1:length(fit1)
        lpoutln=lpoutln+fit1(end-ctr1+1)*((T1-T0).^(ctr1-1));
    end
    lpout=exp(lpoutln);
end
