clear all
clc
format short g
disp('**** PCO:Plant Competition Optimization Algorithm ****')
disp('**** This program has been written by Iman Ali Abdi ****')

Function_name='F23';
fprintf('Function_name=%s\n',Function_name);

%n=input('please input the number of initial plants:');
n=20;
fprintf('Number of initial plants=%d\n',n);

%vmax=input('please input Vmax, maximum size of plants:');
vmax=10;
%Noi=input('please input maximum number of algorithm''s iteration:');
Noi=200;
fprintf('maximum number of algorithm''s iteration=%d\n',Noi);

%MaxPlantNumber=input('please input Maximum of Plants Number:');
MaxPlantNumber=1000;
maxPlant=n;
fprintf('Maximum of Plants Number:=%d\n',MaxPlantNumber);

[lb,ub,dim,fobj]=Get_Functions_details(Function_name);

%rmax=45;
rmax=ub-lb;

maxTeta=exp(-1);
fprintf('max Teta=%5f\n',maxTeta);

teta=maxTeta;
%teta=input('Teta is growth rate of neighborhood radius, Please input Teta:');
%k=input('k is a growth parameter, Please input k:');
k=0.1;

miu=0.05;
%miu=input('Miu is Seed Migration Rate, Please input Miu:');
%A=-15;
%B=30;

A=lb;
B=ub;

%seeding, initialization
plants=A+(B-A).*rand(n,dim);
r=zeros(n,1);
v=rand(n,1);
plantNumber=n;
iteration=1;
best=[];
x=plants;

migrantSeedsNo=0;
migrantPlant=[];

while plantNumber<=MaxPlantNumber && iteration<=Noi
    
    %f=-20*exp(-0.2*sqrt(0.5*(sum(plants'.^2)')))-exp(0.1*(sum(cos(2*pi*plants)')'))+20+exp(1);
    %f=fobj(plants');
    
    for i=1:plantNumber
       f(i)=fobj(plants(i,:));
    end
    
    %Calculate Fitness Coefficient=fc
    best=[best;min(f)];
    fn=f./norm(f);
    fitness=1./(1+fn);
    %f=fitness;
    mx=max(fitness);
    mn=min(fitness);
    if mn == mx
        fc=fitness./mx;
    else
        fc=(fitness-mn)./(mx-mn);
    end
         
    sfc=sort(fc,'descend');
    survive=(fc>=sfc(maxPlant));
    newPlant=[];
   
    for i=1:plantNumber
        if survive(i)==1
            newPlant=[newPlant;plants(i,:)];
        end
    end
       
    plants=newPlant;
    sz=size(newPlant);
    x1=plants(:,1);
    y=plants(:,2);
    sx=size(x1);
    plantNumber=sx(1);
    
       
    st=zeros(plantNumber,1);
    for i=1:plantNumber
        % Compute Neighborhood Radius
         r(i)=teta*rmax*exp(1-(5*v(i))/vmax);
        
         non=0;%Number of Neighbors
         for j=1:plantNumber
              if sqrt(sum((plants(i,:)-plants(j,:)).^2))<=r(i)% i,j are neighboor
                  st(i)=st(i)+v(j);
                  non=non+1;
                  %st(i)=st(i)+1;
              end
         end
         dv(i)=fc(i)*k*(log(non*vmax)-log(st(i)));
         
        if v(i)+dv(i)<vmax
            v(i)=v(i)+dv(i);
        else
            v(i)=vmax;
        end
    end
           
    %SEED PRODUCTION  *********************************************
    
    %v_mean=mean(v)
    sumNos=0;
    for i=1:plantNumber
        NOS(i)=floor(v(i)+1);
        sumNos=sumNos+NOS(i);
        for j=1:NOS(i)
            RND=randi(dim);
            Temp=(plants(i,RND)-r(i))+2*r(i)*rand;
            seed=plants(i,:);
            seed(RND)=Temp;
            plants=[plants;seed];
            v=[v;rand];
        end
    end
    
    % SEED MIGRATION ************************************************
    migrantSeedsNoOld=migrantSeedsNo;
    migrantSeedsNo=floor(miu*sumNos);
    %disp(sprintf('%10d','%10d','%10d',iteration,plantNumber,migrantSeedsNo));  
    %plantNumber=plantNumber+sum(NOS);
    %disp(sprintf('migrantSeedsNo=%d',migrantSeedsNo));
    
    migrantPlantOld=migrantPlant;
    
    migrantPlant=randi([plantNumber+1,plantNumber+sumNos],1,migrantSeedsNo);
    for i=1:migrantSeedsNo
        temp=A+(B-A).*rand(1,dim);
        plants(migrantPlant(i),:)=temp;
    end
    
    plantNumberOld=plantNumber;
    x=plants(:,1);
    %y=plants(:,2);
    szx=size(x);
    plantNumber=szx(1);
           
    iteration=iteration+1;
   %disp('************************************');
   
end
    
%plot(best,'m',1);
plot(best,'b*-','LineWidth',1,'MarkerEdgeColor','r','MarkerSize',5)
xlabel('Iteration')
ylabel('Minimum')
title('Algorithm''s Convergence' )
best
for i=1:migrantSeedsNoOld
    f(migrantPlantOld(i))=-10000;
end

%st=sort(f');
%minF=min(st(migrantSeedsNoOld+1:plantNumberOld))
%maxF=max(f)
maxF=max(f)
for i=1:migrantSeedsNoOld
    f(migrantPlantOld(i))=10000;
end
minF=min(f)
%a_max=max(a)
v_max=max(v)
r_max=max(r)