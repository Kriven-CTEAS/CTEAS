%%Input file for CTE Calculations - CTERun v1.4 - CTERun.m
%%Created by Zachary A. Jones
%%An example wrapper for other scripts to automate the CTEAS process using
%%ONLY Matlab.
%%Make a copy and modify as necessary, or build your own.  All values below
%%are required for functionality.

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

%% Input File Directory (single quotes around directory!)
clc;
clear all;
close all;
%Input_File_Directory_Location='C:\Users\Zach\Desktop\Oxides\4b-Al2O3-T\Replace\';
Input_File_Directory_Location='/home/jonesza/Dropbox/Zach-Share/Oxides/4b-Al2O3-T/';


%% File Type to read: 1 for JADE, 0 for CSV
Want_Jade_Files=1;

%% Room Temperature (degC):
T_room=25;

%% Platinum Lattice Constant at Room Temperature (0 if no Pt):
Reference_T_Value=3.92330;
%Reference_T_Value=0;

%% Phase Information:
Phase_to_be_Analyzed='Aluminium Oxide';
Symmetry_Analyzed='Hexagonal';

%% Polynomial Fit Order
Polyfit_order=2;

%% Temperature Analysis Steps and Boundaries (degC):
LowT=25;
Tstep=25;
HighT=1525;

%% Size of Figures to be Generated (pixels):
Xscreensize=800;
Yscreensize=600;

%% Movie File Creation Options:
Want_A_Movie=0;
fps=4;
%Frames per second for movie.
Movie_File_Name='Al2O3(25C-1525C)';
%Name of the movie; don't add .avi at the end!

%% 3D Figure Creation Options:
Want_Figures=1;
%1 if true, 0 if false
Figure_Temps=[25 134 221 310 421 514 611 746 920 1051 1184 1306 1421 1548 1617 1703];
%Temperature of Generated figures in Celsius. eg: [100;200;1200]

%% Plot Eigenvalues vs. Temperature:
Want_Eig_Plot=0;

%% Create a CSV File containing pertinent data:
Want_A_Printout=1;
%Makes a printout of temp, CTE matrix, and eigenvalues.  Also prints out 
%the angles that the eigenvectors make with a plane (specified below, 
%also if inUVW==1, specify UVW instead of HKL):
inUVW=0;
huorient=0;
kvorient=0;
lworient=1;
Printout_Filename='Al2O3_Results_25C-1525C-3';

%% Create 2D Cross-Section Figures:
Want_2D_Figures=0;
inUVW2=1;
huorient2=1;
kvorient2=0;
lworient2=0;
%1 if true, 0 if false.  Makes a figure with the a,b,c orientation
%specified below (if inUVW2==1, specify UVW instead of HKL):

%% Make a CSV file from 2D Cross-Section Figure Data (requires Want_2D_Figures==1):
Output_2D_Figure_Data=0;
Output_2D_Filename='Out2DAl2O3';

%% Make a hkl or uvw linear expansion plot:
Want_HKLorUVW_Expansion_Plot=0;
%1 if true, 0 if false.  Makes a plot of expansion values along an hkl
%or UVW with respect to temperature.
inUVW3=1;
HKLorUVW=[1;0;0];

%% Make a CSV file from hkl or uvw expansion data (requires Want_HKLorUVW_Expansion_Plot==1):
Save_HKL_Expansion_Printout=0;
HKL_Filename_Prefix=Printout_Filename;
%Saves the HKL Expansion data to a file that is automatically named using
%the option above.  Modify if necessary, saved as:
%<Input_File_Directory_Location><HKL_Filename_Prefix>-hkl(or uvw)-<h/u><k/v><l/w>-Expansion.txt

%% Execute CTERun.m
CTERun
