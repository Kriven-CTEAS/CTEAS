close all;
cd(Path_To_CTERun);
savedir=strcat(Input_File_Directory_Location,'\CTEAS_Output\','jade_data.mat');
load(savedir);
%Get Temps from old temperature file
fpath1=strcat(outputsavelocation,'Data_Temperatures.lvm');
tdfread(fpath1,'\t');
len=length(TempC);
switch Indx
    case 1
        tempC1=TempC(2:end);

        jtemp=jade_data(2:end);
        tempErr1=TempError(2:end);
        temp_data=Temps_from_Data(2:end);
        TempC=tempC1;
        TempError=tempErr1;
        Temps_from_Data=temp_data;
        jade_data=jtemp;
    case len
        tempC1=TempC(1:len-1);
        jtemp=jade_data(1:len-1);
        tempErr1=TempError(1:len-1);
        temp_data=Temps_from_Data(1:len-1);
        TempC=tempC1;
        TempError=tempErr1;
        Temps_from_Data=temp_data;
        jade_data=jtemp;
    otherwise
        tempC1=TempC(1:Indx-1);
        tempErr1=TempError(1:Indx-1);
        temp_data=Temps_from_Data(1:Indx-1);
        tempC2=TempC(Indx+1:end);
        tempErr2=TempError(Indx+1:end);
        jtemp1=jade_data(1:Indx-1);
        jtemp2=jade_data(Indx+1:end);
        temp_data2=Temps_from_Data(Indx+1:end);
        clear TempC;
        clear TempError;
        clear Temps_from_Data;
        clear jade_data;
        for nn=1:length(tempC1)
            TempC(nn)=tempC1(nn);
            TempError(nn)=tempErr1(nn);
            Temps_from_Data(nn)=temp_data(nn);
            jade_data(nn)=jtemp1(nn);
        end
        ctr=1;
        for nnn=nn+1:length(tempC2)+nn
            TempC(nnn)=tempC2(ctr);
            TempError(nnn)=tempErr2(ctr);
            Temps_from_Data(nnn)=temp_data2(ctr);
            jade_data(nnn)=jtemp2(ctr);
            ctr=ctr+1;
        end
end
for nn=1:length(Temps_from_Data)
    Temps_from_Data(nn).temp.tempC=TempC(nn);
    Temps_from_Data(nn).temp.tempErr=TempError(nn);
end

Temps_from_Data=sortbytemps(Temps_from_Data);
delete(fpath1);
fid1=fopen(fpath1,'wt');
    fprintf(fid1,'%s\t%s\t%s\n','Filename','TempC','TempError');
for n=1:length(Temps_from_Data)  
    fprintf(fid1,'%s\t%4.4f\t%4.4f\n',Temps_from_Data(n).filename,Temps_from_Data(n).temp.tempC,Temps_from_Data(n).temp.tempErr);
end
fclose(fid1);
save(savedir,'jade_data','Temps_from_Data');
