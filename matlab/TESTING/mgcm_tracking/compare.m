%% Load data
LMPC_sys=load('LMPC_sysH.mat');
LMPC_art=load('LMPC_artH.mat');
NMPC_sys=load('LMPC_sysH_K.mat');
NMPC_art=load('LMPC_artH_K.mat');
% NMPC_sys=load('NMPC_sysH.mat');
% NMPC_art=load('NMPC_artH.mat');
%% Plot
iterations=size(LMPC_sys.sysHistory,2)-1;
iterations2=size(NMPC_sys.sysHistory,2)-1;
figure;
subplot(5,1,1);
plot(0:iterations,LMPC_sys.sysHistory(1,:), 0:iterations2,NMPC_sys.sysHistory(1,:),'Linewidth',1.5);
grid on
xlabel('iterations');
ylabel('x1');
title('mass flow');
legend({'LMPC', 'NMPC'},'Location','southeast')
subplot(5,1,2);
plot(0:iterations,LMPC_sys.sysHistory(2,:), 0:iterations2,NMPC_sys.sysHistory(2,:),'Linewidth',1.5);
grid on
xlabel('iterations');
ylabel('x2');
title('pressure rise');
legend({'LMPC', 'NMPC'},'Location','southeast')
subplot(5,1,3);
plot(0:iterations,LMPC_sys.sysHistory(3,:), 0:iterations2,NMPC_sys.sysHistory(3,:),'Linewidth',1.5);
grid on
xlabel('iterations');
ylabel('x3');
title('throttle');
legend({'LMPC', 'NMPC'},'Location','southeast')
subplot(5,1,4);
plot(0:iterations,LMPC_sys.sysHistory(4,:), 0:iterations2,NMPC_sys.sysHistory(4,:),'Linewidth',1.5);
grid on
xlabel('iterations');
ylabel('x4');
title('throttle rate');
legend({'LMPC', 'NMPC'},'Location','southeast')
subplot(5,1,5);
plot(0:iterations,LMPC_sys.sysHistory(5,:), 0:iterations2,NMPC_sys.sysHistory(5,:),'Linewidth',1.5);
grid on
xlabel('iterations');
ylabel('u');
title('Sys input');
legend({'LMPC', 'NMPC'},'Location','southeast')

figure;
plot_refs=plot(0:iterations,LMPC_art.art_refHistory(1,:), 0:iterations,LMPC_sys.sysHistory(1,:),'Linewidth',2); hold on;
plot_refs(1).LineStyle='--';
plot_refs(1).Color='c';
plot_refs(2).Color='b';
plot_refs2=plot(0:iterations2,NMPC_art.art_refHistory(1,:), 0:iterations2,NMPC_sys.sysHistory(1,:),'Linewidth',2);
plot_refs2(1).LineStyle='-.';
plot_refs2(1).Color='m';
plot_refs2(2).Color='r';
grid on
xlabel('iterations');
% ylabel('references');
title('Artificial refs vs state responses');
legend({'art ref LMPC', 'mass flow LMPC','art ref NMPC', 'mass flow NMPC'},'Location','northeast')


figure;
plot(LMPC_sys.sysHistory(1,:),LMPC_sys.sysHistory(2,:),'Linewidth',1.5,'Marker','.','Color','b'); hold on;
plot(NMPC_sys.sysHistory(1,:),NMPC_sys.sysHistory(2,:),'Linewidth',1.5,'Marker','.','Color','r'); 
grid on
xlabel('x1');
ylabel('x2');
title('State space');
legend({'LMPC', 'NMPC'},'Location','southeast')