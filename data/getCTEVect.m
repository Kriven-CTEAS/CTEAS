function [valout,Mf]=getCTEVect(M1,phi,theta)
%get the thermal expansion in a direction where phi is the angle
%between the vector and the z axis and theta is the angle 
%between the projection of the vector on the x-y plane and the x axis

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

phi1=phi*pi/180;
theta1=theta*pi/180;

% Rx=[1,0,0;0,cos(t3),-sin(t3);0,sin(t3),cos(t3)];
Ry=[cos(phi1),0,-sin(phi1);0 1 0;sin(phi1),0,cos(phi1)];
Rz=[cos(theta1),sin(theta1),0;-sin(theta1),cos(theta1),0;0,0,1];

Rfm=Ry*Rz;

%Mt1=Rz*M1*Rz';
%Mt2=Ry*Mt1*Ry';
%Mf=Mt2;
Mf=Rfm*M1*Rfm';

valout=Mf(3,3);
%valout=Mf(1,1);


end

