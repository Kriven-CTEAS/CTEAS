function inplane=addarrow4(M1,p1,ConMat,a1,axis,fontsize)
%Adds an arrow to a 2-D thermal expansion plot if the arrow exists in the
%plane of the thermal expansion that is being analyzed.  Returns 1 if in
%plane, 0 if not in plane.  Labels the arrow according to the string
%provided by axis.
%convert a1 into a unit vector on orthonormal axis

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

a2=UVWToorth(ConMat,a1);
temp1=UVWToorth(ConMat,p1);
tempang=getCos(temp1,a2);
%check to see if in plane
if ((~tempang==0) && (abs(tempang)>1e-15))
    %disp('the arrow is not in the plane');
    if axis ~= ' '
        val=sprintf('the %s axis is not in the plane',axis);
        disp(val);
    else
        disp('the arrow is not in the plane');
    end
    inplane=0;
else
    inplane=1;
    %determine angles theta1 and phi1 between a1 and the z-axis.
    [phi1,theta1]=UVWToAng(a1,ConMat);
    %determine magnitude of vector
    [valout,Mf]=getCTEVect(M1,phi1,theta1);
    %assign length to vector
    orth1=a2*valout;
    %determine theta and phi for the p1 uvw we're looking down wrt z-axis.
    [t1,t2]=UVWToAng(p1,ConMat);
    %the -1's are to correct for conventions...also by convention, 0;1;0 is
    %already going the right direction.  This has to do with how matlab
    %rotates about axes and not so much with how things should
    %mathematically work...this has worked in both monoclinic and
    %orthorhombic cases tested.
    m1=rotateVect([-1;0;0],t1,t2);
    m2=rotateVect([0;1;0],t1,t2);
    m3=rotateVect([0;0;-1],t1,t2);
    M2=[m1';m2';m3'];
    r1=getRotationMat(eye(3),M2);
    at3=a2'*r1;
    a3=at3'*valout;
    %commands for centering on the plot
    axPos=get(gca,'Position');
    xlim=get(gca,'xLim');
    ylim=get(gca,'yLim');
    set(gca,'FontSize',fontsize);
    %create a [x1,x2],[y1,y2] set of coordinates for the arrow annotation.
    xarr=axPos(1)+axPos(3)*([0,a3(1)]-xlim(1))/(xlim(2)-xlim(1));
    yarr=axPos(2)+axPos(4)*([0,a3(2)]-ylim(1))/(ylim(2)-ylim(1));
    %this is to keep the annotation function from getting grumpy about
    %the length of the arrow:    
    hold on;
    if abs(xarr(2))>1
        xarr(2)=1;
        axis='arrow incorrect';
    end
    if abs(yarr(2))>1
        yarr(2)=1;
        axis='arrow incorrect';
    end
    annotation('arrow',xarr,yarr);
    %labeling the annotation arrows in the center just above the arrow:
    ndegrees=5;
    texttheta=asin(a3(2)/valout)*180/pi+ndegrees;
    textthetarad=texttheta*pi/180;
    if a3(1)==0
        tx=0;
    else
        tx=abs(valout*cos(textthetarad)/2)*(a3(1)/abs(a3(1)));
    end
    if a3(2)==0
        ty=0;
    else
        ty=abs(valout*sin(textthetarad)/2)*(a3(2)/abs(a3(2)));
    end
    if axis ~= ' '
        text(tx,ty,axis,'FontSize',fontsize,'FontWeight','bold','BackgroundColor',[1 1 1]);  
    end
end
end
%% Function to get dot product
function val1=getCos(x1,x2)
val1=x1'*x2/(norm(x1)*norm(x2));
end

%% Function to get cross product
function xout=crossProd(x1,x2)
    M1=[0,-x1(3),x1(2);x1(3),0,-x1(1);-x1(2),x1(1),0];
    xout=M1*x2;
end
