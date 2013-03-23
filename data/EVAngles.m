function [EVa1,EVa2,EVa3]=EVAngles(EVec,EV,ConvMatrx,Temperature_List,xtalvect,lsfits,inUVW)
% gets the angle between the eigenvetors of the thermal expansion matrix
% and the crystallographic vector given.  Inputs datin: the data output 
% from getPtTemp,datname: The name of the phase of interest,ordn: the order
% to use when fitting the CTE of the hkl's, Temperature_List: a list of temperatures
% to use when calculating the thermal expansion matrix,xtalvect: the hkl
% that the output angle will be with respect to.

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

allgood1=1;
if allgood1
    for ctr1=1:length(Temperature_List)
        if (inUVW==1)
            hklvect=UVWtoHKL(lsfits,xtalvect,Temperature_List(ctr1));
        else
            hklvect=xtalvect;
        end
        %disp(sprintf('temp=%d',Temperature_List(ctr1)));
        invMat1(:,:,ctr1)=inv(ConvMatrx(:,:,ctr1));
        %[EVec,EV]=eigenshuffle(TensorSet);
        %eigtmp(:,:,ctr1)=diag(EV(ctr1))
        vec1(ctr1,:)=EVec(:,1,ctr1)';
        vec2(ctr1,:)=EVec(:,2,ctr1)';
        vec3(ctr1,:)=EVec(:,3,ctr1)';
        crystv1(ctr1,:)=(invMat1(:,:,ctr1)*EVec(:,1,ctr1))';
        crystv2(ctr1,:)=(invMat1(:,:,ctr1)*EVec(:,2,ctr1))';
        crystv3(ctr1,:)=(invMat1(:,:,ctr1)*EVec(:,3,ctr1))';
        %refvec=(ConvMatrx(:,:,ctr1)*refhkl);
        refvec=(ConvMatrx(:,:,ctr1)*hklvect);
        ang1(ctr1)=getang(EVec(:,1,ctr1),refvec);
        ang2(ctr1)=getang(EVec(:,2,ctr1),refvec);
        ang3(ctr1)=getang(EVec(:,3,ctr1),refvec);
        %disp('vect3');
        %disp(EVec(:,3,ctr1));
        %disp(sprintf('angle=%f',ang3(ctr1)));
        %disp(sprintf('eigval=%e',EV(3,ctr1)));
    end
    %figure;
    %plot(Temperature_List,ang1,'o-r',Temperature_List,ang2,'o-g',Temperature_List,ang3,'o-b');  
end
EVa1=ang1;
EVa2=ang2;
EVa3=ang3;
end
function angout=getang(vecA,vecB)
%tmp1=vec1'*vec2;
%tmp2=tmp1/sqrt(vec1'*vec1);
%tmp3=tmp2/sqrt(vec2'*vec2);
%angout=acos(tmp3)*180/pi;
tmp1=vrrotvec(vecA,vecB);
angout=tmp1(4)*180/pi;
end
