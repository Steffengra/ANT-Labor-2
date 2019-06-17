function z = tx_ofdm_mod2(D, par_N_FFT, par_N_CP, par_userid, switch_map, switch_scfdma, switch_graph)
buffer = D(par_N_FFT+1:end);
%dft precoding-------------------------------------
if switch_scfdma == 1
    buffer2 = [];
    for ii = 1:length(buffer)/(par_N_FFT/2)
        buffer2 = [buffer2 fft(buffer(1+(ii-1)*par_N_FFT/2:par_N_FFT/2+(ii-1)*par_N_FFT/2), par_N_FFT/2)];
    end
    buffer = buffer2;
end
%--------------------------------------------------
%insert zeros--------------------------------------
if switch_map == 0  %block coding
    for ii = length(buffer):-par_N_FFT/2:1
        buffer = [buffer(1:ii) zeros(1, par_N_FFT/2) buffer(ii+1:end)];
    end
    buffer = [zeros(1, (par_userid-1)*par_N_FFT/2) buffer(1:end-(par_userid-1)*par_N_FFT/2)];
elseif switch_map == 1 %alternating coding
    for ii = length(buffer):-1:1
        buffer = [buffer(1:ii) zeros(1, 2-1) buffer(ii+1:end)];
    end
    buffer = [zeros(1, par_userid-1) buffer(1:end-(par_userid-1))];
else
    print('invalid switch_map');
end
%--------------------------------------------------
%reshape datastream into a matrix of fft blocks-------
buffer = reshape(buffer, par_N_FFT, length(buffer)/par_N_FFT).';
buffer = [D(1:par_N_FFT); buffer]; %reinsert pilot
%-----------------------------------------------------
%ofdm------------------------------------------
z = sqrt(par_N_FFT) * ifft(buffer, par_N_FFT, 2); %2 = each row
%----------------------------------------------
%cyclic prefix---------------------------------
if par_N_CP > 0
    z = [z(:, end-(par_N_CP-1):end) z];
end
%----------------------------------------------
%refactor--------------------------------------
[m, n] = size(buffer);
n = n + par_N_CP;
z = reshape(z.', 1, m*n);
%----------------------------------------------

if switch_graph == 1
    figure; 
    plot(abs(z), 'color', 1/255 * [33 70 122]);
    title('tx: OFDM symbol in time domain');
    ylabel('Magnitude');
    figure;
    periodogram(z);
end