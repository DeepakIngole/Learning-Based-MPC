function plot_RESPONSE(sysHistory,art_ref, t_vec, n, m)
figure;
    for i=1:n+m
        subplot(n+m,1,i);
        plot(t_vec,sysHistory(i,:),'Linewidth',1.5); hold on;
        plot(t_vec,art_ref(i,:),'Linewidth',1.0,'LineStyle','--'); hold on;
        grid on
        xlabel('time [s]');
        if i<=n
            lableTex = ['\delta x_{',num2str(i),'}'];
        else
            lableTex = ['\delta u_{',num2str(i-n),'}'];
        end
        ylabel(lableTex,'Interpreter','tex' );
    end
end