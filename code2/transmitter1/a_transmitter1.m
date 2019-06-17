par_userid = 1;

b = digital_source(par_no / 2, switch_graph);
c = channel_coding(b, par_H, par_N_zeros, switch_off_cc);
d = modulation(c, switch_mod, switch_graph);
D = pilot_insertion(d, par_N_FFT, par_N_block / 2, switch_graph);
z = tx_ofdm_mod(D, par_N_FFT, par_N_CP, par_userid, switch_map, switch_scfdma1, switch_graph);
s = tx_filter(z, par_tx_w, switch_graph, switch_off_filt);
x = tx_hardware(s, par_txthresh, switch_graph);

