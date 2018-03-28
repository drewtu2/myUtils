global running
running = 1;
%running = 2;
%running = 3;

if running == 1
    T=1e-3;
elseif running == 2
    T=2e-3;
elseif running == 3
    T=4;
end

factor=4;
T1=T/factor;
f0=1/T;

figure(running)
hold on;

N_orders=[0,1,2,3,7,12,1000];

colormat=['k','y','b','r','g','m','c',];

sigMax = 0;
for pp=1:length(N_orders)
    N_order=N_orders(pp)
    [signal1, signal2,t,k,ak_t,bk_t,ck]=periodic_square_wave_comments_b(T1,T,N_order);
    fprintf('Finished calculating %i', N_order);
    
    if (running == 1)
        plot(t,signal1,colormat(pp),'linewidth',2);
        sigMax = max(signal1);
    else
        plot(t,signal2,colormat(pp),'linewidth',2);
        sigMax = max(signal2);
    end
    
    set(gca,'fontsize',20) 
    xlabel('Time');
    ylabel('Amplitude');
    title(['Periodic Square Signal, FS Order=',int2str(N_order),', T_1=',num2str(T1),', T=',num2str(T)]);
end;

legend(int2str(N_orders'));
xlim([-T T]);
ylim([-(sigMax * 1.25) (sigMax * 1.25)])
print -dtiff squarewave2.tif
print -depsc squarewave2.eps

% Plot all then wait
pause;

% figure(2);
% subplot(2,1,1)
% stem(k*f0,ak_t,'linewidth',2)
% set(gca,'fontsize',20) 
%     xlabel('Frequency, f (Hz)');
%     ylabel('a_k');
%     title(['Periodic Square Wave Fourier Series Coefficients, f_0=',num2str(f0)]);
%     xlim([0 5000]);
%     subplot(2,1,2)
%     stem(k(2:end)*f0,bk_t(2:end),'linewidth',2)
% set(gca,'fontsize',20) 
%     xlabel('Frequency, f (Hz)');
%     ylabel('b_k');
%     xlim([0 5000]);
% print -dtiff square_FS_trig2.tif
% print -depsc square_FS_trig2.eps
%     
% figure(3);
% kp=[fliplr(-k(2:end)),k];
% ckp=[fliplr(conj(ck(2:end))),ck];
% subplot(2,1,1)
% stem(kp*f0,real(2*pi*ckp),'linewidth',2)
% set(gca,'fontsize',20) 
%     xlabel('Frequency, f (Hz)');
%     ylabel('Re\{X(f)\}');
%     title(['Periodic Square Wave Fourier Series Coefficients, Order=',int2str(N_order),', f_0=',num2str(f0)]);
%     xlim([-5000 5000]);
%     subplot(2,1,2)
%     stem(kp*f0,imag(2*pi*ckp),'linewidth',2)
% set(gca,'fontsize',20) 
%     xlabel('Frequency, f (Hz)');
%     ylabel('Im\{X(f)\}');
%     xlim([-5000 5000]);
%     print -dtiff square_FT2.tif
%     print -depsc square_FT2.eps
%     
%     coefficients_square2=[k' ak_t' bk_t'];
%     save -ascii coefficients_square2 coefficients_square2
%     