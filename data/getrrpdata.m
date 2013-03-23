function datout=getrrpdata(dir1)
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
%lst1=dir(strcat(dir1,prefix1,'*','.rrp'));
lst1=dir(strcat(dir1,'*.rrp'));

for ctr1=1:length(lst1)
    fid1=fopen(strcat(dir1,lst1(ctr1).name));
    datout(ctr1).filename=lst1(ctr1).name;
    disp(strcat('reading ... ',datout(ctr1).filename));
    cnt2=0;
        while 1
            tline = fgetl(fid1);
            %disp(tline);
            if ~ischar(tline), break, end
            if strncmp('WPF Refinement Logs',tline,length('WPF Refinement Logs')), break, end
            if length(tline)>5
                if strcmp(tline(1:5),'Phase')
                    cnt2=cnt2+1;
                    indx1=find(tline==':',1);
                    datout(ctr1).chem(cnt2).name=tline(indx1+2:end);
                    symgroup='';
                    while 1
                        tline = fgetl(fid1);
                        indx1=find(tline==':',1);
                        if ~isempty(indx1)
                           switch lower(tline(3:indx1-1))
                               case 'cubic'
                                   symgroup='Cubic';
                               case 'tetragonal'
                                   symgroup='Tetragonal';
                               case 'orthorhombic'
                                   symgroup='Orthorhombic';
                               case 'hexagonal'
                                   symgroup='Hexagonal';
                               case 'trigonal'
                                   symgroup='Trigonal';
                               case 'monoclinic'
                                   symgroup='Monoclinic';
                               case 'triclinic'
                                   symgroup='Triclinic';
                               case 'rhombohedral'
                                   symgroup='Rhombohedral';
                           end
                        end
                        if ~isempty(symgroup)
                            break;
                        end
                    end
                    datout(ctr1).chem(cnt2).structure=symgroup;
                    while 1        
                        tline = fgetl(fid1);
                        if length(tline)>=11
                            if strcmp(tline(1:11),'  [x] a  = ')
                                break;
                            elseif strcmp(tline(1:11),'  [ ] a  = ')
                                break;
                            end
                        end
                    end
                    datout(ctr1).chem(cnt2).a=str2num(tline(12:18));
                    datout(ctr1).chem(cnt2).aErr=str2num(tline(21:28));
                    datout(ctr1).chem(cnt2).alpha=str2num(tline(46:53));
                    datout(ctr1).chem(cnt2).alphaErr=str2num(tline(55:61));
                    tline = fgetl(fid1);
                    datout(ctr1).chem(cnt2).b=str2num(tline(12:18));
                    datout(ctr1).chem(cnt2).bErr=str2num(tline(21:28));
                    datout(ctr1).chem(cnt2).beta=str2num(tline(46:53));
                    datout(ctr1).chem(cnt2).betaErr=str2num(tline(55:61));
                    tline = fgetl(fid1);
                    datout(ctr1).chem(cnt2).c=str2num(tline(12:18));
                    datout(ctr1).chem(cnt2).cErr=str2num(tline(21:28));
                    datout(ctr1).chem(cnt2).gamma=str2num(tline(46:53));
                    datout(ctr1).chem(cnt2).gammaErr=str2num(tline(55:61));
                    while (length(tline)<=9)||(~strcmp(tline(4:9),' h k l'))
                        tline = fgetl(fid1);
                        if ~ischar(tline), break, end
                    end
                    tline=fgetl(fid1);
%                     for ctr2=1:11
%                         tline = fgetl(fid1);
%                     end
                    cnt1=0;
                    while length(tline)>5
                        cnt1=cnt1+1;
                        %disp(tline);
                        if ~ischar(tline), break, end
                        ctr2=1;
                        varcounter=1;
                        hasvalue=0;
                        outpart(1).value='';
                        outpart(2).value='';
                        outpart(3).value='';
                        outpart(4).value='';
                        outpart(5).value='';
                        outpart(6).value='';
                        outpart(7).value='';
                        outpart(8).value='';
                        outpart(9).value='';
                        outpart(10).value='';
                        outpart(11).value='';
                        outpart(12).value='';
                        for i=1:length(tline)
                            switch tline(i)
                                case ' '
                                    if hasvalue==1
                                        varcounter=varcounter+1;
                                        hasvalue=0;
                                        ctr2=1;
                                    end
                                 case char(9)
                                    if hasvalue==1
                                        varcounter=varcounter+1;
                                        hasvalue=0;
                                        ctr2=1;
                                    end

                                case ''
                                    if hasvalue==1
                                        varcounter=varcounter+1;
                                        hasvalue=0;
                                        ctr2=1;
                                    end
                                case '('
                                    %disp('found (');
                                    %
                                case ')'
                                    %disp('found )');
                                case ','
                                    %disp('found ,');
                                otherwise
                                    hasvalue=1;
                                    outpart(varcounter).value(ctr2)=tline(i);
                                    ctr2=ctr2+1;
                            end
                        end
                        datout(ctr1).chem(cnt2).h(cnt1)=str2num(outpart(1).value);
                        datout(ctr1).chem(cnt2).k(cnt1)=str2num(outpart(2).value);
                        datout(ctr1).chem(cnt2).l(cnt1)=str2num(outpart(3).value);
                        datout(ctr1).chem(cnt2).d(cnt1)=str2num(outpart(5).value);  
                        tline = fgetl(fid1);
                    end
                end
            end 
        end
    fclose(fid1);
end
