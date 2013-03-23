function [lsfits,entries,params] = xtalCTEprep(datin,phasename,ordn,T_room)
%%xtalCTEprep extracts formatted data in "datin" for the "phasename" and 
%%organizes it for xtalCTE.m.  It also calculates polynomial fits to
%%lattice parameters and d-spacings of order "ordn".  "lsfits" is the
%%struct variable that contains the polynomial fits of order "ordn."
%%"entries" contains the bulk "phasename" data from read files.  "params"
%%contains the polyfit results and a structure for error calculation
%%from fitting d-spacings.

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

%% Organize lattice parameters and d-spacings into easy-to-use variables
cnt1=0;
entriesTmp=[];
for ctr1=1:length(datin)
    for ctr2=1:length(datin(ctr1).chem)
        if strcmp(datin(ctr1).chem(ctr2).name,phasename)
            cnt1=cnt1+1;
            latparams.a(cnt1)=datin(ctr1).chem(ctr2).a;
            latparams.aErr(cnt1)=datin(ctr1).chem(ctr2).aErr;
            latparams.b(cnt1)=datin(ctr1).chem(ctr2).b;
            latparams.bErr(cnt1)=datin(ctr1).chem(ctr2).bErr;
            latparams.c(cnt1)=datin(ctr1).chem(ctr2).c;
            latparams.cErr(cnt1)=datin(ctr1).chem(ctr2).cErr;
            latparams.alpha(cnt1)=datin(ctr1).chem(ctr2).alpha;
            latparams.alphaErr(cnt1)=datin(ctr1).chem(ctr2).alphaErr;
            latparams.beta(cnt1)=datin(ctr1).chem(ctr2).beta;
            latparams.betaErr(cnt1)=datin(ctr1).chem(ctr2).betaErr;
            latparams.gamma(cnt1)=datin(ctr1).chem(ctr2).gamma;
            latparams.gammaErr(cnt1)=datin(ctr1).chem(ctr2).gammaErr;
            latparams.T(cnt1)=datin(ctr1).temp.tempC;
            latparams.TErr(cnt1)=datin(ctr1).temp.tempErr;
            for ctr3=1:length(datin(ctr1).chem(ctr2).h)
                flg1=0;
                currhkl=[datin(ctr1).chem(ctr2).h(ctr3),datin(ctr1).chem(ctr2).k(ctr3),datin(ctr1).chem(ctr2).l(ctr3)];
                for ctr4=1:length(entriesTmp)
                    if entriesTmp(ctr4).hkl==currhkl
                        flg1=1;
                        entriesTmp(ctr4).T(end+1)=datin(ctr1).temp.tempC;
                        entriesTmp(ctr4).d(end+1)=datin(ctr1).chem(ctr2).d(ctr3);
                    end
                end
                if flg1==0
                    entriesTmp(end+1).hkl=currhkl;
                    entriesTmp(end).T(1)=datin(ctr1).temp.tempC;
                    entriesTmp(end).d(1)=datin(ctr1).chem(ctr2).d(ctr3);
                end
            end
        end
    end
end
%% get fits to each lattice parameter
[lsfits.a,lsfits.aS]=polyfit(latparams.T-T_room,log(latparams.a),ordn);
[lsfits.adeltas,lsfits.aErrorU,lsfits.aErrorL]=getmaxerrorinfit(lsfits.a,lsfits.aS,latparams.T-T_room,90,latparams.aErr,latparams.a,ordn);
[lsfits.b,lsfits.bS]=polyfit(latparams.T-T_room,log(latparams.b),ordn);
[lsfits.bdeltas,lsfits.bErrorU,lsfits.bErrorL]=getmaxerrorinfit(lsfits.b,lsfits.bS,latparams.T-T_room,90,latparams.bErr,latparams.b,ordn);
[lsfits.c,lsfits.cS]=polyfit(latparams.T-T_room,log(latparams.c),ordn);
[lsfits.cdeltas,lsfits.cErrorU,lsfits.cErrorL]=getmaxerrorinfit(lsfits.c,lsfits.cS,latparams.T-T_room,90,latparams.cErr,latparams.c,ordn);
[lsfits.alpha,lsfits.alphaS]=polyfit(latparams.T-T_room,log(latparams.alpha),ordn);
[lsfits.alphadeltas,lsfits.alphaErrorU,lsfits.alphaErrorL]=getmaxerrorinfit(lsfits.alpha,lsfits.alphaS,latparams.T-T_room,90,latparams.alphaErr,latparams.alpha,ordn);
[lsfits.beta,lsfits.betaS]=polyfit(latparams.T-T_room,log(latparams.beta),ordn);
[lsfits.betadeltas,lsfits.betaErrorU,lsfits.betaErrorL]=getmaxerrorinfit(lsfits.beta,lsfits.betaS,latparams.T-T_room,90,latparams.betaErr,latparams.beta,ordn);
[lsfits.gamma,lsfits.gammaS]=polyfit(latparams.T-T_room,log(latparams.gamma),ordn);
[lsfits.gammadeltas,lsfits.gammaErrorU,lsfits.gammaErrorL]=getmaxerrorinfit(lsfits.gamma,lsfits.gammaS,latparams.T-T_room,90,latparams.gammaErr,latparams.gamma,ordn);
cnt1=0;
%% get CTE fits to d-spacings
for ctr1=1:length(entriesTmp)
    if length(entriesTmp(ctr1).d)>ordn+2
        cnt1=cnt1+1;
        entries(cnt1)=entriesTmp(ctr1);
        [tmp1.p,tmp1.S]=polyfit(entriesTmp(ctr1).T-T_room,log(entriesTmp(ctr1).d),ordn);
        [tmp1.p_fit,tmp1.deltas]=polyval(tmp1.p,entriesTmp(ctr1).T-T_room,tmp1.S);
        [tmp1.pError,tmp1.SError]=polyfit(entriesTmp(ctr1).T-T_room,log(entriesTmp(ctr1).d)+2*tmp1.deltas,ordn);
        params(cnt1,:)=tmp1;
    end
%Get uncertainty in fit and use as error.
end
end
function [deltas,errorU,errorL]=getmaxerrorinfit(fitparams,fitparamsS,xvals,confinterval,latparamError,lattparams,ordn)
[p_fit,deltas]=polyval(fitparams,xvals,fitparamsS);
deltas=abs(calcconfbounds(deltas,xvals,fitparamsS,confinterval));
for counter1=1:length(p_fit)
    if 2*deltas(counter1) < latparamError(counter1)
        deltas(counter1) = 0.5*latparamError(counter1);
    end
end
[errorU]=polyfit(xvals,log(lattparams)+2*deltas,ordn);
[errorL]=polyfit(xvals,log(lattparams)-2*deltas,ordn);
end