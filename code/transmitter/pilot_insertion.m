function D = pilot_insertion(d, par_N_FFT, par_N_block, switch_graph)
% implement zero mean pilot

D = reshape(d, par_N_FFT, par_N_block).';
%prepend known pilot
pilot = [];
pilot = repmat([1/sqrt(2)+1/sqrt(2)*i -1/sqrt(2)-1/sqrt(2)*i], 1, par_N_FFT/2);
D = [pilot; D];