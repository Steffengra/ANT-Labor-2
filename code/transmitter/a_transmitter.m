par_N_block = 3;
par_no = par_N_block*1024*(2*switch_mod + 2) * (1 + not(switch_off)*3);
par_N_block = par_N_block * ( 1 + 6 * not(switch_off) );
%------------------------------------------------------------------------

b = digital_source(par_no, switch_graph);
c = channel_coding(b, par_H, par_N_zeros, switch_off);
d = modulation(c, switch_mod, switch_graph);
D = pilot_insertion(d, par_N_FFT, par_N_block, switch_graph);
z = tx_ofdm_mod(D, par_N_FFT, par_N_CP, switch_graph);
s = tx_filter(z, par_tx_w, switch_graph, switch_off);
%s = z;
x = tx_hardware(s, par_txthresh, switch_graph);
y = Channel(x.', par_SNRdB, par_channel);
y = y.'; 
if par_channel == 'FSBF' %cut off extra symbols
    y = y(1:length(x));
end
