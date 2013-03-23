function [xs,ys,zs,cs]=plotEllipsoid(V1,e1s)
%output x,y,z, and cmap coordinates for plotting an Ellipsoid using M1, a

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

%thermal expansion tensor of rank two.
q1=[0:0.02:2]*pi;
q2=[0:0.02:2]*pi;
[q1,q2]=meshgrid(q1,q2);
% get the radial values of the ellipsoid at q1 and q2 respectively
%this one works for now:
r1=e1s(1)*(cos(q1).^2).*(sin(q2).^2)+e1s(2)*(sin(q1).^2).*(sin(q2).^2)+e1s(3)*(cos(q2).^2);
%r1=1+(r1p*deltaT);
% convert to cartesian coordinates
x1=r1.*cos(q1).*sin(q2);
y1=r1.*sin(q1).*sin(q2);
z1=r1.*cos(q2);

% plot the ellipsoid
%figure(num);
%mesh(x1,y1,z1);
%view(160,10)
%axis equal
%box on

% rotate the from the eigenvector axes to the original axes
% define the original coordinates
C1=eye(3);
% get the rotation matrix
rot1=getRotationMat(V1,C1);

%define New point by applying rotation
xs=rot1(1,1)*x1+rot1(1,2)*y1+rot1(1,3)*z1;
ys=rot1(2,1)*x1+rot1(2,2)*y1+rot1(2,3)*z1;
zs=rot1(3,1)*x1+rot1(3,2)*y1+rot1(3,3)*z1;

cs=0<r1;
cs=(cs/2)+.1;

end
