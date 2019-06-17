%Draw multiple curves in graph
%Global Parameters-------------------------------
switch_mod = 2;         %QAM: 0==4QAM, 1==16QAM, 2==64QAM
switch_graph = 1;       %0==off, 1==on, 2==BER only
switch_off_cc = 0;      %Channel Coding 0==on, 1==off
switch_off_filt = 1;    %Filter 0==on, 1==off
switch_map = 0;         %0==block mapping, 1==alternating
switch_scfdma1 = 0;
switch_scfdma2 = 1;
switch_offset = 1;
par_N_FFT = 1024;
par_txthresh = 100;
par_rxthresh = 1;
par_N_CP = 200;
par_N_zeros = 0;
par_channel = 'AWGN';   %AWGN or FSBF
par_tx_w = 8;           %Oversampling Factor
par_rx_w = par_tx_w;

par_H = [1 0 1 0 1 0 1;0 1 1 0 0 1 1;0 0 0 1 1 1 1]; %Channelcoding Parity check Matrix

par_N_block = 1;
par_no = par_N_block*1024*(2*switch_mod + 2) * (1 + not(switch_off_cc)*3) *2;
par_N_block = par_N_block * ( 1 + 6 * not(switch_off_cc) );
%------------------------------------------------------------------------

%Transmission Simulation-------------------------
dB_range = 40:5:40;
for ii = 1:length(dB_range)
    par_SNRdB = dB_range(ii);
    run a_transmitter1.m
    source1 = b;
    source1_coded = c;
    source1_transmitsignal = x;
    transmitsignal = x;
    run a_transmitter2.m
    source2 = b;
    source2_coded = c;
    source2_transmitsignal = x;
    %transmitsignal = source1_transmitsignal + source2_transmitsignal;
    transmitsignal = source1_transmitsignal;
    transmitsignal(2,:) = source2_transmitsignal;
    y = Channel_freqoffset(transmitsignal, par_SNRdB, switch_offset);
    %cut off extra symbols
    y = y(:,1:length(x));
    run a_receiver.m
    BER_uncoded_tot_1(ii) = BER_uncoded_1;
    BER_uncoded_tot_2(ii) = BER_uncoded_2;
    BER_coded_tot_1(ii) = BER_coded_1;
    BER_coded_tot_2(ii) = BER_coded_2;
    PAPR_tot_1 = PAPR_1;
    PAPR_tot_2 = PAPR_2;
end

if or(switch_graph == 1, switch_graph==2)
    figure;
    plot(dB_range, BER_uncoded_tot_1, 'color', 1/255 * [33 70 122]);
    hold;
    plot(dB_range, BER_uncoded_tot_2)
    plot(dB_range, BER_coded_tot_1);
    plot(dB_range, BER_coded_tot_2);
    legend('BER uncoded 1', 'BER uncoded 2', 'BER coded 1', 'BER coded 2');
    title('BER over SNR|DB');
    xlabel('SNR|DB');
    ylabel('BER');
    grid;
    
    figure;
    stem(PAPR_tot_1);
    hold;
    stem(PAPR_tot_2);
    title('PAPR OFDM vs SCFDMA');
    xlabel('OFDM Symbols');
    ylabel('PAPR per symbol');
    legend('OFDM', 'SCFDMA');
end
