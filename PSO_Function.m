function[PSO_Best,PSO_Call]=PSO_Function(A,B,psz,PsoIteration, dim, fobj)

%************************* PSO *******************************
c1=1.0;
c2=0.3;
inertia=0.8;


% Step1(Initialization)
pso=A+(B-A).*rand(psz,dim);
%x=pso(:,1);
%y=pso(:,2);
Best_particle=[];
bestPso=[];
%particle velocities,v[i] are initialized randomly.
vp=random('normal',0,1,psz,dim);
%vp=round(v1);
PSO_Call=0;
%Evaluate fitness[i]
%f=-20*exp(-0.2*sqrt(0.5*(sum(pso'.^2)')))-exp(0.1*(sum(cos(2*pi*pso)')'))+20+exp(1);
%f=fobj(pso');
for i=1:psz
   f(i)=fobj(pso(i,:));
end
%end
PSO_Call=PSO_Call+psz;
    
[mn,index1]=min(f);
mx=min(f);
bestPso=[bestPso;mn];
Best_particle=[Best_particle;pso(index1,:)];
fitness=f';

%Initialize Gbest whit the index of the particle whit the best
%fitness(lowest cost) among the population

Gbest=1;
for i=1:psz
    if fitness(i)<=fitness(Gbest)
        Gbest=i;
    end;
end;

%Initialize Pbest[i] whit a copy of pso[i] for each i<=p.
Pbest=pso;
Pbest_fitness=f';
bestPso=[];
% Repeat until a number of generation,equal to twice the total number of
% task,is passed.
for iteration=1:PsoIteration
    
    %fprintf('*************************************************************\n');
    %fprintf('\niteration=%d',iteration);
    
    %Step2.1: Find Gbest such that fitness[Gbest]>=fitness[i] for each i<=p.
    for i=1:psz
       if fitness(i)<=fitness(Gbest)
          Gbest=i;
       end;
    end;
    
    %fprintf('\n\nGbest=%d',Gbest);
    Best_Fitness=fitness(Gbest);
    %fprintf('\nBest_Fitness=%d',Best_Fitness);
    %fprintf('\n');
    
    bestPso=[bestPso;Best_Fitness];
    Best_particle=pso(Gbest,:);
    fitness;
    
    %Step2.2: For each particle i:Pbest[i]=pso[i] iff
    %fitness[i]>Pbest_fitness[i] for each i<=p.
    for i=1:psz
       if Pbest_fitness(i)>fitness(i)
           Pbest(i,:)=pso(i,:);
       end;
    end;
    Pbest_fitness;
    
    %Step2.3: For each particle i:Update v[i] and pso[i]
    for i=1:psz
        vp(i,:)=inertia*vp(i,:)+c1*rand(1,dim).*(Pbest(i,:)-pso(i,:))+c2*rand(1,dim).*(pso(Gbest,:)-pso(i,:));
        pso(i,:)=pso(i,:)+vp(i,:);
        %x=pso(:,1);
        %y=pso(:,2);
        %pso(i,:)=mod(pso(i,:),NOP)+1;
    end;
    
           
    %Step2.4:Evaluvate fitness[i] 
    %f=-20*exp(-0.2*sqrt(0.5*(sum(pso'.^2)')))-exp(0.1*(sum(cos(2*pi*pso)')'))+20+exp(1);
    %f=fobj(pso');
    for i=1:psz
        f(i)=fobj(pso(i,:));
    end
    fitness=f';
    PSO_Call=PSO_Call+psz;

end;%Iteration
  
  %PSO_best=max(bestPso)
  %PSO_bestFT=[PSO_bestFT;PSO_best];
  [Result,index]=min(bestPso);
  PSO_Best=Result;
  %maximum_point=Best_Particle(index,:) 
 %bestPso
  
%best 
%plot(bestPso,'b*-','LineWidth',1,'MarkerEdgeColor','r','MarkerSize',5)
%xlabel('Iteration')
%ylabel('Minimum')
%title('Convergence of PSO Algorithm')
