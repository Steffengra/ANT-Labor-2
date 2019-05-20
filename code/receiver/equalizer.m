function d_bar = equalizer(d_tilde, switch_mod, switch_graph)

%find H_inv-------------------------------------
pilot = repmat([1/sqrt(2)+1/sqrt(2)*1i -1/sqrt(2)-1/sqrt(2)*1i], 1, length(d_tilde)/2);
H_inv = pilot ./ d_tilde(1, :);
%-----------------------------------------------

d_bar = d_tilde(2:end, :);  %remove pilot
d_bar = d_bar .* H_inv;     %equalize

%reshape d_bar into matrix of fft blocks--------
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