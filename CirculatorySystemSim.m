clearvars;
clf;
pf=input('What parameter file do you want to use? \n', 's');
eval(pf);
% create temp variables for compliance (sys/dias)
Chstemp=(Chd-Chs)*exp(-t(1:250)/Ts)+Chs;
Chdtemp=(Chs-Chd)*exp(-t(1:550)/Td)+Chd;
% create step function for heart compliance 
Ch(1:100)=Chdtemp(451:550);
Ch(101:350)=Chstemp(1:250);
Ch(351:800)=Chdtemp(1:450);
for b=1:10 % 10 heart beats
    for n=1:N % 1 heart cycle
        % pressure from compliance
        Po(n)=(Vo(n)-Vor)/Co;
        Pa(n)=(Va(n)-Var)/Ca;
        Pc(n)=(Vc(n)-Vcr)/Cc;
        Pv(n)=(Vv(n)-Vvr)/Cv;
        Ph(n)=(Vh(n)-Vhr)/Ch(n);
        % Poiseuille's law
        if Ph(n)>Po(n)
            Q1(n)=(Ph(n)-Po(n))/Rho;
        else Q1(n)=0;
        end % aortic valve
        if Pv(n)>Ph(n);
            Q9(n)=(Pv(n)-Ph(n))/Rvh;
        else Q9(n)=0;
        end % mitral valve
        Q3(n)=(Po(n)-Pa(n))/Roa;
        Q5(n)=(Pa(n)-Pc(n))/Rac;
        Q7(n)=(Pc(n)-Pv(n))/Rcv;
        % conservation of volume
        Q2(n)=Q1(n)-Q3(n);
        Q4(n)=Q3(n)-Q5(n);
        Q6(n)=Q5(n)-Q7(n);
        Q8(n)=Q7(n)-Q9(n);
        Q10(n)=Q9(n)-Q1(n);
        % Euler's update
        Vh(n+1)=Vh(n)+(Q10(n)*dt);
        Vo(n+1)=Vo(n)+(Q2(n)*dt);
        Va(n+1)=Va(n)+(Q4(n)*dt);
        Vc(n+1)=Vc(n)+(Q6(n)*dt);
        Vv(n+1)=Vv(n)+(Q8(n)*dt);
    end
    hold off; 
    plot(t,Ph,'-k'); 
    hold on; 
    plot(t,Po,':r');
    plot(t,Pa,'-.m'); 
    plot(t,Pc,'--c'); 
    plot(t,Pv,'-b');
    xlabel('Time (s)'); 
    ylabel('Pressure (mmHg)');
    title(['Five Cardiac Cycle Pressures, ', state,': ' myname]);
    grid on;
    legend('Ph','Po','Pa','Pc','Pv');
    Q1avg=(mean(Q1)*60); % convert to L/min
    text(0.5,25,sprintf('CO = %1.1f L/min',Q1avg));
    text(0.5,50,sprintf('Beat # = %1.f',b));
    Vh(1)=Vh(n+1); 
    Vo(1)=Vo(n+1);
    Va(1)=Va(n+1);
    Vc(1)=Vc(n+1);
    Vv(1)=Vv(n+1);
    shg;
    pause(1);
end 
