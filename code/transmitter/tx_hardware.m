function x = tx_hardware(s, par_txthresh, switch_graph)
x = [];

for ii = 1:length(s)
    if abs(s(ii)) > par_txthresh
        x(ii) = s(ii)/abs(s(ii));
    else
        x(ii) = s(ii);
    end 
end

if switch_graph == 1
    figure;
    subplot(2, 1, 1)
    plot(abs(s));
    title('signal before thresholding');
    ylabel('magnitude');
    subplot(2, 1, 2);
    plot(abs(x));
    title('thresholded signal');
    xlabel('samples');
    ylabel('magnitude');
end