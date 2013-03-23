clc
clear all
x1=RecipMat;
x2=RecipMatErr;
x3=x1;
hkls=entriesT(ctr1).hkl;
xyz1Err=[0 0 0];
count=1;
for(i=1:3)
    for(j=1:3)
       varlist(count)=x1(i,j);
       varlist2(count)=x2(i,j);
       count=count+1;
    end
end
tmpvars=varlist;
for(i=1:10)
    if i==1
        tmpvars
        for(j=1:9)
            tmpvars2=tmpvars;
            tmpvars2(j)=tmpvars(j)+varlist2(j);
            tempx3=[tmpvars2(1) tmpvars2(2) tmpvars2(3);tmpvars2(4) tmpvars2(5) tmpvars2(6);tmpvars2(7) tmpvars2(8) tmpvars2(9)]
            temp=tempx3*hkls';
            if(sqrt(xyz1Err(1)^2+xyz1Err(2)^2+xyz1Err(3)^2)<sqrt(temp(1)^2+temp(2)^2+temp(3)^2))
                xyz1Err=temp';
            end
        end    
    else
        tmpvars(i-1)=tmpvars(i-1)+varlist2(i-1)
        for(j=i:9)
            tmpvars2=tmpvars;
            tmpvars2(j)=tmpvars(j)+varlist2(j);
            tempx3=[tmpvars2(1) tmpvars2(2) tmpvars2(3);tmpvars2(4) tmpvars2(5) tmpvars2(6);tmpvars2(7) tmpvars2(8) tmpvars2(9)]
            temp=tempx3*hkls';
            if(sqrt(xyz1Err(1)^2+xyz1Err(2)^2+xyz1Err(3)^2)<sqrt(temp(1)^2+temp(2)^2+temp(3)^2))
                xyz1Err=temp';
            end
        end    
    end
end