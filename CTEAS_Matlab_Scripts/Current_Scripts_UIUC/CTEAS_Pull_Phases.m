close all;
cd(Path_To_CTERun);
savedir=strcat(Input_File_Directory_Location,'\CTEAS_Output\','jade_data.mat');
load(savedir);
phaseNames={};
fpath2=strcat(outputsavelocation,'PhaseNames.lvm');
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
