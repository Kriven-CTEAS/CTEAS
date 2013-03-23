function getCTEeigVecAngle(datin,datname,ordn,temp1,xtalvect)
% gets the angle between the eigenvetors of the thermal expansion matrix
% and the crystallographic vector given.  Inputs datin: the data output 
% from getPtTemp,datname: The name of the phase of interest,ordn: the order
% to use when fitting the CTE of the hkl's, temp1: a list of temperatures
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
sv1=size(xtalvect);
if ((sv1(1)==3)&&(sv1(2)==1))
    refhkl=xtalvect;
elseif ((sv1(1)==1)&&(sv1(2)==3))
    refhkl=xtalvect';
else
    disp('the reference vector is not of the correct dimmentions');
    allgood1=0;
end

if allgood1
    
    [lsfits,entries,params] = xtalCTEprep(datin,datname,ordn);


    for ctr1=1:length(temp1)
        [ten1,conMat1]=xtalCTE(lsfits,entries,params,temp1(ctr1));
        disp(sprintf('temp=%d',temp1(ctr1)));
        invMat1=inv(conMat1);
        [t1,t2]=eig(ten1);
        eigtmp(ctr1,:)=diag(t2);
        %disp(t1);
        vec1(ctr1,:)=t1(:,1)';
        vec2(ctr1,:)=t1(:,2)';
        vec3(ctr1,:)=t1(:,3)';
        crystv1(ctr1,:)=(invMat1*t1(:,1))';
        crystv2(ctr1,:)=(invMat1*t1(:,2))';
        crystv3(ctr1,:)=(invMat1*t1(:,3))';
        refvec=(conMat1*refhkl);
        %disp(refvec);
%         disp(refvec);
%         refvec=[0 0 1]';
        %getang(vec1,vec2);
        ang1(ctr1)=getang(t1(:,1),refvec);
        %disp('vect1');
        %disp(t1(:,1));
        %disp(sprintf('angle=%f',ang1(ctr1)));
        %disp(sprintf('eigval=%e',eigtmp(ctr1,1)));
        ang2(ctr1)=getang(t1(:,2),refvec);
        %disp('vect2');
        %disp(t1(:,2));
        %disp(sprintf('angle=%f',ang2(ctr1)));
        %disp(sprintf('eigval=%e',eigtmp(ctr1,2)));
        ang3(ctr1)=getang(t1(:,3),refvec);
        disp('vect3');
        disp(t1(:,3));
        disp(sprintf('angle=%f',ang3(ctr1)));
        disp(sprintf('eigval=%e',eigtmp(ctr1,3)));
    end
    figure;
    plot(temp1,ang1,'o-r');
    figure;
    plot(temp1,ang2,'o-g');
    figure;
    plot(temp1,ang3,'o-b');
    
end

end

function angout=getang(vec1,vec2)

tmp1=vec1'*vec2;
tmp2=tmp1/sqrt(vec1'*vec1);
tmp3=tmp2/sqrt(vec2'*vec2);
angout=acos(tmp3)*180/pi;
end
