function frameset=MakeMovieFrames(Temperature_List,Frames_Per_Second,V1,e1s,xscreen,yscreen)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%Function to create a set of frames for a movie of the CTE quadratic
    %surface.  Developed by Zachary Jones on Jan 21, 2010.   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%frameset is the array of movie frames.    
    %%xdata, ydata, zdata, and cdata are X,Y,and Z coordinates.  C is just
    %passed because it likes to feel important.    
    %%axismaximum is the maximum axis requirement.  It is used to set the
    %axes all the same so the quadratic surface appears to grow/shrink
    %rather than stay the same size but have the axes change.    
    %%Temperature_List is the list of temperatures to plot.  
    %%Frames_Per_Second should be self-explanatory
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%LET US BEGIN...

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

    %Obtain the size of the screen currently being worked on
    if nargin<3
    Frames_Per_Second=10;
    end
    TotalLength=length(Temperature_List);
    ssize=get(0,'ScreenSize');
    xdata=zeros(101,101,TotalLength);
    ydata=zeros(101,101,TotalLength);
    zdata=zeros(101,101,TotalLength);
    cdata=zeros(101,101,TotalLength);
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
    for n=1:TotalLength
        [xdata(:,:,n),ydata(:,:,n),zdata(:,:,n),cdata(:,:,n)]=plotEllipsoid(V1(:,:,n),e1s(:,n));
    end
    axismaximum=max([max(max(max(xdata))) max(max(max(ydata))) max(max(max(zdata)))]);
    %Set the figure to be centered at 75% the size of the screen.
    h=figure('Position',[((ssize(3)/2)-(ssize(3)*3/8)) ((ssize(4)/2)-(ssize(4)*3/8)) xscreen yscreen]);
    nlimit=length(Temperature_List);
    for n=1:length(Temperature_List)
        %plot the surface
        surf(xdata(:,:,n),ydata(:,:,n),zdata(:,:,n),cdata(:,:,n),'FaceColor','interp','FaceLighting','phong');
        view(160,10)
        %set the axes right
        axis([-axismaximum axismaximum -axismaximum axismaximum -axismaximum axismaximum])
        axis square
        %set a UIUC-approved colormap :)
        colormap([1,.7,0;0,0,1]);
        box on
        %Show temperatures as the title for every 100 degrees C.
        if n==1
            figtitle=strcat('T=',num2str(Temperature_List(n)),char(176),'C');
        end
        %if rem(Temperature_List(n),100)==0
        %    figtitle=strcat('T=',num2str(Temperature_List(n)),char(176),'C');
        %end
        %Correction, show temperatures as the title, updated every second.
        if(rem(n,Frames_Per_Second)==0 || n==1 || n==nlimit)
            figtitle=strcat('T=',num2str(Temperature_List(n)),char(176),'C');
        end
        title(figtitle,'FontSize',titlesize,'FontWeight','bold');
        %Label the axes
        %xlabel(strcat('X Thermal Expansion (1/',char(176),'C) \times 10^{-6}'));
        %ylabel(strcat('Y Thermal Expansion (1/',char(176),'C) \times 10^{-6}'));
        %zlabel(strcat('Z||c Thermal Expansion (1/',char(176),'C) \times 10^{-6}'));
        set(gca, 'ZTickLabel',num2str(transpose(abs(get(gca,'ZTick'))/10^-6)));        
        set(gca, 'YTickLabel',num2str(transpose(abs(get(gca,'YTick'))/10^-6)));
        set(gca, 'XTickLabel',num2str(transpose(abs(get(gca,'XTick'))/10^-6)));
        xlabel('X');
        ylabel('Y');
        zlabel('Z||c');
        set(gca,'FontSize',fontsize)
        %Make it shiny!
        camlight(40,45)
        %get the frame
        frameset(n)=getframe(h);
    end
    %add 5 seconds of the last frame for viewing purposes.
    for ef=n+1:n+(5*Frames_Per_Second)+1
        frameset(ef)=frameset(n);
    end
end
