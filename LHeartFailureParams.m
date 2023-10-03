% LHF parameter file
Roa=130; Rac=430; Rcv=250; % resistances, mmHg*s/L
Rvh=30; Rho=10; 
Cv=0.2; Chs=15e-4; Chd=0.01; % compliances, L/mmHg
Co=6.8e-4; Ca=2.6e-3; Cc=6.5e-3; 
Vor=0.085; Var=0.19; Vcr=0.06; % residual volumes, L
Vvr=0.65; Vhr=0; 
Vo(1)=0.150; Va(1)=0.4; Vc(1)=0.3; % initial volume, L
Vv(1)=3.25; Vh(1)=0.1; 
Ts=0.025; Td=0.055; % time constants, systole/diastole, seconds
dt=0.001; N=800; % 8 seconds of real time
t=0:dt:(N-1)*dt; % time vector
state='LHF-Systolic'; 
myname='T.Zoutte';    