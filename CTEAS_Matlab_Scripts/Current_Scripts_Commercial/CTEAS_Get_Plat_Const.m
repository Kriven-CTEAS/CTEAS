close all;
cd(Path_To_CTERun);
savedir=strcat(Input_File_Directory_Location,'\CTEAS_Output\','jade_data.mat');
load(savedir);
for n=1:length(jade_data(Indx).chem)
    if strcmp(jade_data(Indx).chem(n).name(1),'P')
        RTC=jade_data(Indx).chem(n).a;
        break;
    else
        RTC=1;
    end
end
Reference_T_Value=RTC;
Temps_from_Data=getPtTemp(jade_data,Reference_T_Value);
Temps_from_Data=sortbytemps(Temps_from_Data);
fpath1=strcat(outputsavelocation,'Data_Temperatures.lvm');
fid1=fopen(fpath1,'wt');
    fprintf(fid1,'%s\t%s\t%s\n','Filename','TempC','TempError');
for n=1:length(Temps_from_Data)  
    fprintf(fid1,'%s\t%4.4f\t%4.4f\n',Temps_from_Data(n).filename,Temps_from_Data(n).temp.tempC,Temps_from_Data(n).temp.tempErr);
end
fclose(fid1);
save(savedir,'jade_data','Temps_from_Data');
