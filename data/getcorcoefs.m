function [corrpoints,SS,SSxy,Rvals]=getcorcoefs(Tensor)
%Obtains the correlation coefficients between all locations of the given
%multidimensional tensor.

tsize=size(Tensor);
corrpoints=zeros(tsize(1)*tsize(2),tsize(3));
SS=zeros(1,tsize(1)*tsize(2));
means=SS;
counter=1;
for i=1:tsize(1)
    for j=1:tsize(2)
        for k=1:tsize(3)
            %gather 3D matrix and store into a 2D matrix
            corrpoints(counter,k)=Tensor(i,j,k);
            SS(counter)=SS(counter)+(corrpoints(counter,k)-mean(Tensor(i,j,:)))^2;
        end
        %SS(counter)=var(corrpoints(counter,:))*tsize(3);
        means(counter)=mean(corrpoints(counter,:));
        counter=counter+1;
    end
end
counter=1;
SSxy=zeros(tsize(1)*tsize(2),tsize(1)*tsize(2));
for i=1:tsize(1)*tsize(2)
    for j=1:tsize(1)*tsize(2)
        for k=1:tsize(3)
            SSxy(i,j)=SSxy(i,j)+(corrpoints(i,k)-means(i))*(corrpoints(j,k)-means(j));
        end
        Rvals(i,j)=sqrt(SSxy(i,j)^2/(SS(i)*SS(j)));
    end
end

end