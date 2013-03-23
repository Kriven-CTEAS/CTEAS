%% CTERun v1.4 - CTERun.m
%Created by Zachary A. Jones
%An example wrapper for other scripts to automate the CTEAS process using
%ONLY Matlab.  Should be run within CTERun_Inputs.m or a similar file
%containing all necessary inputs.

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

%% Begin Program Execution.  Create Output folder and get screen size:
if strcmpi(Input_File_Directory_Location(1),'/')
    outputsavelocation=strcat(Input_File_Directory_Location,'CTEAS_Output/');
else
    outputsavelocation=strcat(Input_File_Directory_Location,'CTEAS_Output\');
end
if exist(outputsavelocation)==7
    disp('CSV Save location already present, adding to directory.');
else
    mkdir(outputsavelocation);
end
ssize=get(0,'ScreenSize');
%% Create Full Temperature List (including last temperature):
Temps_to_be_Analyzed=LowT:Tstep:HighT;
if(Tstep*(length(Temps_to_be_Analyzed)-1)+LowT<HighT)
    Temps_to_be_Analyzed(length(Temps_to_be_Analyzed)+1)=HighT;
end

%% Read in Jade files from the Input_File_Directory_Location
if Want_Jade_Files==1
    jade_data=getrrpdata(Input_File_Directory_Location);
    %Obtain temperatures from the jade_data using Platinum if it's in the
    %system
    Temp_from_Data=getPtTemp(jade_data,Reference_T_Value);
    %Write Temperature data to a tab-separated value file and allow user to
    %modify.
else
    jade_data=getcsvdata(Input_File_Directory_Location);
    Temp_from_Data=jade_data;    
end
Temps_from_Data=sortbytemps(Temp_from_Data);

%% Write Temperature Data to a temporary file for modification by user:
fid1=fopen(strcat(outputsavelocation,'Data_temperatures.txt'),'wt');
fprintf(fid1,'%s\t%s\t%s\n','Filename','temper','temperror');
for n=1:length(Temps_from_Data)  
    fprintf(fid1,'%s\t%4.4f\t%4.4f\n',Temps_from_Data(n).filename,Temps_from_Data(n).temp.tempC,Temps_from_Data(n).temp.tempErr);
end
fclose(fid1);
%Wait for user input to ensure that all temp values have been accounted for either
%automatically by the previous command or by manually editing the file.
disp('Please edit the temperature data in a text editor if necessary.');
open(strcat(outputsavelocation,'Data_temperatures.txt'));
temporary=input('Do you wish to continue the program [Y/n]?', 's');
if strcmp(temporary,'n')
    error('User aborted the run');
end
disp('Continuing the run with (assumed) complete temperature data...');
%% Read Temperature Data back in from temporary (possibly modified) file:
%tdfread is included in the CTERun folder, however it is also found in the
%Statistics Toolbox.
tdfread(strcat(outputsavelocation,'Data_temperatures.txt'),'\t');
for n=1:length(Temps_from_Data)
    Temps_from_Data(n).temp.tempC=temper(n,1);
    Temps_from_Data(n).temp.tempErr=temperror(n,1);
end
Temps_from_Data_Orig=sortbytemps(Temps_from_Data);
delete(strcat(outputsavelocation,'Data_temperatures.txt'));
%% Sort data and calculate hkl values
Temps_from_Data=symmetrysort(Temps_from_Data_Orig);
[lsfits,entries,params]=xtalCTEprep(Temps_from_Data,Phase_to_be_Analyzed,Polyfit_order,T_room);
%Calculate thermal expansion tensors at a range of temperatures specified earlier
%and plot them; create the movie.
NumCalcs=length(Temps_to_be_Analyzed);
NumFigs=length(Figure_Temps);
xmax=0;
ymax=0;
zmax=0;
cmax=0;
%Pre-allocate variable lengths
Tensor=zeros(3,3,NumCalcs);
TensorFigs=zeros(3,3,NumFigs);
ConMat=zeros(3,3,NumCalcs);
ConMatFigs=zeros(3,3,NumFigs);
x=zeros(101,101,NumCalcs);
xfig=zeros(101,101,NumFigs);
y=zeros(101,101,NumCalcs);
yfig=zeros(101,101,NumFigs);
z=zeros(101,101,NumCalcs);
zfig=zeros(101,101,NumFigs);
c=zeros(101,101,NumCalcs);
cfig=zeros(101,101,NumFigs);
TempTol=50;
entsToUse=[];
for ctr1=1:length(entries)
    Tmin=min(entries(ctr1).T);
    Tmax=max(entries(ctr1).T);
    if (Tmin-TempTol<min(Temps_to_be_Analyzed))&&(Tmax+TempTol>max(Temps_to_be_Analyzed));
        entsToUse=[entsToUse, ctr1];
    else
        txt1=sprintf('skipped hkl [ %d%d%d ], temprange [%f:%f]',entries(ctr1).hkl(1),entries(ctr1).hkl(2),entries(ctr1).hkl(3),Tmin,Tmax);
        disp(txt1);
    end
end
entriesT=entries(entsToUse);
%Check to ensure Temp ranges vs. data are in agreement.
if length(entriesT) < 1
    error('Analysis cannot be completed...Minimum or Maximum Temperature outside allowable range.  Aborting...');
end
%% Calculate Strain Tensors

%% Calculate CTE Tensors    
for n=1:NumCalcs
    [Tensor(:,:,n),TensorErr(:,:,n),ConMat(:,:,n)]=xtalCTE(lsfits,entriesT,params,Temps_to_be_Analyzed(n),Symmetry_Analyzed,T_room);
end
for nn=1:NumFigs
[TensorFigs(:,:,nn),TensorFigsErr(:,:,nn),ConMatFigs(:,:,nn)]=xtalCTE(lsfits,entriesT,params,Figure_Temps(nn),Symmetry_Analyzed,T_room);
end
%% Unsorted Eigenvalues and Eigenvectors
[V,D]=eigenshuffle(Tensor);
for eigzero1=1:size(D,2)
    for eigzero2=1:3
            if abs(D(eigzero2,eigzero1))<1*10^-12
                D(eigzero2,eigzero1)=0;
            end
            for eigzero3=1:3
                if abs(V(eigzero2,eigzero3,eigzero1))<1*10^-12
                    V(eigzero2,eigzero3,eigzero1)=0;
                end
            end
    end
end

%% Calculate xyzc values for Ellipsoid plots:
%note, the loop below was split from the xtalCTE loop because of the
%eigenvalue sorting.  This keeps all eigenvalues and eigenvectors the same
%through the calculations.
for n=1:NumCalcs
    [x(:,:,n),y(:,:,n),z(:,:,n),c(:,:,n)]=plotEllipsoid(V(:,:,n),D(:,n));
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

%% Make a movie
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

%% Plot figure(s) at a specified temperature
if Want_Figures==1
    for n=1:NumFigs
    PlotTempFigure(Figure_Temps(n),VFig(:,:,n),DFig(:,n),Xscreensize,Yscreensize);
    end
    %Obligitory confirmation that figures were printed.
    part2=sprintf('Please orient and save the displayed figure(s) at the temperature(s) you specified.');
    disp(part2);
end

%% Write a CSV file of all CTE data
if Want_A_Printout==1
    [EVang1,EVang2,EVang3]=EVAngles(V,D,ConMat,Temps_to_be_Analyzed,[huorient;kvorient;lworient],lsfits,inUVW);
    fidpath=strcat(outputsavelocation,Printout_Filename,'.csv');
    fid2=fopen(fidpath,'wt');
    fprintf(fid2,'Temp,CTE(11),CTE(12),CTE(13),CTE(21),CTE(22),CTE(23),CTE(31),CTE(32),CTE(33),CTEErr,Eig1,Eig2,Eig3,Beta-V,Alpha-V,Ev1(1),Ev1(2),Ev1(3),Ev2(1),Ev2(2),Ev2(3),Ev3(1),Ev3(2),Ev3(3),Eig1Angle,Eig2Angle,Eig3Angle\n');
    for n=1:NumCalcs
        fprintf(fid2,'%4.4f,',Temps_to_be_Analyzed(n));
        for nn=1:3
            for nnn=1:3
                fprintf(fid2,'%d,',Tensor(nn,nnn,n));
            end
            if(nn==3)
                BetaV=D(1,n)+D(2,n)+D(3,n);
                AlphaV=BetaV/3;
                fprintf(fid2,'%d,',TensorErr(n)*100,D(1,n),D(2,n),D(3,n),BetaV,AlphaV,V(1,1,n),V(2,1,n),V(3,1,n),V(1,2,n),V(2,2,n),V(3,2,n),V(1,3,n),V(2,3,n),V(3,3,n),EVang1(n),EVang2(n),EVang3(n));
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
%                    fprintf(fid2,'%d,%d,%d,',DFig(1,figctr),DFig(2,figctr),DFig(3,figctr));
		    fprintf(fid2,'%d,',TensorFigsErr(figctr)*100,DFig(1,figctr),DFig(2,figctr),DFig(3,figctr),BetaVfig,AlphaVfig,VFig(1,1,figctr),VFig(2,1,figctr),VFig(3,1,figctr),VFig(1,2,figctr),VFig(2,2,figctr),VFig(3,2,figctr),VFig(1,3,figctr),VFig(2,3,figctr),VFig(3,3,figctr));
                    fprintf(fid2,'\n');
                end
            end
        end
    end
    fclose(fid2);
    part3=sprintf('Data File created as %s',fidpath);
    disp(part3);
end

%% Plot 2D Figures:
if Want_2D_Figures==1
    twodvals=EllipseWrap(Tensor,ConMat,Temps_to_be_Analyzed,huorient2,kvorient2,lworient2,lsfits,Xscreensize,Yscreensize,inUVW2);
    part4=sprintf('2D Cross-Section Figures Plotted.');
    disp(part4);
    if Output_2D_Figure_Data==1
        WriteTwoDCSV(twodvals,Temps_to_be_Analyzed,strcat(outputsavelocation,Output_2D_Filename));
        part4a=sprintf('2D X & Y Values Output to %s.csv',strcat(outputsavelocation,Output_2D_Filename));
        disp(part4a);
    end
end

%% Plot Eigenvalues vs. Temperature:
if Want_Eig_Plot==1
    PlotEigenvalues(Tensor,Temps_to_be_Analyzed,Xscreensize,Yscreensize);
    part5=sprintf('Eigenvalue Figure Plotted.  Please save it.');
    disp(part5);
end

%% Plot hkl or uvw expansion vs. Temperature:
if Want_HKLorUVW_Expansion_Plot==1
%need to resolve <1 HKL/UVW issues
    if inUVW3==1
        inhkl='uvw';
        inhkl2=' uvw';
        INHKL='UVW';
    else
        inhkl='hkl';
        inhkl2=' hkl';
        INHKL='HKL';
    end
    t1=HKLorUVW(1);
    string1=num2str(t1);
    t2=HKLorUVW(2);
    string2=num2str(t2);
    t3=HKLorUVW(3);
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
    HKLvals=HKLExpansion(ConMat,Tensor,HKLorUVW,Temps_to_be_Analyzed,Xscreensize,Yscreensize,lsfits,inUVW3);
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

%% Thanks for Running CTERun!
part8=sprintf('Thanks for using CTERun!');
disp(part8);
