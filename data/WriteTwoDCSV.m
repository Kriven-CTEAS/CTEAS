function WriteTwoDCSV(matrix1,temps,outputfilename)
%Format matrix1 as side-by-side matrix and write to outputfilename.csv in
%a human-readable format.

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

cntr=1;
for i=1:size(matrix1,3)
    for j=1:size(matrix1,2)
        stuff(:,cntr)=matrix1(:,j,i);
        cntr=cntr+1;
    end
end
header1='';
header2='';
for i=1:length(temps)
   strpart=num2str(temps(i));
   header1=strcat(header1,strpart,',',strpart,',');
   header2=strcat(header2,'x,y,');
end
fidpath=strcat(outputfilename,'.csv');
fid1=fopen(fidpath,'wt');
fprintf(fid1,'%s\n',header1);
fprintf(fid1,'%s\n',header2);
for i=1:size(stuff,1)
    fprintf(fid1,'%d,',stuff(i,:));
    fprintf(fid1,'\n');
end
fclose(fid1);
end
