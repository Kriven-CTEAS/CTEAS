function [avg1,Mf]=getCTEPlane(M1,T1,T2)

%get the average thermal expansion in a plane where T1 is the angle
%between the plane normal and the z axis and T2 is the angle 
%between the projection of the plane normal on the x-y plane and the x axis

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

t1=T1*pi/180;
t2=T2*pi/180;

R1=[cos(t1),0,-sin(t1);0 1 0;sin(t1),0,cos(t1)];
R2=[cos(t2),-sin(t2),0;sin(t2),cos(t2),0;0,0,1];

%R1=[1,0,0;0,cos(t1),sin(t1);0,-sin(t1),cos(t1)];

%R2=[cos(t2),sin(t2),0;-sin(t2),cos(t2),0;0,0,1];

Rf=R1*R2;
Mf=Rf*M1*Rf';

Mpln=Mf(1:2,1:2);
if ~isfinite(Mpln)
    disp(T1);
    disp(T2);
    disp(Mpln);
end
[v1,etmp]=eig(Mpln);
e1=[etmp(1,1),etmp(2,2)];



avg1=mean(e1);
plot1=0;
if plot1==1
    
    th1=0:1:180;
    rval=th1;
    xval=th1;
    yval=th1;
    for ctr1=1:length(th1)
        R3=[cos(th1(ctr1)*pi/180), sin(th1(ctr1)*pi/180); -sin(th1(ctr1)*pi/180), cos(th1(ctr1)*pi/180)];
        Mtmp=R3*Mpln*R3';
        rval(ctr1)=Mtmp(1,1);
        %rval(ctr1)=e1(1)*(sin(th1(ctr1)*pi/180)^2)+e1(2)*(cos(th1(ctr1)*pi/180)^2);
        xval(ctr1)=rval(ctr1)*cos(th1(ctr1)*pi/180);
        yval(ctr1)=rval(ctr1)*sin(th1(ctr1)*pi/180);
    end

    hold on;
    plot([xval,xval],[yval,-yval],'b:')
    hold off;
end

end

