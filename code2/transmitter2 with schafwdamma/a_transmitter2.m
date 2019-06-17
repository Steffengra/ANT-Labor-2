par_userid = 2;

b = digital_source2(par_no / 2, switch_graph);
c = channel_coding2(b, par_H, par_N_zeros, switch_off_cc);
d = modulation2(c, switch_mod, switch_graph);
D = pilot_insertion2(d, par_N_FFT, par_N_block / 2, switch_graph);
z = tx_ofdm_mod2(D, par_N_FFT, par_N_CP, par_userid, switch_map, switch_scfdma2, switch_graph);
s = tx_filter2(z, par_tx_w, switch_graph, switch_off_filt);
x = tx_hardware2(s, par_txthresh, switch_graph);