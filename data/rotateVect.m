function as1=rotateVect(a1,T1,T2)

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

%a1 is a vector in x,y,z coordinates
%T1 and T2 are theta and phi, respectively...in degrees.

%convert T1 and T2 to radians:
t1=(T1)*pi/180;
t2=(T2)*pi/180;
t3=(0)*pi/180;
t4=(0)*pi/180;

%Establish basic transformation matrices for rotation:
%Rx=[1,0,0;0,cos(t3),-sin(t3);0,sin(t3),cos(t3)];
Ry=[cos(t1),0,-sin(t1);0 1 0;sin(t1),0,cos(t1)];
Rz=[cos(t2),sin(t2),0;-sin(t2),cos(t2),0;0,0,1];
Rzz=[cos(t3),-sin(t3),0;sin(t3),cos(t3),0;0,0,1];
Ryy=[cos(t4),0,-sin(t4);0 1 0;sin(t4),0,cos(t4)];
%Rotate about the Z-axis and then about the Y-axis:
Rfv=Ryy*Rzz*Ry*Rz;

%Multiply the a1 vector by the Rfv rotation matrix:
ast=a1'*Rfv;
as1=ast';
