function D_tilde = ofdm_demod(z_tilde, par_N_FFT, par_N_CP, switch_map, switch_scfdma, switch_graph)

%reshape to par_N_FFT x par_N_block Matrix (+CP)---------------------
z_tilde = reshape(z_tilde, par_N_FFT + par_N_CP, length(z_tilde)/(par_N_FFT + par_N_CP)).';
%--------------------------------------------------------------------
%remove cyclic prefix------------------------------------------------
z_tilde = z_tilde(:, par_N_CP+1:end);
%--------------------------------------------------------------------
%demodulate ofdm symbols---------------------------------------------
d_tilde = 1/sqrt(par_N_FFT) * fft(z_tilde, par_N_FFT, 2);
%--------------------------------------------------------------------
%sort users----------------------------------------------------------
if switch_map == 0 %block coding
    buffer = d_tilde(:, 1:par_N_FFT/2);
    [n, m] = size(buffer);
    D_tilde(1, :) = reshape(buffer.', 1, n*m);
    buffer = d_tilde(:, par_N_FFT/2+1:end);
    [n, m] = size(buffer);
    D_tilde(2, :) = reshape(buffer.', 1, n*m);
elseif switch_map == 1 %alternating coding
    buffer = d_tilde(:, 1:2:end);
    [n, m] = size(buffer);
    D_tilde(1, :) = reshape(buffer.', 1, n*m);
    buffer = d_tilde(:, 2:2:end);
    [n, m] = size(buffer);
    D_tilde(2, :) = reshape(buffer.', 1, n*m);
else
    print('invalid switch_map');
end
%demodulate precoding of user2---------------------------------------
%buffer = D_tilde(2, par_N_FFT/2+1:end);
%buffer2 = [];
%for ii = 1:length(buffer)/(par_N_FFT/2)
%    buffer2 = [buffer2 ifft(buffer(1+(ii-1)*par_N_FFT/2:par_N_FFT/2+(ii-1)*par_N_FFT/2), par_N_FFT/2)];
%end
%D_tilde(2,par_N_FFT/2+1:end) = buffer2;
%--------------------------------------------------------------------
%--------------------------------------------------------------------
if switch_graph == 1
    figure; 
    scatter(real(d_tilde(1,:)), imag(d_tilde(1,:)), 36, 1/255 * [33 70 122]);
    title('rx: OFDM Symbolspace');
    ylabel('Magnitude');
    grid;
end