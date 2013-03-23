function Temps_from_Data = symmetrysort(datin)
%Sorts Input structure values based on symmetry
Temps_from_Data=datin;
for i=1:length(datin)
    for j=1:length(datin(i).chem)
        switch lower(datin(i).chem(j).structure)
            case 'cubic'
                Temps_from_Data(i).chem(j).b=datin(i).chem(j).a;
                Temps_from_Data(i).chem(j).bErr=datin(i).chem(j).aErr;
                Temps_from_Data(i).chem(j).c=datin(i).chem(j).a;
                Temps_from_Data(i).chem(j).cErr=datin(i).chem(j).aErr;
                Temps_from_Data(i).chem(j).beta=datin(i).chem(j).alpha;
                Temps_from_Data(i).chem(j).betaErr=datin(i).chem(j).alphaErr;
                Temps_from_Data(i).chem(j).gamma=datin(i).chem(j).alpha;
                Temps_from_Data(i).chem(j).gammaErr=datin(i).chem(j).alphaErr;
            case 'orthorhombic'
                Temps_from_Data(i).chem(j).beta=datin(i).chem(j).alpha;
                Temps_from_Data(i).chem(j).betaErr=datin(i).chem(j).alphaErr;
                Temps_from_Data(i).chem(j).gamma=datin(i).chem(j).alpha;
                Temps_from_Data(i).chem(j).gammaErr=datin(i).chem(j).alphaErr;
            case 'trigonal'
                Temps_from_Data(i).chem(j).b=datin(i).chem(j).a;
                Temps_from_Data(i).chem(j).bErr=datin(i).chem(j).aErr;
                Temps_from_Data(i).chem(j).c=datin(i).chem(j).a;
                Temps_from_Data(i).chem(j).cErr=datin(i).chem(j).aErr;
                Temps_from_Data(i).chem(j).beta=datin(i).chem(j).alpha;
                Temps_from_Data(i).chem(j).betaErr=datin(i).chem(j).alphaErr;
                Temps_from_Data(i).chem(j).gamma=datin(i).chem(j).alpha;
                Temps_from_Data(i).chem(j).gammaErr=datin(i).chem(j).alphaErr;
            case 'hexagonal'
                Temps_from_Data(i).chem(j).b=datin(i).chem(j).a;
                Temps_from_Data(i).chem(j).bErr=datin(i).chem(j).aErr;
                Temps_from_Data(i).chem(j).beta=datin(i).chem(j).alpha;
                Temps_from_Data(i).chem(j).betaErr=datin(i).chem(j).alphaErr;
            case 'tetragonal'
                Temps_from_Data(i).chem(j).b=datin(i).chem(j).a;
                Temps_from_Data(i).chem(j).bErr=datin(i).chem(j).aErr;
                Temps_from_Data(i).chem(j).beta=datin(i).chem(j).alpha;
                Temps_from_Data(i).chem(j).betaErr=datin(i).chem(j).alphaErr;
                Temps_from_Data(i).chem(j).gamma=datin(i).chem(j).alpha;
                Temps_from_Data(i).chem(j).gammaErr=datin(i).chem(j).alphaErr;
            case 'monoclinic'
                Temps_from_Data(i).chem(j).gamma=datin(i).chem(j).alpha;
                Temps_from_Data(i).chem(j).gammaErr=datin(i).chem(j).alphaErr;
        end
    end
end
end

