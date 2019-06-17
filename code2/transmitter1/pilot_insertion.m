function D = pilot_insertion(d, par_N_FFT, par_N_block, switch_graph)

%reshape datastream into a matrix of fft blocks-------
%D = reshape(d, par_N_FFT, par_N_block).';
%-----------------------------------------------------

%pilot: zero mean in time domain, mean power of 1 in time domain--
pilot = 1/2 * repmat([1/sqrt(2)+1/sqrt(2)*1i], 1, par_N_FFT);
%-----------------------------------------------------------------

%prepend pilot----------------------------------------
D = [pilot d];
%-----------------------------------------------------