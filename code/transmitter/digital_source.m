function b = digital_source(par_no, switch_graph)
%print number of ones, zeros
b = rand(1, par_no)>0.5;

if switch_graph == 1
    par_N_FFT = 1024;
    figure;
    b_mean = mean(b(1:par_N_FFT));
    scatter(1:par_N_FFT, b(1:par_N_FFT), 36, 1/255 * [33 70 122]);
    hold on;
    plot(1:par_N_FFT, b_mean*ones(par_N_FFT, 1), 'color', 1/255 * [196 38 58]);
    hold off;
    xlim([1 par_N_FFT]);
    ylim([-.2 1.2]);
    xlabel('Frame');
    ylabel('Binary Value');
    title('Binary Pattern of Digital Source - Tx');
end