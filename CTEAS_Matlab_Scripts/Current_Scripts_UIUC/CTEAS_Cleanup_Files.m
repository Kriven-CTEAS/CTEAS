dataloc=strcat(Filepath,'\CTEAS_Output');
cd(dataloc);
delete('Data_Temperatures.lvm');
delete('PhaseNames.lvm');
delete('jade_data.mat');
delete('xtal_data.mat');
clc;
clear all;
close all;