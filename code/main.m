%Draw multiple curves in graph
%Global Parameters-------------------------------
switch_mod = 2;         %QAM: 0==4QAM, 1==16QAM, 2==64QAM
switch_graph = 1;       %0==off, 1==on, 2==BER only
switch_off_cc = 0;      %Channel Coding 0==on, 1==off
switch_off_filt = 1;    %Filter 0==on, 1==off
par_N_FFT = 1024;
par_txthresh = 100;
par_rxthresh = 1;
par_N_CP = 200;
par_N_zeros = 0;
par_channel = 'AWGN';   %AWGN or FSBF
par_tx_w = 8;          %Oversampling Factor
par_rx_w = par_tx_w;

par_H = [1 0 1 0 1 0 1;0 1 1 0 0 1 1;0 0 0 1 1 1 1]; %Channelcoding Parity check Matrix 

%Transmission Simulation-------------------------
dB_range = 40:5:40;
for ii = 1:length(dB_range)
    par_SNRdB = dB_range(ii);
    run a_transmitter.m
    run a_receiver.m
    BER_tot(ii) = BER;
end

if or(switch_graph == 1, switch_graph==2)
    figure;
    plot(dB_range, BER_tot, 'color', 1/255 * [33 70 122]);
    title('BER over SNR|DB');
    xlabel('SNR|DB');
    ylabel('BER');
    grid;
end
