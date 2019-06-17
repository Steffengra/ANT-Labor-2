
s_tilde = rx_hardware(y, par_rxthresh, switch_graph);
z_tilde = rx_filter(s_tilde, par_rx_w, switch_graph, switch_off_filt);
D_tilde = ofdm_demod(z_tilde, par_N_FFT, par_N_CP, switch_map, 0, switch_graph);
d_bar = equalizer1(D_tilde(1,:), switch_mod, switch_graph);
d_bar(2,:) = equalizer2(D_tilde(2,:), switch_mod, switch_graph);
c_hat = demodulation(d_bar(1,:), switch_mod, switch_graph);
c_hat(2,:) = demodulation(d_bar(2,:), switch_mod, switch_graph);
b_hat = channel_decoding(c_hat(1,:), par_H, par_N_zeros, switch_off_cc);
b_hat(2,:) = channel_decoding(c_hat(2,:), par_H, par_N_zeros, switch_off_cc);

[BER_uncoded_1, BER_coded_1, PAPR_1] = digital_sink(source1, b_hat(1,:), source1_coded, c_hat(1,:),...
                                                    source1_transmitsignal, par_N_FFT, par_N_CP, switch_graph);
[BER_uncoded_2, BER_coded_2, PAPR_2] = digital_sink(source2, b_hat(2,:), source2_coded, c_hat(2,:),...
                                                    source2_transmitsignal, par_N_FFT, par_N_CP, switch_graph);
