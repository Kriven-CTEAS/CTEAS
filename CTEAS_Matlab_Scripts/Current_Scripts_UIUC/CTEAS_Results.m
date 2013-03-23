clc;
close all;
savedir=strcat(Input_File_Directory_Location,'\CTEAS_Output\','xtal_data.mat');
load(savedir);
if exist(outputsavelocation)==7
    disp('CSV Save location already present, adding to directory.');
else
    mkdir(outputsavelocation);
end
%Make a movie
if Want_A_Movie==1
    %Concatenate a path to save the movie file.
    moviename=strcat(outputsavelocation,Movie_File_Name,'.avi');
    %Get frames from MakeMovieFrames function
    frame=MakeMovieFrames(Temps_to_be_Analyzed,fps,V,D,Xscreensize,Yscreensize);
    %Convert the frames to a movie
    movie2avi(frame,moviename,'fps',fps)
    %Close the figure when done.
    close all;
    %Obligatory confirmation of file path
    part1=sprintf('Movie created as %s.',moviename);
    disp(part1);
end
%Plot figure(s) at a specified temperature
if Want_Figures==1
    NumFigs=length(Figure_Temps);
    TensorFigs=zeros(3,3,NumFigs);
    ConMatFigs=zeros(3,3,NumFigs);
    xfig=zeros(101,101,NumFigs);
    yfig=zeros(101,101,NumFigs);
    zfig=zeros(101,101,NumFigs);
    cfig=zeros(101,101,NumFigs);
    for nn=1:NumFigs
        [TensorFigs(:,:,nn),ConMatFigs(:,:,nn)]=xtalCTE(lsfits,entriesT,params,Figure_Temps(nn),System_Analyzed,T_room);
    end
    [VFig,DFig]=eigenshuffle(TensorFigs);
    for eigzero1=1:length(Figure_Temps)
        for eigzero2=1:3
            if abs(DFig(eigzero2,eigzero1))<1*10^-12
                DFig(eigzero2,eigzero1)=0;
            end
            for eigzero3=1:3
                if abs(VFig(eigzero2,eigzero3,eigzero1))<1*10^-12
                    VFig(eigzero2,eigzero3,eigzero1)=0;
                end
            end            
        end
    end
    for nn=1:NumFigs
	[xfig(:,:,nn),yfig(:,:,nn),zfig(:,:,nn),cfig(:,:,nn)]=plotEllipsoid(VFig(:,:,nn),DFig(:,nn));
    end
    for n=1:NumFigs
    PlotTempFigure(Figure_Temps(n),VFig(:,:,n),DFig(:,n),Xscreensize,Yscreensize);
    end
    %Obligitory confirmation that figures were printed.
    part2=sprintf('Please orient and save the displayed figure(s) at the temperature(s) you specified.');
    disp(part2);
end
%Write a CSV file of all CTE data
if Want_A_Printout==1
    [EVang1,EVang2,EVang3]=EVAngles(V,D,ConMat,Temps_to_be_Analyzed,[aplaneorient;bplaneorient;cplaneorient],lsfits,HKL1);
    fidpath=strcat(outputsavelocation,Printout_Filename,'.csv');
    fid2=fopen(fidpath,'wt');
    fprintf(fid2,'Temp,CTE(11),CTE(12),CTE(13),CTE(21),CTE(22),CTE(23),CTE(31),CTE(32),CTE(33),Eig1,Eig2,Eig3,Beta-V,Alpha-V,Ev1(1),Ev1(2),Ev1(3),Ev2(1),Ev2(2),Ev2(3),Ev3(1),Ev3(2),Ev3(3),Eig1Angle,Eig2Angle,Eig3Angle\n');
    for n=1:NumCalcs
        fprintf(fid2,'%4.4f,',Temps_to_be_Analyzed(n));
        for nn=1:3
            for nnn=1:3
                fprintf(fid2,'%d,',Tensor(nn,nnn,n));
            end
            if(nn==3)
                BetaV=D(1,n)+D(2,n)+D(3,n);
                AlphaV=BetaV/3;
                fprintf(fid2,'%d,',D(1,n),D(2,n),D(3,n),BetaV,AlphaV,V(1,1,n),V(2,1,n),V(3,1,n),V(1,2,n),V(2,2,n),V(3,2,n),V(1,3,n),V(2,3,n),V(3,3,n),EVang1(n),EVang2(n),EVang3(n));
                fprintf(fid2,'\n');
            end
        end
    end
    %If a figure is being plotted in this run, add those data to the file.
    if Want_Figures==1
        fprintf(fid2,'\nData for Figures\n');
        for figctr=1:NumFigs;
            fprintf(fid2,'%4.4f,',Figure_Temps(figctr));
            for nn=1:3
                for nnn=1:3
                    fprintf(fid2,'%d,',TensorFigs(nn,nnn,figctr));
                end
                if(nn==3)
                    BetaVfig=DFig(1,figctr)+DFig(2,figctr)+DFig(3,figctr);
                    AlphaVfig=BetaVfig/3;
      		            fprintf(fid2,'%d,',DFig(1,figctr),DFig(2,figctr),DFig(3,figctr),BetaVfig,AlphaVfig,VFig(1,1,figctr),VFig(2,1,figctr),VFig(3,1,figctr),VFig(1,2,figctr),VFig(2,2,figctr),VFig(3,2,figctr),VFig(1,3,figctr),VFig(2,3,figctr),VFig(3,3,figctr));
                    fprintf(fid2,'\n');
                end
            end
        end
    end
    fclose(fid2);
    part3=sprintf('Data File created as %s',fidpath);
    disp(part3);
end
if Want_2D_Figures==1
    twodvals=EllipseWrap(Tensor,ConMat,Temps_to_be_Analyzed,aorient,borient,corient,lsfits,Xscreensize,Yscreensize,HKL2);
    part4=sprintf('2D Cross-Section Figures Plotted.');
    disp(part4);
    if Output_2D_Figure_Data==1
        WriteTwoDCSV(twodvals,Temps_to_be_Analyzed,strcat(outputsavelocation,Output_2D_Filename));
        part4a=sprintf('2D X & Y Values Output to %s.csv',strcat(outputsavelocation,Output_2D_Filename));
        disp(part4a);
    end
end
if Want_Eig_Plot==1
    PlotEigenvalues(Tensor,Temps_to_be_Analyzed,Xscreensize,Yscreensize);
    part5=sprintf('Eigenvalue Figure Plotted.  Please save it.');
    disp(part5);
end
if Want_HKLorUVW_Expansion_Plot==1
%need to resolve <1 HKL/UVW issues
    if HKL2==1
        inhkl='uvw';
        inhkl2=' uvw';
        INHKL='UVW';
    else
        inhkl='hkl';
        inhkl2=' hkl';
        INHKL='HKL';
    end
    t1=aorient;
    string1=num2str(t1);
    t2=borient;
    string2=num2str(t2);
    t3=corient;
    string3=num2str(t3);
    point='p';
    if mod(abs(t1),1)<1 && mod(abs(t1),1)>0
        stuff1=t1;
        if abs(stuff1)<1
            stuff1=0;
        end
        string1=sprintf('%1.0f%s%2.0f',stuff1,point,mod(abs(t1),1)*100);
    end
    if mod(abs(t2),1)<1 && mod(abs(t2),1)>0
        stuff2=t2;
        if abs(stuff2)<1
            stuff2=0;
        end
        string2=sprintf('%1.0f%s%2.0f',stuff2,point,mod(abs(t2),1)*100);
    end
    if mod(abs(t3),1)<1 && mod(abs(t3),1)>0
        stuff3=t3;
        if abs(stuff3)<1
            stuff3=0;
        end
        string3=sprintf('%1.0f%s%2.0f',stuff3,point,mod(abs(t3),1)*100);
    end
    HKLorUVW=[aorient;borient;corient];
    HKLvals=HKLExpansion(ConMat,Tensor,HKLorUVW,Temps_to_be_Analyzed,Xscreensize,Yscreensize,lsfits,HKL2);
    part6=sprintf(strcat(INHKL,' Expansion Figure Plotted.  Please Save it.'));
    disp(part6);
    if Save_HKL_Expansion_Printout==1
    fid3=fopen(strcat(outputsavelocation,HKL_Filename_Prefix,'-',inhkl,'_',string1,'_',string2,'_',string3,'_Expansion.csv'),'wt');
    fprintf(fid3,strcat('Thermal Expansion along: ',inhkl2,'=[',num2str(HKLorUVW(1)),';',num2str(HKLorUVW(2)),';',num2str(HKLorUVW(3)),'] direction.\n'));
    fprintf(fid3,strcat('T(',char(176),'C),alpha_hkl\n'));
    for counter=1:length(HKLvals)
        fprintf(fid3,'%4.4f,',Temps_to_be_Analyzed(counter));
        fprintf(fid3,'%d\n',HKLvals(counter));
    end
    fclose(fid3);
    part7=sprintf(strcat(INHKL,' Expansion printout written as:'));

    fpathhkl=strcat(outputsavelocation,HKL_Filename_Prefix,'-',inhkl,'_',string1,'_',string2,'_',string3,'_Expansion.csv');
    disp(part7);
    disp(fpathhkl);
    end
end
part8=sprintf('Thanks for using CTERun!');
disp(part8);
Done=0;
