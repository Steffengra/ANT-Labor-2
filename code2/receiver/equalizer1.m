function d_bar = equalizer1(d_tilde, switch_mod, switch_graph)
%reshape into fft/2 blocks------------------------
d_tilde = reshape(d_tilde, 1024/2, length(d_tilde)/(1024/2)).';
%-------------------------------------------------

%find H_inv-------------------------------------
pilot = repmat([1/sqrt(2)+1/sqrt(2)*1i], 1, length(d_tilde));
H_inv = pilot ./ d_tilde(1, :);
%-----------------------------------------------

d_bar = d_tilde(2:end, :);  %remove pilot
d_bar = d_bar .* H_inv;     %equalize


%reshape d_bar into row-------------------------
[m, n] = size(d_bar);
d_bar = reshape(d_bar.', 1, m*n);
%-----------------------------------------------


if switch_graph == 1
    figure; 
    scatter(real(d_bar), imag(d_bar), 36, 1/255 * [33 70 122]);
    title('rx: Symbolspace after equalization');
    ylabel('Magnitude');
    grid;
end