function z = tx_ofdm_mod(D, par_N_FFT, par_N_CP, switch_graph)
%allowed to use ifft?
%ofdm------------------------------------------
z = ifft(D, par_N_FFT, 2); %2 = each row
%----------------------------------------------
%cyclic prefix---------------------------------
if par_N_CP > 0
    z = [z(:, end-(par_N_CP-1):end) z];
end
%----------------------------------------------
%refactor--------------------------------------
[m, n] = size(D);
n = n + par_N_CP;
z = reshape(z.', 1, m*n);
%----------------------------------------------

if switch_graph == 1
    
end