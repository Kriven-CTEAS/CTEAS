function rotMat=getRotationMat(M1,M2)
%gets the rotation matrix for converting from M2 axes to M1 axes
% M2 is the old axis and M1 is the new axis such that Z'=AZ when converting
% Z in in M2 to Z' in M1

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

rotMat=[getCos(M1(:,1),M2(:,1)),getCos(M1(:,2),M2(:,1)),getCos(M1(:,3),M2(:,1));...
    getCos(M1(:,1),M2(:,2)),getCos(M1(:,2),M2(:,2)),getCos(M1(:,3),M2(:,2));...
    getCos(M1(:,1),M2(:,3)),getCos(M1(:,2),M2(:,3)),getCos(M1(:,3),M2(:,3))];

end

function val1=getCos(x1,x2)
val1=x1'*x2/(norm(x1)*norm(x2));
end
