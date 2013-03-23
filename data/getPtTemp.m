%Written by Ryan Haggerty, modified by Zach Jones
function datout=getPtTemp(datin,RefTval)
%Using a room temperature reference of 20C, moves through datin adjusting
%temperatures to closer-to-actual values using a RefTval determined from a
%Platinum lattice constant when included in JADE .rrp files.  If no
%Platinum lattice constant exists, set RefTval equal to zero within
%CTERun.m and adjust temperature when the option is given during the
%execution of the CTERun.m script.

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

for ctr1=1:length(datin)
    refNum1=0;
    if(length(datin(ctr1).chem)==2)
        % Assumption that other phases don't start with P
        if strcmp(datin(ctr1).chem(1).name(1),'P')
            aVal1=datin(ctr1).chem(1).a;
            aErr1=datin(ctr1).chem(1).aErr;
            [Tcal1,Terr1]=TempPt(aVal1,aErr1,RefTval);
        else
            aVal1=datin(ctr1).chem(2).a;
            aErr1=datin(ctr1).chem(2).aErr;
            [Tcal1,Terr1]=TempPt(aVal1,aErr1,RefTval);
        end
        datout(ctr1)=struct('filename',datin(ctr1).filename,'chem',datin(ctr1).chem,...
            'temp',struct('tempC',Tcal1,'tempErr',Terr1));
    elseif (length(datin(ctr1).chem)>2)
        for ctr2=1:length(datin(ctr1).chem)
            % Assumption that other phases don't start with P
            if strcmp(datin(ctr1).chem(ctr2).name(1),'P')
                refNum1=ctr2;
                break;
            end
        end
        if refNum1>0
            aVal1=datin(ctr1).chem(refNum1).a;
            aErr1=datin(ctr1).chem(refNum1).aErr;
            [Tcal1,Terr1]=TempPt(aVal1,aErr1,RefTval);
            datout(ctr1)=struct('filename',datin(ctr1).filename,'chem',datin(ctr1).chem,...
            'temp',struct('tempC',Tcal1,'tempErr',Terr1));
        else

            datout(ctr1)=struct('filename',datin(ctr1).filename,'chem',datin(ctr1).chem,...
                'temp',struct('tempC',0,'tempErr',0));
        end
        
    else
        datout(ctr1)=struct('filename',datin(ctr1).filename,'chem',datin(ctr1).chem,...
            'temp',struct('tempC',0,'tempErr',0));
    
    end


end

end


function [Tcal,Terr]=TempPt(aVal,aErr,RefTval)
    if RefTval == 0
        RefTvali=1;
    else
        RefTvali=RefTval;
    end
    RefT=20;
    PtDaa=((aVal-RefTval)/RefTvali)*100;
    PtDaaErr=((aVal+aErr-RefTval)/RefTvali)*100;
    Tcal=(3.8274*(PtDaa^3))-(130.5739*(PtDaa^2))+(1101.6564*(PtDaa))+RefT;
    Terr=(3.8274*(PtDaaErr^3))-(130.5739*(PtDaaErr^2))+(1101.6564*(PtDaaErr))+RefT-Tcal;
    
end
