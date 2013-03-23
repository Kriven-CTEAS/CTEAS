function datout=getcsvdata(dir1)
%datout is output data
%dir1 is the directory location of the files of interest
%prefix1 is a common set of characters that are contained at the start of a
%filename, eg. HfO2Stand1, HfO2Stand2 -> prefix1 would be 'HfO2Stand'

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

if ((~strcmp(dir1(end),'\'))&&(~strcmp(dir1(end),'/')))
    dir1=strcat(dir1,'\');
end
%lst1=dir(strcat(dir1,prefix1,'*','.csv'));
lst1=dir(strcat(dir1,'*.csv'));
for ctr1=1:length(lst1)
    filedone=0;
    fid1=fopen(strcat(dir1,lst1(ctr1).name));
    datout(ctr1).filename=lst1(ctr1).name;
    disp(strcat('reading ... ',datout(ctr1).filename));
    cnt2=1;
        while filedone==0
            tline = fgetl(fid1);
            %disp(tline);            
            n=find(tline==',',1);
            queueword=tline(1:n-1);
            if strncmp('!',tline,length('!'))
                if strncmp('!ENDPHASE',tline,length('!ENDPHASE'))
                    cnt2=cnt2+1;
                end
                if strncmp('!EOF',tline,length('!EOF'))
                    filedone=1;
                    break;
                end
                if strncmp('!BEGINHKL',tline,length('!BEGINHKL'))
                    queueword='!BEGINHKL';
                end
                if strncmp('!TEMPERATURE',tline,length('!TEMPERATURE'))
                    stuff=tline(n+1:end);
                    bbb=find(stuff==',',1);
                    if bbb>0
                        stuff=stuff(1:bbb-1);
                    end
                    datout(ctr1).temp.tempC=str2num(stuff);
                    datout(ctr1).temp.tempErr=0;  
                end
                switch lower(queueword)
                    case '!phase'
                        stuff=tline(n+1:end);
                        bbb=find(stuff==',',1);
                        if bbb>0
                            stuff=stuff(1:bbb-1);
                        end
                        datout(ctr1).chem(cnt2).name=stuff;
                    case '!symmetry'
                        stuff=tline(n+1:end);
                        bbb=find(stuff==',',1);
                        if bbb>0
                            stuff=stuff(1:bbb-1);
                        end
                        datout(ctr1).chem(cnt2).structure=stuff;
                    case '!lpa'
                        nn=find(tline(n+1:end)==',',1);
                        datout(ctr1).chem(cnt2).a=str2num(tline(n+1:nn+n-1));
                        datout(ctr1).chem(cnt2).aErr=str2num(tline(nn+n:end));
                    case '!lpb'
                        nn=find(tline(n+1:end)==',',1);
                        datout(ctr1).chem(cnt2).b=str2num(tline(n+1:nn+n-1));
                        datout(ctr1).chem(cnt2).bErr=str2num(tline(nn+n:end));
                    case '!lpc'
                        nn=find(tline(n+1:end)==',',1);
                        datout(ctr1).chem(cnt2).c=str2num(tline(n+1:nn+n-1));
                        datout(ctr1).chem(cnt2).cErr=str2num(tline(nn+n:end));
                    case '!lpalpha'
                        nn=find(tline(n+1:end)==',',1);
                        datout(ctr1).chem(cnt2).alpha=str2num(tline(n+1:nn+n-1));
                        datout(ctr1).chem(cnt2).alphaErr=str2num(tline(nn+n:end));
                    case '!lpbeta'
                        nn=find(tline(n+1:end)==',',1);
                        datout(ctr1).chem(cnt2).beta=str2num(tline(n+1:nn+n-1));
                        datout(ctr1).chem(cnt2).betaErr=str2num(tline(nn+n:end));
                    case '!lpgamma'
                        nn=find(tline(n+1:end)==',',1);
                        datout(ctr1).chem(cnt2).gamma=str2num(tline(n+1:nn+n-1));
                        datout(ctr1).chem(cnt2).gammaErr=str2num(tline(nn+n:end));
                    case '!beginhkl'
                        cnt1=0;
                        while 1
                            tline=fgetl(fid1);
                            if strncmp('!ENDHKL',tline,length('!ENDHKL'))
                                break;
                            end
                            if strncmp('#',tline,length('#'))
                                tline=fgetl(fid1);
                            end
                            cnt1=cnt1+1;
                            ns=find(tline==',',3);
                            datout(ctr1).chem(cnt2).h(cnt1)=str2num(tline(1:ns(1)-1));
                            datout(ctr1).chem(cnt2).k(cnt1)=str2num(tline(ns(1)+1:ns(2)-1));
                            datout(ctr1).chem(cnt2).l(cnt1)=str2num(tline(ns(2)+1:ns(3)-1));
                            nn=find(tline==',',1);
                            datout(ctr1).chem(cnt2).d(cnt1)=str2num(tline(ns(3)+1:end));
                        end
                end    
            end
        end
    fclose(fid1);
end
end
