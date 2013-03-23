function [fitlines,residuals]=calclsfit(Phase_to_be_Analyzed,TempRange,Temps_from_Data,Polyfit_Order)

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

clc
close all;
%Room Temperature:
T0=25;
cnt1=0;
%Grab lattice parameters and temps from input files
for n=1:length(Temps_from_Data)
    for nn=1:length(Temps_from_Data(n).chem)
        if(strcmp(Phase_to_be_Analyzed,Temps_from_Data(n).chem(nn).name))
            cnt1=cnt1+1;
            temp1.a(cnt1)=Temps_from_Data(n).chem(nn).a;
            temp1.aErr(cnt1)=Temps_from_Data(n).chem(nn).aErr;
            temp1.b(cnt1)=Temps_from_Data(n).chem(nn).b;
            temp1.bErr(cnt1)=Temps_from_Data(n).chem(nn).bErr;
            temp1.c(cnt1)=Temps_from_Data(n).chem(nn).c;
            temp1.cErr(cnt1)=Temps_from_Data(n).chem(nn).cErr;
            temp1.alpha(cnt1)=Temps_from_Data(n).chem(nn).alpha;
            temp1.alphaErr(cnt1)=Temps_from_Data(n).chem(nn).alphaErr;
            temp1.beta(cnt1)=Temps_from_Data(n).chem(nn).beta;
            temp1.betaErr(cnt1)=Temps_from_Data(n).chem(nn).betaErr;
            temp1.gamma(cnt1)=Temps_from_Data(n).chem(nn).gamma;
            temp1.gammaErr(cnt1)=Temps_from_Data(n).chem(nn).gammaErr;
            temp1.Temps(cnt1)=Temps_from_Data(n).temp.tempC;
        end
    end
end

    %Store Real Data
    realparams.a=temp1.a;
    realparams.aErr=temp1.aErr;
    realparams.b=temp1.b;
    realparams.bErr=temp1.bErr;
    realparams.c=temp1.c;
    realparams.cErr=temp1.cErr;
    realparams.alpha=temp1.alpha;
    realparams.alphaErr=temp1.alphaErr;
    realparams.beta=temp1.beta;
    realparams.betaErr=temp1.betaErr;
    realparams.gamma=temp1.gamma;
    realparams.gammaErr=temp1.gammaErr;
    realparams.T=temp1.Temps;
    
    %Create Polynomial Fit Data
    %Use the next lines to for fit as thermal expanstion (ie. ln(a)vs T-25)
    fitsa=polyfit(realparams.T-T0,log(realparams.a),Polyfit_Order);
    fitsb=polyfit(realparams.T-T0,log(realparams.b),Polyfit_Order);
    fitsc=polyfit(realparams.T-T0,log(realparams.c),Polyfit_Order);
    fitsalpha=polyfit(realparams.T-T0,log(realparams.alpha),Polyfit_Order);
    fitsbeta=polyfit(realparams.T-T0,log(realparams.beta),Polyfit_Order);
    fitsgamma=polyfit(realparams.T-T0,log(realparams.gamma),Polyfit_Order);
    
    %Zero out the following arrays:
    fitlinesa=zeros(length(TempRange),1);
    fitlinesb=zeros(length(TempRange),1);
    fitlinesc=zeros(length(TempRange),1);
    fitlinesalpha=zeros(length(TempRange),1);
    fitlinesbeta=zeros(length(TempRange),1);
    fitlinesgamma=zeros(length(TempRange),1);
    fitlinesad=zeros(length(realparams.T),1);
    fitlinesbd=zeros(length(realparams.T),1);
    fitlinescd=zeros(length(realparams.T),1);
    fitlinesalphad=zeros(length(realparams.T),1);
    fitlinesbetad=zeros(length(realparams.T),1);
    fitlinesgammad=zeros(length(realparams.T),1);
    T0=25;
    
    for n=1:length(TempRange)
        T1=TempRange(n);
        %Obtain a fitted lattice parameter at a given temperature
        fitlinesa(n)=fitlinesa(n)+polyval(fitsa,T1-T0);
        fitlinesb(n)=fitlinesb(n)+polyval(fitsb,T1-T0);
        fitlinesc(n)=fitlinesc(n)+polyval(fitsc,T1-T0);
        fitlinesalpha(n)=fitlinesalpha(n)+polyval(fitsalpha,T1-T0);
        fitlinesbeta(n)=fitlinesbeta(n)+polyval(fitsbeta,T1-T0);
        fitlinesgamma(n)=fitlinesgamma(n)+polyval(fitsgamma,T1-T0);

    end
    %Clean up by making sure we have exp(fit) instead of an ln fit.
    fitlines.a=exp(fitlinesa);
    fitlines.b=exp(fitlinesb);
    fitlines.c=exp(fitlinesc);
    fitlines.alpha=exp(fitlinesalpha);
    fitlines.beta=exp(fitlinesbeta);
    fitlines.gamma=exp(fitlinesgamma);
    
    %Now calculate coefficient of determination:
    for n=1:length(realparams.T)
        T1=realparams.T(n);
        fitlinesad(n)=exp(polyval(fitsa,T1-T0));
        aresid(n)=realparams.a(n)-fitlinesad(n);
        fitlinesbd(n)=exp(polyval(fitsb,T1-T0));
        bresid(n)=realparams.b(n)-fitlinesbd(n);
        fitlinescd(n)=exp(polyval(fitsc,T1-T0));
        cresid(n)=realparams.c(n)-fitlinescd(n);
        fitlinesalphad(n)=exp(polyval(fitsalpha,T1-T0));
        alpharesid(n)=realparams.alpha(n)-fitlinesalphad(n);
        fitlinesbetad(n)=exp(polyval(fitsbeta,T1-T0));
        betaresid(n)=realparams.beta(n)-fitlinesbetad(n);
        fitlinesgammad(n)=exp(polyval(fitsgamma,T1-T0));
        gammaresid(n)=realparams.gamma(n)-fitlinesgammad(n);
    end
    SSaresid=sum(aresid.^2);
    SSbresid=sum(bresid.^2);
    SScresid=sum(cresid.^2);
    SSalpharesid=sum(alpharesid.^2);
    SSbetaresid=sum(betaresid.^2);
    SSgammaresid=sum(gammaresid.^2);    
    SSatotal=(length(realparams.a)-1)*var(realparams.a);
    SSbtotal=(length(realparams.b)-1)*var(realparams.b);
    SSctotal=(length(realparams.c)-1)*var(realparams.c);
    SSalphatotal=(length(realparams.alpha)-1)*var(realparams.alpha);
    SSbetatotal=(length(realparams.beta)-1)*var(realparams.beta);
    SSgammatotal=(length(realparams.gamma)-1)*var(realparams.gamma);
    rsqa=1-(SSaresid/SSatotal);
    rsqb=1-(SSbresid/SSbtotal);
    rsqc=1-(SScresid/SSctotal);
    rsqalpha=1-(SSalpharesid/SSalphatotal);
    rsqbeta=1-(SSbetaresid/SSbetatotal);
    rsqgamma=1-(SSgammaresid/SSgammatotal);
    residuals.Ra=rsqa;
    residuals.Rb=rsqb;
    residuals.Rc=rsqc;
    residuals.Ralpha=rsqalpha;
    residuals.Rbeta=rsqbeta;
    residuals.Rgamma=rsqgamma;
    %Plotting
    a=figure();
    hold on
    errorbar(realparams.T,realparams.a,realparams.aErr,'bo');
    plot(TempRange,fitlines.a,'b:');
    errorbar(realparams.T,realparams.b,realparams.bErr,'ro');
    plot(TempRange,fitlines.b,'r:');
    errorbar(realparams.T,realparams.c,realparams.cErr,'ko');
    plot(TempRange,fitlines.c,'k:');
    title('Lattice Parameters and Fits vs. Temperature');
    xlabel('Temperature (C)');
    ylabel('Value');
    hold off
    b=figure();
    hold on
    plot(log(realparams.T),log(realparams.a),'bo');
    plot(log(TempRange),log(fitlines.a),'b:');
    plot(log(realparams.T),log(realparams.b),'ro');
    plot(log(TempRange),log(fitlines.b),'r:');
    plot(log(realparams.T),log(realparams.c),'ko');
    plot(log(TempRange),log(fitlines.c),'k:');
    title('Log Lattice Parameters and Fits vs. Log Temperature');
    xlabel('Temperature (C)');
    ylabel('Value');
    hold off
    %figure();errorbar
    %hold on
    %plot(log(TempRange),log(fitlines.alpha),'r',log(realparams.T),log(realparams.alpha),'bo')
    %plot(log(TempRange),log(fitlines.beta),'r',log(realparams.T),log(realparams.beta),'bo')
    %plot(log(TempRange),log(fitlines.gamma),'r',log(realparams.T),log(realparams.gamma),'bo')
end
