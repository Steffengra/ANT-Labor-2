function [BER] = digital_sink(b, b_hat, switch_graph)
limit = floor(.8 * length(b_hat)); % workaround in case bits are stuck

BER = sum(abs(b(1:limit) - b_hat(1:limit))) / limit;

if switch_graph == 1
    difference = .5 * abs(b(1:limit) - b_hat(1:limit));
    difference(difference == 0) = nan;
    figure;
    scatter(1:limit, b(1:limit), 36, 1/255 * [33 70 122]);
    hold on;
    scatter(1:limit, b_hat(1:limit), 36, 1/255 * [62 150 81]);
    scatter(1:limit, difference, 10, 1/255 * [196 38 58]);
    hold off;
    xlim([1 limit]);
    ylim([-.2 1.2]);
    xlabel('Frame');
    ylabel('Binary Value');
    title('Binary Pattern of Digital Source - Tx and Rx');
    legend('Tx Binary Pattern', 'Rx Binary Pattern', 'Error Positions');
end