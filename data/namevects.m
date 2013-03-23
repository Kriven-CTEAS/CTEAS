function [name1,name2]=namevects(invect1,invect2,lsfits,Temp)

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

ainvect1=invect1;
ainvect2=invect2;
for i=1:length(ainvect1)
    if abs(ainvect1(i)) < 1*10^-12
        ainvect1(i)=0;
    end
    if abs(ainvect2(i)) < 1*10^-12
        ainvect2(i)=0;
    end
end
apart1=num2str(ainvect1(1));
apart2=num2str(ainvect1(2));
apart3=num2str(ainvect1(3));
bpart1=num2str(ainvect2(1));
bpart2=num2str(ainvect2(2));
bpart3=num2str(ainvect2(3));
% uvwa=HKLtoUVW(lsfits,[apart1,apart2,apart3],Temp);
% uvwb=HKLtoUVW(lsfits,[bpart1,bpart2,bpart3],Temp);
% uvwa1=num2str(uvwa(1));
% uvwa2=num2str(uvwa(2));
% uvwa3=num2str(uvwa(3));
% uvwb1=num2str(uvwb(1));
% uvwb2=num2str(uvwb(2));
% uvwb3=num2str(uvwb(3));
% name1a=strcat('hkl(',apart1,';',apart2,';',apart3,')');
% name1b=strcat('uvw[',uvwa1,';',uvwa2,';',uvwa3,']');
% name2a=strcat('hkl(',bpart1,';',bpart2,';',bpart3,')');
% name2b=strcat('uvw[',uvwb1,';',uvwb2,';',uvwb3,']');
hkla=HKLtoUVW(lsfits,[apart1,apart2,apart3],Temp);
hklb=HKLtoUVW(lsfits,[bpart1,bpart2,bpart3],Temp);
hkla1=num2str(hkla(1));
hkla2=num2str(hkla(2));
hkla3=num2str(hkla(3));
hklb1=num2str(hklb(1));
hklb2=num2str(hklb(2));
hklb3=num2str(hklb(3));
name1b=strcat('uvw(',apart1,';',apart2,';',apart3,')');
name1a=strcat('hkl[',hkla1,';',hkla2,';',hkla3,']');
name2b=strcat('uvw(',bpart1,';',bpart2,';',bpart3,')');
name2a=strcat('hkl[',hklb1,';',hklb2,';',hklb3,']');
name1=[name1a,char(10),name1b];
name2=[name2a,char(10),name2b];
end
