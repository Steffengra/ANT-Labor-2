function d_bar = equalizer(d_tilde, switch_mod, switch_graph)

pilot = repmat([1/sqrt(2)+1/sqrt(2)*i -1/sqrt(2)-1/sqrt(2)*i], 1, length(d_tilde)/2);
H = pilot ./ d_tilde(1, :);

d_bar = d_tilde(2:end, :); %remove pilot
d_bar = d_bar .* H; %equalizing

[m, n] = size(d_bar);
d_bar = reshape(d_bar.', 1, m*n);