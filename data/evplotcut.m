function evplotcut(V,D,valout,fontsize,ev1name,ev2name)
%plot the distance D at the angles made up by V...

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

V;
D;
valout;
axPos=get(gca,'Position');
xlim=get(gca,'xLim');
ylim=get(gca,'yLim');
%obtain angles...
ang1=atan2(V(1,2),V(1,1));
ang2=atan2(V(2,2),V(2,1));
x1=D(1)*cos(ang1);
x2=D(2)*cos(ang2);
y1=D(1)*sin(ang1);
y2=D(2)*sin(ang2);
xarr1=axPos(1)+axPos(3)*([0,x1]-xlim(1))/(xlim(2)-xlim(1));
yarr1=axPos(2)+axPos(4)*([0,y1]-ylim(1))/(ylim(2)-ylim(1));
annotation('arrow',xarr1,yarr1);
%labeling the annotation arrows in the center just above the arrow:
ndegrees=5;
texttheta=asin(y1/D(1))*180/pi+ndegrees;
textthetarad=texttheta*pi/180;
if x1==0
    tx=0;
else
    %NOTE it was cos(textthetarad)/2) in this line before...as with all
    %others below.  This labels at the midpoint instead of the end.
    tx=abs(D(1)*cos(textthetarad))*(x1/abs(x1));
end
if y1==0
    ty=0;
else
    ty=abs(D(1)*sin(textthetarad))*(y1/abs(y1));
end
text(tx,ty,ev1name,'FontSize',fontsize,'FontWeight','bold','BackgroundColor',[1 1 1]); 
%labeling the annotation arrows in the center just above the arrow:
xarr2=axPos(1)+axPos(3)*([0,x2]-xlim(1))/(xlim(2)-xlim(1));
yarr2=axPos(2)+axPos(4)*([0,y2]-ylim(1))/(ylim(2)-ylim(1));
annotation('arrow',xarr2,yarr2);
texttheta2=asin(y2/D(2))*180/pi+ndegrees;
textthetarad2=texttheta2*pi/180;
if x2==0
    tx2=0;
else
    tx2=abs(D(2)*cos(textthetarad2))*(x2/abs(x2));
end
if y2==0
    ty2=0;
else
    ty2=abs(D(2)*sin(textthetarad2))*(y2/abs(y2));
end
text(tx2,ty2,ev2name,'FontSize',fontsize,'FontWeight','bold','BackgroundColor',[1 1 1]); 
end
