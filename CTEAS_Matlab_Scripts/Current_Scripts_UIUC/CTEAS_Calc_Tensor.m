close all;
cd(Path_To_CTERun);
savedir=strcat(Input_File_Directory_Location,'\CTEAS_Output\','jade_data.mat');
load(savedir);
T_room=25;
Temps_to_be_Analyzed=LT:TS:HT;
System_Analyzed=xtalsym;
[lsfits,entries,params]=xtalCTEprep(Temps_from_Data,Phase_to_be_Analyzed,Polyfit_order,T_room);
%Calculate thermal expansion tensors at a range of temperatures specified earlier
%and plot them; create the movie.
NumCalcs=length(Temps_to_be_Analyzed);
xmax=0;
ymax=0;
zmax=0;
cmax=0;
%Pre-allocate variable lengths
Tensor=zeros(3,3,NumCalcs);
ConMat=zeros(3,3,NumCalcs);
x=zeros(101,101,NumCalcs);
y=zeros(101,101,NumCalcs);
z=zeros(101,101,NumCalcs);
c=zeros(101,101,NumCalcs);
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
for n=1:NumCalcs
    [Tensor(:,:,n),ConMat(:,:,n)]=xtalCTE(lsfits,entriesT,params,Temps_to_be_Analyzed(n),System_Analyzed,T_room);
end
%Unsorted Eigenvalues and Eigenvectors
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
%note, the loop below was split from the xtalCTE loop because of the 
%eigenvalue sorting.  This keeps all eigenvalues and eigenvectors the same
%through the calculations.
for n=1:NumCalcs
    [x(:,:,n),y(:,:,n),z(:,:,n),c(:,:,n)]=plotEllipsoid(V(:,:,n),D(:,n));
end
savedir=strcat(outputsavelocation,'xtal_data.mat');
save(savedir,'Tensor','ConMat','V','D','x','y','z','c','Temps_to_be_Analyzed','NumCalcs','System_Analyzed','lsfits','entries','entriesT','params','T_room');
ReadyForAnalysis=1;
