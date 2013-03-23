function PlotEigenvalues(TensorSet,Temps,xscreen,yscreen) 

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

ssize=get(0,'ScreenSize');
%set font size
fontsize=round(xscreen/85);
if(fontsize<12)
    fontsize=12;
end   
%set title size
titlesize=round(xscreen/50);
if(titlesize<20)
    titlesize=20;
end
k=figure('Position',[((ssize(3)/2)-(ssize(3)*3/8)) ((ssize(4)/2)-(ssize(4)*3/8)) xscreen yscreen]);
[V,EVs]=eigenshuffle(TensorSet);
plot(Temps,EVs,':o');
evlegend=['E1';'E2';'E3'];
legend(evlegend);
title('Eigenvalues vs. Temperature','FontSize',titlesize,'FontWeight','bold');
xlabel(strcat('Temperature (',char(176),'C)'),'FontSize',fontsize);
ylabel('Eigenvalues','FontSize',fontsize);
set(gca,'FontSize',fontsize);
end
