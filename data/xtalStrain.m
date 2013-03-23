function [ten1,conMat1] = xtalStrain(lsfits,entriesT,params,T,system,T_room)
%%xtalStrain extracts formatted data in datin for the phase named phasename and
%%calulates the strain tensor at temperature T based on a
%%polynomial fit of order ordn

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

% calculate the conversion matrix for a given temperature
[conMat1,mcalcs]=getconversionmat(lsfits.a,lsfits.b,lsfits.c,lsfits.alpha,lsfits.beta,lsfits.gamma,T,T_room);
RecipMat=getRecipConMatrix(lsfits.a,lsfits.b,lsfits.c,lsfits.alpha,lsfits.beta,lsfits.gamma,T,mcalcs,T_room);
%RecipMat=inv(conMat1);
%initialize variables into vectors or matricies of zeros
dstrain=zeros(1,length(entriesT));
dstrainErr=dstrain;
xyz1=zeros(length(entriesT),3);
xyznrm=xyz1;
for ctr1=1:length(entriesT)
    [dstrain(ctr1),dstrainErr(ctr1)]=getStrainTempWErr(params(ctr1),T,T_room);
    xyz1(ctr1,:)=(RecipMat*entriesT(ctr1).hkl')';
    xyznrm(ctr1,:)=xyz1(ctr1,:)/sqrt(xyz1(ctr1,:)*xyz1(ctr1,:)');
end
ten1=fitStrainTensorWeighted(xyznrm,dstrain,dstrainErr,system);
end
%% get the conversion matrix 
% To convert from crystal lattice to an orthonormal lattice 
function [conMatOut,mcalcsout]=getconversionmat(fita,fitb,fitc,fitalpha,fitbeta,fitgamma,T,T_room)
% function conMatOut=getconversionmat(fita,fitb,fitc,fitalpha,fitbeta,fitgamma,T)
% Use the next lines to for fit as thermal expanstion (ie. ln(a)vs T-25)
% (Change must also be made in xtalCTEprep)
aval=getLPTemp(fita,T,T_room);
bval=getLPTemp(fitb,T,T_room);
cval=getLPTemp(fitc,T,T_room);
alphaval=getLPTemp(fitalpha,T,T_room);
betaval=getLPTemp(fitbeta,T,T_room);
gammaval=getLPTemp(fitgamma,T,T_room);

A11=aval*sin(betaval*pi/180);
A12=bval*(cos(gammaval*pi/180)-cos(betaval*pi/180)*cos(alphaval*pi/180))/sin(betaval*pi/180);
A22=bval*((sin(alphaval*pi/180)^2)-((A12^2)/(bval^2)))^.5;
A31=aval*cos(betaval*pi/180);
A32=bval*cos(alphaval*pi/180);
A33=cval;
mcalcsout=[A11,A12,A22,A31,A32,A33];
conMatOut=[A11,A12,0;0,A22,0;A31,A32,A33];
end

%% Retrive reciprocal conversion matrix
function matOut=getRecipConMatrix(fita,fitb,fitc,fitalpha,fitbeta,fitgamma,T,mcalcs,T_room)
aval=getLPTemp(fita,T,T_room);
bval=getLPTemp(fitb,T,T_room);
cval=getLPTemp(fitc,T,T_room);
alphaval=getLPTemp(fitalpha,T,T_room);
betaval=getLPTemp(fitbeta,T,T_room);
gammaval=getLPTemp(fitgamma,T,T_room);

m11=mcalcs(1);
m12=mcalcs(2);
m22=mcalcs(3);
m31=mcalcs(4);
m32=mcalcs(5);
m33=mcalcs(6);
Vol=aval*bval*cval*((1-(cos(alphaval*pi/180)^2)-(cos(betaval*pi/180)^2)-(cos(gammaval*pi/180)^2)+2*cos(alphaval*pi/180)*cos(betaval*pi/180)*cos(gammaval*pi/180))^.5);

n11=m22*m33/Vol;
n13=-m31*m22/Vol;
n21=-m12*m33/Vol;
n22=aval*cval*sin(betaval*pi/180)/Vol;
n23=(m31*m12-m11*m32)/Vol;
n33=m11*m22/Vol;

matOut=[n11,0,n13;n21,n22,n23;0,0,n33];

end


%% Retrive lattice parameters for a temperature
function lpout=getLPTemp(fit1,T1,T_room)
    lpoutln=0;
    for ctr1=1:length(fit1)
        lpoutln=lpoutln+fit1(end-ctr1+1)*((T1-T_room).^(ctr1-1));
    end
    lpout=exp(lpoutln);
end

%% Retrive the strain with error
% retrives the discrete strain value of a d spacing or a lattice
% parameter as a function of temperature
function [epsilonout,epsilonErr]=getStrainTempWErr(fit1,T1,T_room)
    epsilonout=0;
    for ctr1=1:length(fit1.p(1:end-1))
        epsilonout=epsilonout+((fit1.p(end-ctr1)*(ctr1))*((T1-T_room)^(ctr1-1)));
    end
    %disp(alphaout);
    [dVal,dErr]=polyval(fit1.p,T1-T_room,fit1.S);
    epsilonErr=epsilonout*dErr/dVal;  
end

%% Fit the strain tensor
function tenout=fitStrainTensorWeighted(xyzin,dstrainin,dstrainErr,system)
% form a weighting matrix equal to the inverse of the variance for each
% strain measurement assuming the error given is the standard deviation
% of the strain measurement.
W1=diag(1./(dstrainErr.*dstrainErr));
switch lower(system)
    case 'triclinic'
        x1=[xyzin(:,1)'.*xyzin(:,1)'; xyzin(:,2)'.*xyzin(:,2)'; xyzin(:,3)'.*xyzin(:,3)'; xyzin(:,1)'.*xyzin(:,2)'; xyzin(:,1)'.*xyzin(:,3)'; xyzin(:,2)'.*xyzin(:,3)']';
        %tentemp=x1\dctein';
        tentemp=inv(x1'*W1*x1)*x1'*W1*dstrainin';
        tenout=[tentemp(1),tentemp(4)/2,tentemp(5)/2;tentemp(4)/2,tentemp(2),tentemp(6)/2;tentemp(5)/2,tentemp(6)/2,tentemp(3)];
    case 'monoclinic'
        x1=[xyzin(:,1)'.*xyzin(:,1)'; xyzin(:,2)'.*xyzin(:,2)'; xyzin(:,3)'.*xyzin(:,3)'; xyzin(:,1)'.*xyzin(:,3)']';
        %tentemp=x1\dctein';
        tentemp=inv(x1'*W1*x1)*x1'*W1*dstrainin';
        tenout=[tentemp(1),0,tentemp(4)/2;0,tentemp(2),0;tentemp(4)/2,0,tentemp(3)];
    case 'orthorhombic'
        x1=[xyzin(:,1)'.*xyzin(:,1)'; xyzin(:,2)'.*xyzin(:,2)'; xyzin(:,3)'.*xyzin(:,3)']';
        %tentemp=x1\dctein';
        tentemp=inv(x1'*W1*x1)*x1'*W1*dstrainin';
        tenout=[tentemp(1),0,0;0,tentemp(2),0;0,0,tentemp(3)];
    case 'hexagonal'
        x1=[xyzin(:,1)'.*xyzin(:,1)'+ xyzin(:,2)'.*xyzin(:,2)'; xyzin(:,3)'.*xyzin(:,3)']';
        %tentemp=inv(x1'*x1)*x1'*dctein';
        tentemp=inv(x1'*W1*x1)*x1'*W1*dstrainin';
        tenout=[tentemp(1),0,0;0,tentemp(1),0;0,0,tentemp(2)];
    case 'tetragonal'
        x1=[xyzin(:,1)'.*xyzin(:,1)'+ xyzin(:,2)'.*xyzin(:,2)'; xyzin(:,3)'.*xyzin(:,3)']';
        %tentemp=inv(x1'*x1)*x1'*dctein';
        tentemp=inv(x1'*W1*x1)*x1'*W1*dstrainin';
        tenout=[tentemp(1),0,0;0,tentemp(1),0;0,0,tentemp(2)];
    case 'cubic'
        x1=[xyzin(:,1)'.*xyzin(:,1)'+ xyzin(:,2)'.*xyzin(:,2)'+ xyzin(:,3)'.*xyzin(:,3)']';
        %tentemp=inv(x1'*x1)*x1'*dctein';
        tentemp=inv(x1'*W1*x1)*x1'*W1*dstrainin';
        tenout=[tentemp(1),0,0;0,tentemp(1),0;0,0,tentemp(1)];
    %case 'rhombohedral'
    case 'trigonal'
        x1=[xyzin(:,1)'.*xyzin(:,1)'+ xyzin(:,2)'.*xyzin(:,2)'; xyzin(:,3)'.*xyzin(:,3)']';
        tentemp=inv(x1'*W1*x1)*x1'*W1*dstrainin';
        tenout=[tentemp(1),0,0;0,tentemp(1),0;0,0,tentemp(2)];
    case 'rhombohedral'
        x1=[xyzin(:,1)'.*xyzin(:,1)'+ xyzin(:,2)'.*xyzin(:,2)'; xyzin(:,3)'.*xyzin(:,3)']';
        %tentemp=inv(x1'*x1)*x1'*dctein';
        tentemp=inv(x1'*W1*x1)*x1'*W1*dstrainin';
        tenout=[tentemp(1),0,0;0,tentemp(1),0;0,0,tentemp(2)];        
end
        
end
