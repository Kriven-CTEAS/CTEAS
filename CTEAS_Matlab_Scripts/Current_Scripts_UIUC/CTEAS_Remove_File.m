close all;
cd(Path_To_CTERun);
savedir=strcat(Input_File_Directory_Location,'\CTEAS_Output\','jade_data.mat');
load(savedir);
tdfread(fpath1,'\t');
len=length(TempC);
for n=1:len
    Temps_from_Data(n).temp.tempC=TempC(n);
    Temps_from_Data(n).temp.tempErr=TempError(nn);
end
Temps_from_Data=sortbytemps(Temps_from_Data);
save(savedir,'jade_data','Temps_from_Data');
