function [UVW]=HKLtoUVW(lsfits,HKL,Temp)

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

%a,b,c,alpha,beta, and gamma have to be calculated from the curve fits at a
%specific temperature.
a=getLPTemp(lsfits.a,Temp);
b=getLPTemp(lsfits.b,Temp);
c=getLPTemp(lsfits.c,Temp);
alpha=getLPTemp(lsfits.alpha,Temp);
beta=getLPTemp(lsfits.beta,Temp);
gamma=getLPTemp(lsfits.gamma,Temp);
S11=b^2*c^2*sin(dtr(alpha))^2;
S12=a*b*c^2*(cos(dtr(alpha))*cos(dtr(beta))-cos(dtr(gamma)));
S13=a*b^2*c*(cos(dtr(gamma))*cos(dtr(alpha))-cos(dtr(beta)));
S22=a^2*c^2*sin(dtr(beta))^2;
S23=a^2*b*c*(cos(dtr(beta))*cos(dtr(gamma))-cos(dtr(alpha)));
S33=a^2*b^2*sin(dtr(gamma))^2;
Uden=(HKL(1)*S11+HKL(2)*S12+HKL(3)*S13);
Vden=(HKL(1)*S12+HKL(2)*S22+HKL(3)*S23);
Wden=(HKL(1)*S13+HKL(2)*S23+HKL(3)*S33);
%solve by stating that U+V+W==1
U=1/(1+(Vden/Uden)+(Wden/Uden));
V=(U/Uden)*Vden;
W=(U/Uden)*Wden;
UVW=[U;V;W];
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

function radian=dtr(degree)
radian=degree*(pi/180);
end
