function D = pilot_insertion(d, par_N_FFT, par_N_block, switch_graph)
% implement zero mean pilot

D = reshape(d, par_N_FFT, par_N_block).';
%prepend known pilot
pilot = [];
pilot = repmat(.5 + .5i, 1, par_N_FFT);
D = [pilot; D];