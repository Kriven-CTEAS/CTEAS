function twodvals=EllipseWrap(TensorSet,ConvMatrx,TempRanges,aval,bval,cval,lsfits,xscreen,yscreen,inUVW2)
%This function takes the set of CTE tensors calculated in CTERun.m or an 
%array of tensor matrices and uses them to plot 2-dimensional ellipses 
%that are color mapped.  It calculates a color map based on the temperature ranges
%for every stepsize degrees.
%Default color starts off as blue.

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

%Default color starts off as blue.
    ColorMaps=[0 0 1];
    maxtemp=max(TempRanges)-min(TempRanges+1);
    stepsize=TempRanges(2)-TempRanges(1);
    TotalLength=length(TempRanges);
    %CmapStepSize=1/maxtemp*stepsize;
    CmapStepSize=ColorMaps(1,3)/TotalLength;
    LineWidthStepSize=1/TotalLength;
    LineWidth=0.75;
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
    for n=1:1:TotalLength
        if inUVW2==1
           avalc=aval;
           bvalc=bval;
           cvalc=cval;
        else
           newuvw=HKLtoUVW(lsfits,[aval;bval;cval],TempRanges(n));
           avalc=newuvw(1);
           bvalc=newuvw(2);
           cvalc=newuvw(3);
        end
        %FIX THIS!!!
        if ColorMaps(1,1)>1
            ColorMaps(1,1)=1;
        end
        if ColorMaps(1,3)<0
            ColorMaps(1,3)=0;
        end
        [V(:,:,n),D(:,:,n),valout(n),t1(n),t2(n),twodvals(:,1,n),twodvals(:,2,n)]=plotEllipse(TensorSet(:,:,n),[avalc;bvalc;cvalc],ConvMatrx(:,:,n),ColorMaps,LineWidth);
%        ColorMaps(1,1)=ColorMaps(1,1)-(CmapStepSize);
%        ColorMaps(1,2)=ColorMaps(1,2)-(CmapStepSize);
%        ColorMaps(1,3)=ColorMaps(1,3)-(CmapStepSize);
%        LineWidth=LineWidth+LineWidthStepSize;
		 ColorMaps(1,1)=ColorMaps(1,1)+(CmapStepSize);
         ColorMaps(1,3)=ColorMaps(1,3)-(CmapStepSize);
    end
     ip1=addarrow4(TensorSet(:,:,1),[avalc;bvalc;cvalc],ConvMatrx(:,:,1),[1;0;0],' ',fontsize);
     ip2=addarrow4(TensorSet(:,:,TotalLength),[avalc;bvalc;cvalc],ConvMatrx(:,:,TotalLength),[1;0;0],'a',fontsize);
     ip3=addarrow4(TensorSet(:,:,1),[avalc;bvalc;cvalc],ConvMatrx(:,:,1),[0;1;0],' ',fontsize);
     ip4=addarrow4(TensorSet(:,:,TotalLength),[avalc;bvalc;cvalc],ConvMatrx(:,:,TotalLength),[0;1;0],'b',fontsize);
     ip5=addarrow4(TensorSet(:,:,1),[avalc;bvalc;cvalc],ConvMatrx(:,:,1),[0;0;1],' ',fontsize);
     ip6=addarrow4(TensorSet(:,:,TotalLength),[avalc;bvalc;cvalc],ConvMatrx(:,:,TotalLength),[0;0;1],'c',fontsize);
     %evplotcut(V(:,:,1),D(:,:,1),valout(1));
     if((ip1+ip2+ip3+ip4+ip5+ip6)<=2)
         %display eigenvectors instead
         rotatedvect1=antirotateVect([V(1,1,1);V(1,2,1);0],-1*t1(1),-1*t2(n));
         rotatedvect2=antirotateVect([V(2,1,1);V(2,2,1);0],-1*t1(1),-1*t2(n));
         [ev1cname,ev2cname]=namevects(rotatedvect1,rotatedvect2,lsfits,TempRanges(1));
         evplotcut(V(:,:,1),D(:,:,1),valout(1),fontsize,ev1cname,ev2cname);
         if (V(1,1,1)<0 && V(1,1,TotalLength)>0) || (V(1,1,1)>0 && V(1,1,TotalLength)<0)
             rotatedvect3=antirotateVect([-1*V(1,1,TotalLength);-1*V(1,2,TotalLength);0],-1*t1(TotalLength),-1*t2(TotalLength));
             rotatedvect4=antirotateVect([-1*V(2,1,TotalLength);-1*V(2,2,TotalLength);0],-1*t1(TotalLength),-1*t2(TotalLength));
             [ev1hname,ev2hname]=namevects(rotatedvect3,rotatedvect4,lsfits,TempRanges(TotalLength));
             evplotcut(-1*V(:,:,TotalLength),D(:,:,TotalLength),valout(TotalLength),fontsize,ev1hname,ev2hname);
         else
             rotatedvect3=antirotateVect([V(1,1,TotalLength);V(1,2,TotalLength);0],-1*t1(TotalLength),-1*t2(TotalLength));
             rotatedvect4=antirotateVect([V(2,1,TotalLength);V(2,2,TotalLength);0],-1*t1(TotalLength),-1*t2(TotalLength));
             [ev1hname,ev2hname]=namevects(rotatedvect3,rotatedvect4,lsfits,TempRanges(TotalLength));
             evplotcut(V(:,:,TotalLength),D(:,:,TotalLength),valout(TotalLength),fontsize,ev1hname,ev2hname);
         end
     end
    string1='Thermal Expansion Ellipsoid Cross-Section';
    string3=strcat(num2str(aval),';',num2str(bval),';',num2str(cval));
    if inUVW2==1
        string2=' Perpendicular to the [';
        string4='] uvw Vector';
    else
        string2=' in the (';
        string4=') hkl Plane';
    end
    fullstring=strcat(string1,string2,string3,string4);
    title(fullstring,'FontSize',titlesize,'FontWeight','bold');
    xlabel(strcat('Thermal Expansion (1/',char(176),'C) \times 10^{-6}'));
    ylabel(strcat('Thermal Expansion (1/',char(176),'C) \times 10^{-6}'));
    set(gca,'FontSize',fontsize);
    %set tick labels
    set(gca, 'YTickLabel',num2str(transpose(abs(get(gca,'YTick'))/10^-6)));
    set(gca, 'XTickLabel',num2str(transpose(abs(get(gca,'XTick'))/10^-6)));
end
