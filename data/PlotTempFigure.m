function PlotTempFigure(Temperature,V1,e1s,xscreen,yscreen)

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

%Obtain monitor screen size to suitably size figures and movie.
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
    i=figure('Position',[((ssize(3)/2)-(ssize(3)*3/8)) ((ssize(4)/2)-(ssize(4)*3/8)) xscreen yscreen]);
    xdata=zeros(101,101);
    ydata=zeros(101,101);
    zdata=zeros(101,101);
    cdata=zeros(101,101);
    [xdata(:,:),ydata(:,:),zdata(:,:),cdata(:,:)]=plotEllipsoid(V1,e1s);
    axismaximum=max([max(max(max(xdata))) max(max(max(ydata))) max(max(max(zdata)))]);
    surf(xdata,ydata,zdata,cdata,'FaceColor','interp','FaceLighting','phong');
    view(160,10)
    axis([-axismaximum axismaximum -axismaximum axismaximum -axismaximum axismaximum])
    axis square
    colormap([1,.7,0;0,0,1]);
    box on
    figtitle=strcat('T=',num2str(Temperature),char(176),'C');
    set(gca, 'FontSize',fontsize);
    title(figtitle,'FontSize',titlesize,'FontWeight','bold');
    xlabel(strcat('X Thermal Expansion (1/',char(176),'C) \times 10^{-6}'));
    ylabel(strcat('Y Thermal Expansion (1/',char(176),'C) \times 10^{-6}'));
    zlabel(strcat('Z||c Thermal Expansion (1/',char(176),'C) \times 10^{-6}'));
    set(gca, 'ZTickLabel',num2str(transpose(abs(get(gca,'ZTick'))/10^-6)));        
    set(gca, 'YTickLabel',num2str(transpose(abs(get(gca,'YTick'))/10^-6)));
    set(gca, 'XTickLabel',num2str(transpose(abs(get(gca,'XTick'))/10^-6)));  
    camlight(40,45);
end
