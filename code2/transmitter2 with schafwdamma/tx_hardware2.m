function x = tx_hardware2(s, par_txthresh, switch_graph)
x = [];

for ii = 1:length(s)
    %cut off values above threshold-------------
    if abs(s(ii)) > par_txthresh
        x(ii) = s(ii) / abs(s(ii)) * par_txthresh;
    else
        x(ii) = s(ii);
    end
    %-------------------------------------------
end

if switch_graph == 1
    figure;
    subplot(2, 1, 1)
    plot(abs(s), 'color', 1/255 * [33 70 122]);
    title('tx: Signal before thresholding');
    ylabel('Magnitude');
    grid;
    subplot(2, 1, 2);
    plot(abs(x), 'color', 1/255 * [33 70 122]);
    title('tx: Thresholded signal');
    xlabel('Samples');
    ylabel('Magnitude');
    grid;
end