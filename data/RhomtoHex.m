function datout=RhomtoHex(datin)

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

A=[2/3 1/3 1/3;-1/3 1/3 1/3;-1/3 -2/3 1/3]';
datout=datin;
for i=1:length(datin)
    for j=1:length(datin(i).chem)
        if strcmpi(datin(i).chem(j).structure,'rhombohedral')
            for k=1:length(datin(i).chem(j).h)
                hkl=A*[datin(i).chem(j).h(k);datin(i).chem(j).k(k);datin(i).chem(j).l(k)];
                datout(i).chem(j).h(k)=hkl(1);
                datout(i).chem(j).k(k)=hkl(2);
                datout(i).chem(j).l(k)=hkl(3);               
            end
        datout(i).chem(j).alpha=90;
        datout(i).chem(j).beta=90;
        datout(i).chem(j).gamma=120;
        datout(i).chem(j).a=((3*datin(i).chem(j).a^2)/(1+3*((1/(2*sin(degtorad(datin(i).chem(j).alpha/2))))-1)^2))^1/2;
        datout(i).chem(j).b=datout(i).chem(j).a;
        datout(i).chem(j).c=datout(i).chem(j).a*sqrt(3/(2*sin(degtorad(datin(i).chem(j).alpha/2)))^2-3);
        end
end

end
