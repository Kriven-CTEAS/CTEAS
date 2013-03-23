close all;
cd(Path_To_CTERun);
DL=0;
outputsavelocation=strcat(Input_File_Directory_Location,'\CTEAS_Output\');
if exist(outputsavelocation)==7
    disp('CSV Save location already present, adding to directory.');
else
    mkdir(outputsavelocation);
end
ssize=get(0,'ScreenSize');
fpath1=strcat(outputsavelocation,'Data_Temperatures.lvm');
fpath2=strcat(outputsavelocation,'PhaseNames.lvm');
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
fid1=fopen(fpath1,'wt');
fprintf(fid1,'%s\t%s\t%s\n','Filename','TempC','TempError');
for n=1:length(Temps_from_Data)  
    fprintf(fid1,'%s\t%4.4f\t%4.4f\n',Temps_from_Data(n).filename,Temps_from_Data(n).temp.tempC,Temps_from_Data(n).temp.tempErr);
end
fclose(fid1);
savedir=strcat(outputsavelocation,'jade_data.mat');
save(savedir,'jade_data','Temps_from_Data','ssize','outputsavelocation');
DL=1;
phaseNames={};
fid2=fopen(fpath2,'wt');
for n=1:length(jade_data)
    for nn=1:length(jade_data(n).chem)
        textstring=strcat(jade_data(n).chem(nn).name,'-!- ',jade_data(n).chem(nn).structure);
        nameIndx=strmatch(textstring,phaseNames,'exact');
        if isempty(nameIndx)
            phaseNames=strvcat(phaseNames,textstring);
            fprintf(fid2,'%s\t',textstring);
        end
    end
end
fclose(fid2);
