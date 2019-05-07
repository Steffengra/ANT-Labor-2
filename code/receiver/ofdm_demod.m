function d_tilde = ofdm_demod(z_tilde, par_N_FFT, par_N_CP, switch_graph)

%reshape to par_N_FFT x par_N_block Matrix (+CP)---------------------
z_tilde = reshape(z_tilde, par_N_FFT + par_N_CP, length(z_tilde)/(par_N_FFT + par_N_CP)).';
%--------------------------------------------------------------------
%remove cyclic prefix------------------------------------------------
z_tilde = z_tilde(:, par_N_CP+1:end);
%--------------------------------------------------------------------
%demodulate ofdm symbols---------------------------------------------
d_tilde = fft(z_tilde, par_N_FFT, 2);
%--------------------------------------------------------------------


% [m, n] = size(d_tilde);
% d_tilde = reshape(d_tilde.', 1, m*n);