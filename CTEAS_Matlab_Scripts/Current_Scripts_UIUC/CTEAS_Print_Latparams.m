close all;
cd(Path_To_CTERun);
savedir=strcat(Input_File_Directory_Location,'\CTEAS_Output\','jade_data.mat');
load(savedir);
if exist(outputsavelocation)==7
    disp('CSV Save location already present, adding to directory.');
else
    mkdir(outputsavelocation);
end
savedir2=strcat(outputsavelocation,SaveFilename,'.csv');
clear temp1;
Temps_to_be_Analyzed=LowT:Tstep:HighT;
if(Tstep*(length(Temps_to_be_Analyzed)-1)+LowT<HighT)
    Temps_to_be_Analyzed(length(Temps_to_be_Analyzed)+1)=HighT;
end
T0=25;
cnt1=0;
for n=1:length(Temps_from_Data)
    for nn=1:length(Temps_from_Data(n).chem)
        if(strcmp(Phase_to_be_Analyzed,Temps_from_Data(n).chem(nn).name))
            cnt1=cnt1+1
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
a=temp1.a;
aError=temp1.aErr;
b=temp1.b;
bError=temp1.bErr;
c=temp1.c;
cError=temp1.cErr;
alpha=temp1.alpha;
alphaError=temp1.alphaErr;
beta=temp1.beta;
betaError=temp1.betaErr;
gamma=temp1.gamma;
gammaError=temp1.gammaErr;
Temps=temp1.Temps;

%Create Polynomial Fit Data
fitsa=polyfit(Temps-T0,log(a),Polyfit_Order);
fitsb=polyfit(Temps-T0,log(b),Polyfit_Order);
fitsc=polyfit(Temps-T0,log(c),Polyfit_Order);
fitsalpha=polyfit(Temps-T0,log(alpha),Polyfit_Order);
fitsbeta=polyfit(Temps-T0,log(beta),Polyfit_Order);
fitsgamma=polyfit(Temps-T0,log(gamma),Polyfit_Order);
%Zero out some arrays:
fitlinesa=zeros(length(Temps_to_be_Analyzed),1);
fitlinesb=zeros(length(Temps_to_be_Analyzed),1);
fitlinesc=zeros(length(Temps_to_be_Analyzed),1);
fitlinesalpha=zeros(length(Temps_to_be_Analyzed),1);
fitlinesbeta=zeros(length(Temps_to_be_Analyzed),1);
fitlinesgamma=zeros(length(Temps_to_be_Analyzed),1);
fitlinesad=zeros(length(Temps),1);
fitlinesbd=zeros(length(Temps),1);
fitlinescd=zeros(length(Temps),1);
fitlinesalphad=zeros(length(Temps),1);
fitlinesbetad=zeros(length(Temps),1);
fitlinesgammad=zeros(length(Temps),1);

%Create Fitted Lattice Parameter Values
for n=1:length(Temps_to_be_Analyzed)
    T1=Temps_to_be_Analyzed(n);
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

%Calculate Coefficient of Determination:
%Now calculate coefficient of determination:
for n=1:length(Temps)
    T1=Temps(n);
    fitlinesad(n)=exp(polyval(fitsa,T1-T0));
    aresid(n)=a(n)-fitlinesad(n);
    fitlinesbd(n)=exp(polyval(fitsb,T1-T0));
    bresid(n)=b(n)-fitlinesbd(n);
    fitlinescd(n)=exp(polyval(fitsc,T1-T0));
    cresid(n)=c(n)-fitlinescd(n);
    fitlinesalphad(n)=exp(polyval(fitsalpha,T1-T0));
    alpharesid(n)=alpha(n)-fitlinesalphad(n);
    fitlinesbetad(n)=exp(polyval(fitsbeta,T1-T0));
    betaresid(n)=beta(n)-fitlinesbetad(n);
    fitlinesgammad(n)=exp(polyval(fitsgamma,T1-T0));
    gammaresid(n)=gamma(n)-fitlinesgammad(n);
end
SSaresid=sum(aresid.^2);
SSbresid=sum(bresid.^2);
SScresid=sum(cresid.^2);
SSalpharesid=sum(alpharesid.^2);
SSbetaresid=sum(betaresid.^2);
SSgammaresid=sum(gammaresid.^2);    
SSatotal=(length(a)-1)*var(a);
SSbtotal=(length(b)-1)*var(b);
SSctotal=(length(c)-1)*var(c);
SSalphatotal=(length(alpha)-1)*var(alpha);
SSbetatotal=(length(beta)-1)*var(beta);
SSgammatotal=(length(gamma)-1)*var(gamma);
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
    
if VLP==1
    ssize=get(0,'ScreenSize');
    latlegend={};
    ctr1=1;
    ctr2=1;
    anglegend={};
    if ayes==1 || byes==1 || cyes==1
        k=figure('Position',[((ssize(3)/2)-(ssize(3)*3/8)) ((ssize(4)/2)-(ssize(4)*3/8)) ssize(3)*.75 ssize(4)*.75]);
        if ayes==1
            errorbar(Temps,a,aError,'bo');
            latlegend(ctr1)={'a'};
            ctr1=ctr1+1;
			hold on;
			plot(Temps_to_be_Analyzed,fitlines.a,'b:');
			legnamea=strcat('Fit a, R^2=',num2str(residuals.Ra));
			latlegend(ctr1)={legnamea};
			ctr1=ctr1+1;
            hold on;
        end
        if byes==1
            errorbar(Temps,b,bError,'ro');
            latlegend(ctr1)={'b'};
            ctr1=ctr1+1;
			hold on;
			plot(Temps_to_be_Analyzed,fitlines.b,'r:');
			legnameb=strcat('Fit b, R^2=',num2str(residuals.Rb));
			latlegend(ctr1)={legnameb};
			ctr1=ctr1+1;
            hold on;
        end
        if cyes==1
            errorbar(Temps,c,cError,'ko');
            latlegend(ctr1)={'c'};
			ctr1=ctr1+1;
			hold on;
			plot(Temps_to_be_Analyzed,fitlines.c,'k:');
			legnamec=strcat('Fit c, R^2=',num2str(residuals.Rc));
			latlegend(ctr1)={legnamec};
            hold on;
        end
        xscreen=ssize(3)*0.75;
        yscreen=ssize(4)*0.75;
        fontsize=round(xscreen/85);
        if(fontsize<12)
            fontsize=12;
        end
        titlesize=round(xscreen/50);
        if(titlesize<20)
            titlesize=20;
        end
        title('Lattice Parameters vs. Temperature','FontSize',titlesize,'FontWeight','bold');
        xlabel(strcat('Temperature (',char(176),'C)'),'FontSize',fontsize);
        ylabel(strcat('Lattice Parameters (',char(197),')'),'Fontsize',fontsize);
        legend(latlegend);
        set(gca,'FontSize',fontsize);
        hold off;
    end
    if alphayes==1 || betayes==1 || gammayes==1
        l=figure('Position',[((ssize(3)/2)-(ssize(3)*3/8)) ((ssize(4)/2)-(ssize(4)*3/8)) ssize(3)*.75 ssize(4)*.75]);
        if alphayes==1
            errorbar(Temps,alpha,alphaError,'bo');
            anglegend(ctr2)={'alpha'};
            ctr2=ctr2+1;
            hold on;
			plot(Temps_to_be_Analyzed,fitlines.alpha,'b:');
			legnamealpha=strcat('Fit alpha, R^2=',num2str(residuals.Ralpha));
			anglegend(ctr2)={legnamealpha};
			ctr2=ctr2+1;
            hold on;
        end
        if betayes==1
            errorbar(Temps,beta,betaError,'ro');
            anglegend(ctr2)={'beta'};
            ctr2=ctr2+1;
            hold on;
			plot(Temps_to_be_Analyzed,fitlines.beta,'r:');
			legnamebeta=strcat('Fit beta, R^2=',num2str(residuals.Rbeta));
			anglegend(ctr2)={legnamebeta};
			ctr2=ctr2+1;
            hold on;
        end
        if gammayes==1
            errorbar(Temps,gamma,gammaError,'ko');
            anglegend(ctr2)={'gamma'};
            hold on;
			ctr2=ctr2+1;
			plot(Temps_to_be_Analyzed,fitlines.gamma,'k:');
			legnamegamma=strcat('Fit gamma, R^2=',num2str(residuals.Rgamma));
			anglegend(ctr2)={legnamegamma};
            hold on;
        end
        title('Lattice Parameter Angles vs. Temperature','FontSize',titlesize,'FontWeight','bold')
        xlabel(strcat('Temperature (',char(176),'C)'),'FontSize',fontsize);
        ylabel('Lattice Parameter Angles (deg.)','FontSize',fontsize);
        legend(anglegend);
        set(gca,'FontSize',fontsize);
        hold off;
    end
end
if SLP==1
    fid1=fopen(savedir2,'wt');
    fprintf(fid1,'Temp (C),a,aError,b,bError,c,cError,alpha,alphaError,beta,betaError,gamma,gammaError\n');
    for n=1:length(Temps)
        fprintf(fid1,'%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f\n',Temps(n),a(n),aError(n),b(n),bError(n),c(n),cError(n),alpha(n),alphaError(n),beta(n),betaError(n),gamma(n),gammaError(n));
    end
    fclose(fid1);
    saved=1;
end
