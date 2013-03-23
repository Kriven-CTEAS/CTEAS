function [V,D,valout,t1,t2,x1,y1]=plotEllipse(M1,p1,ConMat,cmap,LineSize)
% M1 is the matrix of the ellipsoid and p1 is the principle axis to plot

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

%% get the eigenvalues and eigenvectors
[t1,t2]=UVWToAng(p1,ConMat);
[valout,Mf]=getCTEVect(M1,t1,t2);
Mplane=Mf(1:2,1:2);
[V,D]=eigenshuffle(Mplane);
t3=[0:.01:2]*pi;
r1=(Mplane(1,1)*(cos(t3)).^2)-(2*Mplane(1,2)*cos(t3).*sin(t3))+(Mplane(2,2)*(sin(t3)).^2);
x1=r1.*cos(t3);
y1=r1.*sin(t3);
plot(x1,y1,'-','Color',cmap,'LineWidth',LineSize);
hold on;
axPos=get(gca,'Position');
xlim=get(gca,'xLim');
ylim=get(gca,'yLim');
axis equal;
end
