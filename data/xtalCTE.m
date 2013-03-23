function [ten1,ten1Err,conMat1] = xtalCTE(lsfits,entriesT,params,T,system,T_room)
%%xtalCTE extracts formatted data in datin for the phase named phasename and
%%calulates the thermal expansion tensor at temperature T based on a
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
[conMat1,mcalcs,conMat1Err,mcalcsErr]=getconversionmat(lsfits,T,T_room);
[RecipMat,RecipMatErr]=getRecipConMatrix(lsfits,T,mcalcs,mcalcsErr,T_room);
%RecipMat=inv(conMat1);
%initialize variables into vectors or matricies of zeros
dcte=zeros(1,length(entriesT));
dcteErr=dcte;
xyz1=zeros(length(entriesT),3);
xyz1Err=xyz1;
xyznrm=xyz1;
xyznrmErr=xyznrm;
% Use ErrorWeighted=1 if you would like to weight the cte of each hkl by the relative error equal to 1/variance
% the variance is calculated based on the fit to the cte of each hkl.
ErrorWeighted=1;
for ctr1=1:length(entriesT)
    if ErrorWeighted==1;
        [dcte(ctr1),dcteErr(ctr1)]=getCTETempWErr(params(ctr1),T,T_room);
    else
        dcte(ctr1)=getCTETemp(params(ctr1).p,T,T_room);
    end
    xyz1(ctr1,:)=(RecipMat*entriesT(ctr1).hkl')';
    x1=RecipMat;
    x2=RecipMatErr;
    hkls=entriesT(ctr1).hkl;
    count=1;
    for(i=1:3)
        for(j=1:3)
           varlist(count)=x1(i,j);
           varlist2(count)=x2(i,j);
           count=count+1;
        end
    end
    tmpvars=varlist;
    for(i=1:10)
        if i==1
            for(j=1:9)
                tmpvars2=tmpvars;
                tmpvars2(j)=tmpvars(j)+varlist2(j);
                tempx3=[tmpvars2(1) tmpvars2(2) tmpvars2(3);tmpvars2(4) tmpvars2(5) tmpvars2(6);tmpvars2(7) tmpvars2(8) tmpvars2(9)];
                temp=tempx3*hkls';
                if(sqrt(xyz1Err(1)^2+xyz1Err(2)^2+xyz1Err(3)^2)<sqrt(temp(1)^2+temp(2)^2+temp(3)^2))
                    xyz1Err(ctr1,:)=temp';
                end
            end    
        else
            tmpvars(i-1)=tmpvars(i-1)+varlist2(i-1);
            for(j=i:9)
                tmpvars2=tmpvars;
                tmpvars2(j)=tmpvars(j)+varlist2(j);
                tempx3=[tmpvars2(1) tmpvars2(2) tmpvars2(3);tmpvars2(4) tmpvars2(5) tmpvars2(6);tmpvars2(7) tmpvars2(8) tmpvars2(9)];
                temp=tempx3*hkls';
                if(sqrt(xyz1Err(1)^2+xyz1Err(2)^2+xyz1Err(3)^2)<sqrt(temp(1)^2+temp(2)^2+temp(3)^2))
                    xyz1Err(ctr1,:)=temp';
                end
            end    
        end
    end
    xyz1Err(ctr1,:)=abs(xyz1Err(ctr1,:)-xyz1(ctr1,:));
    xyznrm(ctr1,:)=xyz1(ctr1,:)/sqrt(xyz1(ctr1,:)*xyz1(ctr1,:)');
    xyznrmErr(ctr1,:)=abs(xyznrm(ctr1,:)).*(2.*(xyz1Err(ctr1,:)./xyz1(ctr1,:)).^2).^(1/2);
    xyznrmlen=length(xyznrmErr(ctr1,:));
    for xyzi=1:xyznrmlen
        if isnan(xyznrmErr(ctr1,xyzi)) == 1
            xyznrmErr(ctr1,xyzi)=0;
        end
    end
end
if ErrorWeighted==1;
    [ten1,ten1Err]=fitCTETensorWeighted(xyznrm,xyznrmErr,dcte,dcteErr,system);
else
    ten1=fitCTETensor(xyznrm,dcte,system);
end
end
%% get the conversion matrix 
% To convert from crystal lattice to an orthonormal lattice 
function [conMatOut,mcalcsout,conMatOutErr,mcalcsoutErr]=getconversionmat(fits,T,T_room)
% function conMatOut=getconversionmat(fita,fitb,fitc,fitalpha,fitbeta,fitgamma,T)
% Use the next lines to for fit as thermal expanstion (ie. ln(a)vs T-25)
% (Change must also be made in xtalCTEprep)
aval=getLPTemp(fits.a,T,T_room);
aErrval=getLPTemp(fits.aErrorU,T,T_room)-aval;
bval=getLPTemp(fits.b,T,T_room);
bErrval=getLPTemp(fits.bErrorU,T,T_room)-bval;
cval=getLPTemp(fits.c,T,T_room);
cErrval=getLPTemp(fits.cErrorU,T,T_room)-cval;
alphaval=getLPTemp(fits.alpha,T,T_room);
alphaErrval=getLPTemp(fits.alphaErrorU,T,T_room)-alphaval;
betaval=getLPTemp(fits.beta,T,T_room);
betaErrval=getLPTemp(fits.betaErrorU,T,T_room)-betaval;
gammaval=getLPTemp(fits.gamma,T,T_room);
gammaErrval=getLPTemp(fits.gammaErrorU,T,T_room)-gammaval;

A11=aval*sin(betaval*pi/180);
A12=bval*(cos(gammaval*pi/180)-cos(betaval*pi/180)*cos(alphaval*pi/180))/sin(betaval*pi/180);
A22=bval*((sin(alphaval*pi/180)^2)-((A12^2)/(bval^2)))^.5;
A31=aval*cos(betaval*pi/180);
A32=bval*cos(alphaval*pi/180);
A33=cval;

A11Err=abs(A11)*(sqrt((aErrval/aval)^2+((betaErrval*pi/180)*(cot(betaval*pi/180)))^2));
A12Erra=((cos(betaval*pi/180)*cos(alphaval*pi/180))/sin(betaval*pi/180))*sqrt(((betaErrval*pi/180)*tan(betaval*pi/180))^2+((alphaErrval*pi/180)*tan(alphaval*pi/180))^2+((betaErrval*pi/180)*cot(betaval*pi/180))^2);
A12Errb=(gammaErrval*pi/180)*tan(gammaval*pi/180)*cos(gammaval*pi/180);
A12Err=abs(A12)*sqrt((bErrval/bval)^2+((sqrt(A12Erra^2+A12Errb^2))/(cos(gammaval*pi/180)-((cos(betaval*pi/180)*cos(alphaval*pi/180))/sin(betaval*pi/180))))^2);
A22Err=abs(A22)*sqrt((bErrval/bval)^2+((1/2*(sqrt((2*(((alphaErrval*pi/180)*cot(alphaval*pi/180))/sin(alphaval*pi/180)))^2+(sqrt((2*A12Err/A12)^2+(2*bErrval/bval)^2)*(A12^2/bval^2))^2)))/(sin(alphaval*pi/180)^2-(A12^2/bval^2)))^2);
A31Err=abs(A31)*sqrt((aErrval/aval)^2+((betaErrval*pi/180)*tan(betaval*pi/180))^2);
A32Err=abs(A32)*sqrt((bErrval/bval)^2+((alphaErrval*pi/180)*tan(alphaval*pi/180))^2);
A33Err=cErrval;
mcalcsout=[A11,A12,A22,A31,A32,A33];
mcalcsoutErr=[abs(A11Err),abs(A12Err),abs(A22Err),abs(A31Err),abs(A32Err),abs(A33Err)];
conMatOut=[A11,A12,0;0,A22,0;A31,A32,A33];
conMatOutErr=[abs(A11Err),abs(A12Err),0;0,abs(A22Err),0;abs(A31Err),abs(A32Err),abs(A33Err)];
end

%% Retrive reciprocal conversion matrix
function [matOut,matOutErr]=getRecipConMatrix(fits,T,mcalcs,mcalcsErr,T_room)
aval=getLPTemp(fits.a,T,T_room);
aErrval=getLPTemp(fits.aErrorU,T,T_room)-aval;
bval=getLPTemp(fits.b,T,T_room);
bErrval=getLPTemp(fits.bErrorU,T,T_room)-bval;
cval=getLPTemp(fits.c,T,T_room);
cErrval=getLPTemp(fits.cErrorU,T,T_room)-cval;
alphaval=getLPTemp(fits.alpha,T,T_room);
alphaErrval=getLPTemp(fits.alphaErrorU,T,T_room)-alphaval;
betaval=getLPTemp(fits.beta,T,T_room);
betaErrval=getLPTemp(fits.betaErrorU,T,T_room)-betaval;
gammaval=getLPTemp(fits.gamma,T,T_room);
gammaErrval=getLPTemp(fits.gammaErrorU,T,T_room)-gammaval;

m11=mcalcs(1);
m12=mcalcs(2);
m22=mcalcs(3);
m31=mcalcs(4);
m32=mcalcs(5);
m33=mcalcs(6);
Vola=2*cos(alphaval*pi/180)*cos(betaval*pi/180)*cos(gammaval*pi/180);
Volb=(1-(cos(alphaval*pi/180)^2)-(cos(betaval*pi/180)^2)-(cos(gammaval*pi/180)^2)+Vola);
Volc=sqrt(Volb);
Vol=aval*bval*cval*Volc;
m11Err=mcalcsErr(1);
m12Err=mcalcsErr(2);
m22Err=mcalcsErr(3);
m31Err=mcalcsErr(4);
m32Err=mcalcsErr(5);
m33Err=mcalcsErr(6);
VolErra=Vola*sqrt(((alphaErrval*pi/180)*tan(alphaval*pi/180))^2+((betaErrval*pi/180)*tan(betaval*pi/180))^2+((gammaErrval*pi/180)*tan(gammaval*pi/180))^2);
VolErrb=sqrt(VolErra^2+(2*(gammaErrval*pi/180)*tan(gammaval*pi/180)*cos(gammaval*pi/180)^2)^2+(2*(betaErrval*pi/180)*tan(betaval*pi/180)*cos(betaval*pi/180)^2)^2+(2*(alphaErrval*pi/180)*tan(alphaval*pi/180)*cos(alphaval*pi/180)^2)^2);
VolErrc=(1/2)*VolErrb/Volb;
VolErr=Vol*sqrt((aErrval/aval)^2+(bErrval/bval)^2+(cErrval/cval)^2+(VolErrc/Volc)^2);

n11=m22*m33/Vol;
n13=-m31*m22/Vol;
n21=-m12*m33/Vol;
n22=aval*cval*sin(betaval*pi/180)/Vol;
n23=(m31*m12-m11*m32)/Vol;
n33=m11*m22/Vol;
n11Err=n11*sqrt((m22Err/m22)^2+(m33Err/m33)^2+(VolErr/Vol)^2);
n13Err=n13*sqrt((m31Err/m31)^2+(m22Err/m22)^2+(VolErr/Vol)^2);
n21Err=n21*sqrt((m12Err/m12)^2+(m33Err/m33)^2+(VolErr/Vol)^2);
n22Err=n22*sqrt((aErrval/aval)^2+(cErrval/cval)^2+((betaErrval*pi/180)*cot(betaval*pi/180))^2+(VolErr/Vol)^2);
n23Err=n23*sqrt(((((m31*m12)*(sqrt((m31Err/m31)^2+(m12Err/m12)^2)))^2+((m11*m32)*sqrt((m11Err/m11)^2+(m32Err/m32)^2))^2)/((m31*m12)-(m11*m32)))^2+(VolErr/Vol)^2);
n33Err=n33*sqrt((m11Err/m11)^2+(m22Err/m22)^2+(VolErr/Vol)^2);

matOut=[n11,0,n13;n21,n22,n23;0,0,n33];
matOutErr=[n11Err,0,n13Err;n21Err,n22Err,n23Err;0,0,n33Err];

end


%% Retrive lattice parameters for a temperature
function lpout=getLPTemp(fit1,T1,T_room)
    lpoutln=0;
    for ctr1=1:length(fit1)
        lpoutln=lpoutln+fit1(end-ctr1+1)*((T1-T_room).^(ctr1-1));
    end
    lpout=exp(lpoutln);
end

%% Retrive the thermal expansion
% retrives the thermal expansion value of a d spacing or a lattice
% parameter as a function of temperature
function alphaout=getCTETemp(fit1,T1,T_room)
    alphaout=0;
    for ctr1=1:length(fit1(1:end-1))
        alphaout=alphaout+((fit1(end-ctr1)*(ctr1))*((T1-T_room)^(ctr1-1)));
    end
    %disp(alphaout);
end


%% Retrive the thermal expansion with error
% retrives the thermal expansion value of a d spacing or a lattice
% parameter as a function of temperature
function [alphaout,alphaErr]=getCTETempWErr(fit1,T1,T_room)
    alphaout=0;
    for ctr1=1:length(fit1.p(1:end-1))
        alphaout=alphaout+((fit1.p(end-ctr1)*(ctr1))*((T1-T_room)^(ctr1-1)));
    end
    %disp(alphaout);
    [dVal,dErr]=polyval(fit1.p,T1-T_room,fit1.S);
    alphaErr=alphaout*dErr/dVal;  
end

%% Fit the thermal expansion tensor
function tenout=fitCTETensor(xyzin,dctein,system)
switch lower(system)
    case 'triclinic'
        x1=[xyzin(:,1)'.*xyzin(:,1)'; xyzin(:,2)'.*xyzin(:,2)'; xyzin(:,3)'.*xyzin(:,3)'; xyzin(:,1)'.*xyzin(:,2)'; xyzin(:,1)'.*xyzin(:,3)'; xyzin(:,2)'.*xyzin(:,3)']';
        tentemp=x1\dctein';
        tenout=[tentemp(1),tentemp(4)/2,tentemp(5)/2;tentemp(4)/2,tentemp(2),tentemp(6)/2;tentemp(5)/2,tentemp(6)/2,tentemp(3)];
    case 'monoclinic'
        x1=[xyzin(:,1)'.*xyzin(:,1)'; xyzin(:,2)'.*xyzin(:,2)'; xyzin(:,3)'.*xyzin(:,3)'; xyzin(:,1)'.*xyzin(:,3)']';
        tentemp=x1\dctein';
        tenout=[tentemp(1),0,tentemp(4)/2;0,tentemp(2),0;tentemp(4)/2,0,tentemp(3)];
    case 'tetragonal'
        x1=[xyzin(:,1)'.*xyzin(:,1)'+ xyzin(:,2)'.*xyzin(:,2)'; xyzin(:,3)'.*xyzin(:,3)']';
        tentemp=inv(x1'*x1)*x1'*dctein';
        tenout=[tentemp(1),0,0;0,tentemp(1),0;0,0,tentemp(2)];
    case 'hexagonal'
        x1=[xyzin(:,1)'.*xyzin(:,1)'+ xyzin(:,2)'.*xyzin(:,2)'; xyzin(:,3)'.*xyzin(:,3)']';
        tentemp=inv(x1'*x1)*x1'*dctein';
        tenout=[tentemp(1),0,0;0,tentemp(1),0;0,0,tentemp(2)];
    case 'orthorhombic'
        x1=[xyzin(:,1)'.*xyzin(:,1)'; xyzin(:,2)'.*xyzin(:,2)'; xyzin(:,3)'.*xyzin(:,3)']';
        tentemp=x1\dctein';
        tenout=[tentemp(1),0,0;0,tentemp(2),0;0,0,tentemp(3)];
    case 'cubic'
        x1=[xyzin(:,1)'.*xyzin(:,1)'+ xyzin(:,2)'.*xyzin(:,2)'+ xyzin(:,3)'.*xyzin(:,3)']';
        tentemp=inv(x1'*x1)*x1'*dctein';
        tenout=[tentemp(1),0,0;0,tentemp(1),0;0,0,tentemp(1)];
    case 'trigonal'
        x1=[xyzin(:,1)'.*xyzin(:,1)'+ xyzin(:,2)'.*xyzin(:,2)'; xyzin(:,3)'.*xyzin(:,3)']';
        tentemp=inv(x1'*x1)*x1'*dctein';
        tenout=[tentemp(1),0,0;0,tentemp(1),0;0,0,tentemp(2)];
    case 'rhombohedral'
        x1=[xyzin(:,1)'.*xyzin(:,1)'+ xyzin(:,2)'.*xyzin(:,2)'; xyzin(:,3)'.*xyzin(:,3)']';
        tentemp=inv(x1'*x1)*x1'*dctein';
        tenout=[tentemp(1),0,0;0,tentemp(1),0;0,0,tentemp(2)];        
end
        
end


%% Fit the thermal expansion tensor
function [tenout,tenoutErr]=fitCTETensorWeighted(xyzin,xyzinErr,dctein,dcteErr,system)
% form a weighting matrix equal to the inverse of the variance for each cte
% assuming the error given is the standard deviation of the cte
W1=diag(1./(dcteErr.*dcteErr));
switch lower(system)
    case 'triclinic'
        x1=[xyzin(:,1)'.*xyzin(:,1)'; xyzin(:,2)'.*xyzin(:,2)'; xyzin(:,3)'.*xyzin(:,3)'; xyzin(:,1)'.*xyzin(:,2)'; xyzin(:,1)'.*xyzin(:,3)'; xyzin(:,2)'.*xyzin(:,3)']';
        x1Err=abs(x1).*[(2.*xyzinErr(:,1)')./(xyzin(:,1)'); (2.*xyzinErr(:,2)')./(xyzin(:,2)'); (2.*xyzinErr(:,3)')./(xyzin(:,3)'); sqrt((xyzinErr(:,1)'./xyzin(:,1)').^2 + (xyzinErr(:,2)'./xyzin(:,2)').^2); sqrt((xyzinErr(:,1)'./xyzin(:,1)').^2 + (xyzinErr(:,3)'./xyzin(:,3)').^2); sqrt(xyzinErr(:,2)'.^2 + xyzinErr(:,3)'.^2)]';
        x1size=size(x1);
        for i=1:x1size(1)
            for j=1:x1size(2)
                if isnan(x1Err(i,j)) == 1
                    x1Err(i,j)=0;
                end
            end
        end
        tentemp=inv(x1'*W1*x1)*x1'*W1*dctein';
        tenout=[tentemp(1),tentemp(4)/2,tentemp(5)/2;tentemp(4)/2,tentemp(2),tentemp(6)/2;tentemp(5)/2,tentemp(6)/2,tentemp(3)];
        tenoutErr=cond(x1)*norm(x1Err)/norm(x1);
    case 'monoclinic'
        x1=[xyzin(:,1)'.*xyzin(:,1)'; xyzin(:,2)'.*xyzin(:,2)'; xyzin(:,3)'.*xyzin(:,3)'; xyzin(:,1)'.*xyzin(:,3)']';
        x1Err=abs(x1).*[(2.*xyzinErr(:,1)')./(xyzin(:,1)'); (2.*xyzinErr(:,2)')./(xyzin(:,2)'); (2.*xyzinErr(:,3)')./(xyzin(:,3)'); sqrt((xyzinErr(:,1)'./xyzin(:,1)').^2 + (xyzinErr(:,3)'./xyzin(:,3)').^2)]';
        x1size=size(x1Err);
        for i=1:x1size(1)
            for j=1:x1size(2)
                if isnan(x1Err(i,j)) == 1
                    x1Err(i,j)=0;
                end
            end
        end
        tentemp=inv(x1'*W1*x1)*x1'*W1*dctein';
        tenout=[tentemp(1),0,tentemp(4)/2;0,tentemp(2),0;tentemp(4)/2,0,tentemp(3)];
        tenoutErr=cond(x1)*norm(x1Err)/norm(x1);
    case 'orthorhombic'
        x1=[xyzin(:,1)'.*xyzin(:,1)'; xyzin(:,2)'.*xyzin(:,2)'; xyzin(:,3)'.*xyzin(:,3)']';
        x1Err=abs(x1).*[(2.*xyzinErr(:,1)')./xyzin(:,1)'; (2.*xyzinErr(:,2)')./xyzin(:,2)'; (2.*xyzinErr(:,3)')./xyzin(:,3)']';
        x1size=size(x1Err);
        for i=1:x1size(1)
            for j=1:x1size(2)
                if isnan(x1Err(i,j)) == 1
                    x1Err(i,j)=0;
                end
            end
        end
        tentemp=inv(x1'*W1*x1)*x1'*W1*dctein';
        tenout=[tentemp(1),0,0;0,tentemp(2),0;0,0,tentemp(3)];
        tenoutErr=cond(x1)*norm(x1Err)/norm(x1);
    case 'hexagonal'
        x1=[xyzin(:,1)'.*xyzin(:,1)'+ xyzin(:,2)'.*xyzin(:,2)'; xyzin(:,3)'.*xyzin(:,3)']';
        x1Err=[sqrt(((2*xyzinErr(:,1)')./xyzin(:,1)').^2 + ((2*xyzinErr(:,2)')./xyzin(:,2)').^2);abs(x1(2)).*(2*xyzinErr(:,3)')./xyzin(:,3)']';
        x1size=size(x1Err);
        for i=1:x1size(1)
            for j=1:x1size(2)
                if isnan(x1Err(i,j)) == 1
                    x1Err(i,j)=0;
                end
            end
        end
        tentemp=inv(x1'*W1*x1)*x1'*W1*dctein';
        tenout=[tentemp(1),0,0;0,tentemp(1),0;0,0,tentemp(2)];
        tenoutErr=cond(x1)*norm(x1Err)/norm(x1);
    case 'tetragonal'
        x1=[xyzin(:,1)'.*xyzin(:,1)'+ xyzin(:,2)'.*xyzin(:,2)'; xyzin(:,3)'.*xyzin(:,3)']';
        x1Err=[sqrt(((2*xyzinErr(:,1)')./xyzin(:,1)').^2 + ((2*xyzinErr(:,2)')./xyzin(:,2)').^2);abs(x1(2)).*(2*xyzinErr(:,3)')./xyzin(:,3)']';
        x1size=size(x1Err);
        for i=1:x1size(1)
            for j=1:x1size(2)
                if isnan(x1Err(i,j)) == 1
                    x1Err(i,j)=0;
                end
            end
        end
        tentemp=inv(x1'*W1*x1)*x1'*W1*dctein';
        tenout=[tentemp(1),0,0;0,tentemp(1),0;0,0,tentemp(2)];
        tenoutErr=cond(x1)*norm(x1Err)/norm(x1);
    case 'cubic'
        x1=[xyzin(:,1)'.*xyzin(:,1)'+ xyzin(:,2)'.*xyzin(:,2)'+ xyzin(:,3)'.*xyzin(:,3)']';
        x1Err=[sqrt(((2*xyzinErr(:,1)')./xyzin(:,1)').^2 + ((2*xyzinErr(:,2)')./xyzin(:,2)').^2 + ((2*xyzinErr(:,3)')./xyzin(:,3)').^2)]';
        x1size=size(x1Err);
        for i=1:x1size(1)
            for j=1:x1size(2)
                if isnan(x1Err(i,j)) == 1
                    x1Err(i,j)=0;
                end
            end
        end
        tentemp=inv(x1'*W1*x1)*x1'*W1*dctein';
        tenout=[tentemp(1),0,0;0,tentemp(1),0;0,0,tentemp(1)];
        tenoutErr=cond(x1)*norm(x1Err)/norm(x1);
    case 'trigonal'
        x1=[xyzin(:,1)'.*xyzin(:,1)'+ xyzin(:,2)'.*xyzin(:,2)'; xyzin(:,3)'.*xyzin(:,3)']';
        x1Err=[sqrt(((2*xyzinErr(:,1)')./xyzin(:,1)').^2 + ((2*xyzinErr(:,2)')./xyzin(:,2)').^2);abs(x1(2)).*(2*xyzinErr(:,3)')./xyzin(:,3)']';
        x1size=size(x1Err);
        for i=1:x1size(1)
            for j=1:x1size(2)
                if isnan(x1Err(i,j)) == 1
                    x1Err(i,j)=0;
                end
            end
        end
        tentemp=inv(x1'*W1*x1)*x1'*W1*dctein';
        tenout=[tentemp(1),0,0;0,tentemp(1),0;0,0,tentemp(2)];
        tenoutErr=cond(x1)*norm(x1Err)/norm(x1);
    case 'rhombohedral'
        x1=[xyzin(:,1)'.*xyzin(:,1)'; xyzin(:,2)'.*xyzin(:,2)'; xyzin(:,3)'.*xyzin(:,3)'; xyzin(:,1)'.*xyzin(:,2)'; xyzin(:,1)'.*xyzin(:,3)'; xyzin(:,2)'.*xyzin(:,3)']';
        x1Err=abs(x1).*[(2.*xyzinErr(:,1)')./(xyzin(:,1)'); (2.*xyzinErr(:,2)')./(xyzin(:,2)'); (2.*xyzinErr(:,3)')./(xyzin(:,3)'); sqrt((xyzinErr(:,1)'./xyzin(:,1)').^2 + (xyzinErr(:,2)'./xyzin(:,2)').^2); sqrt((xyzinErr(:,1)'./xyzin(:,1)').^2 + (xyzinErr(:,3)'./xyzin(:,3)').^2); sqrt(xyzinErr(:,2)'.^2 + xyzinErr(:,3)'.^2)]';
        x1size=size(x1Err);
        for i=1:x1size(1)
            for j=1:x1size(2)
                if isnan(x1Err(i,j)) == 1
                    x1Err(i,j)=0;
                end
            end
        end
        tentemp=inv(x1'*W1*x1)*x1'*W1*dctein';
        tenout=[tentemp(1),tentemp(4)/2,tentemp(5)/2;tentemp(4)/2,tentemp(2),tentemp(6)/2;tentemp(5)/2,tentemp(6)/2,tentemp(3)];
        tenoutErr=cond(x1)*norm(x1Err)/norm(x1);
end
end
