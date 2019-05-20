function s_tilde = rx_hardware(y, par_rxthresh, switch_graph)

%pass through signal with no modification--------
s_tilde = y;
%------------------------------------------------


if switch_graph == 1
    figure;
    subplot(2, 1, 1)
    plot(abs(y), 'color', 1/255 * [33 70 122]);
    title('rx: Signal before rx hardware');
    ylabel('Magnitude');
    subplot(2, 1, 2);
    plot(abs(s_tilde), 'color', 1/255 * [33 70 122]);
    title('rx: Signal after rx hardware');
    xlabel('Samples');
    ylabel('Magnitude');
end