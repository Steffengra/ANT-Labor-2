
s_tilde = rx_hardware(y, par_rxthresh, switch_graph);
z_tilde = rx_filter(s_tilde, par_rx_w, switch_graph, switch_off_filt);
d_tilde = ofdm_demod(z_tilde, par_N_FFT, par_N_CP, switch_graph);
d_bar = equalizer(d_tilde, switch_mod, switch_graph);
c_hat = demodulation(d_bar, switch_mod, switch_graph);
b_hat = channel_decoding(c_hat, par_H, par_N_zeros, switch_off_cc);
[BER] = digital_sink(b, b_hat, switch_graph);