function s_tilde = rx_hardware(y, par_rxthresh, switch_graph)
% just pass through

s_tilde = [];

for ii = 1:length(y)
    if abs(y(ii)) > par_rxthresh
        y(ii) = y(ii)/abs(y(ii));
    end 
end

s_tilde = y;

if switch_graph == 1
    figure;
    subplot(2, 1, 1)
    plot(abs(y));
    title('signal before thresholding');
    ylabel('magnitude');
    subplot(2, 1, 2);
    plot(abs(s_tilde));
    title('thresholded signal');
    xlabel('samples');
    ylabel('magnitude');
end