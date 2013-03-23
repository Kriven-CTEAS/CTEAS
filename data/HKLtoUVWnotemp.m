function [UVW]=HKLtoUVWnotemp(a,b,c,alpha,beta,gamma,HKL)

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

S11=b^2*c^2*sin(degtorad(alpha))^2;
S12=a*b*c^2*(cos(degtorad(alpha))*cos(degtorad(beta))-cos(degtorad(gamma)));
%unsure about these four:
S13=a*b^2*c*(cos(degtorad(gamma))*cos(degtorad(alpha))-cos(degtorad(beta)));
S22=a^2*c^2*sin(degtorad(beta))^2;
S23=a^2*b*c*(cos(degtorad(beta))*cos(degtorad(gamma))-cos(degtorad(alpha)));
S33=a^2*b^2*sin(degtorad(gamma))^2;
Uden=(HKL(1)*S11+HKL(2)*S12+HKL(3)*S13);
Vden=(HKL(1)*S12+HKL(2)*S22+HKL(3)*S23);
Wden=(HKL(1)*S13+HKL(2)*S23+HKL(3)*S33);
%solve by stating that U+V+W==1
U=1/(1+(Vden/Uden)+(Wden/Uden));
V=(U/Uden)*Vden;
W=(U/Uden)*Wden;
UVW=[U;V;W];
end
