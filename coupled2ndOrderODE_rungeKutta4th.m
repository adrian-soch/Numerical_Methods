clc; clearvars; close all;

a = 0;
b = 17.1;
n = [100 1000 10000 20000];

%u_1 = zeros(2,length(t));  % <-- changed 1 to 2, each column u_1(:,i) is the state at time t(i)
%u_2 = zeros(2,length(t));
u_1(1,1) = 0.994;  % <-- The initial value of u_1  at time 1
u_1(2,1) = 0;  % <-- The initial value of u_1' at time 1
u_2(1,1) = 0; % <-- The initial value of u_2  at time 1
u_2(2,1) = -2.001585106379082522420537862224; %<-- The initial value of u_2' at time 1

for iter = 1:length(n)
    h = (b-a)/n(iter);
    t = a:h:b;
    for i=1:(length(t)-1)  % At each step in the loop below, changed u_1(i) to u_1(:,i) to accomodate 2-element results
      k1 = f( t(i)      , u_1(:,i)  ,u_2(:,i)        );
      k11 = g( t(i)      , u_1(:,i) ,u_2(:,i)        );
      
      k2 = f( t(i)+0.5*h, u_1(:,i)+0.5*h*k1, u_2(:,i)+0.5*h*k11);
      k22 = g( t(i)+0.5*h, u_1(:,i)+0.5*h*k1,u_2(:,i)+0.5*h*k11);
      
      k3 = f( t(i)+0.5*h, u_1(:,i)+0.5*h*k2,u_2(:,i)+0.5*h*k22);
      k33 = g( t(i)+0.5*h, u_1(:,i)+0.5*h*k2,u_2(:,i)+0.5*h*k22);
      
      k4 = f( t(i)+    h, u_1(:,i)+    h*k3,u_2(:,i)+    h*k33);
      k44 = g( t(i)+    h, u_1(:,i)+    h*k3,u_2(:,i)+    h*k33);
      
      u_1(:,i+1) = u_1(:,i) + (1/6)*(k1 + 2*k2 + 2*k3 + k4)*h; 
      u_2(:,i+1) = u_2(:,i) + (1/6)*(k11 + 2*k22 + 2*k33 + k44)*h; 
    end 
    
    figure
    plot(t,u_1(1,:),'r','LineWidth',2);
    hold on;
    plot(t,u_2(1,:),'c','LineWidth',2);
    title("n = " + n(iter));
    legend('u_1', 'u_2');
    
    figure 
    plot(u_1(1,:),u_2(1,:))
end
