function d_bar = equalizer(d_tilde, switch_mod, switch_graph)
% which equalizer

H = d_tilde(1,:) / (.5 + .5i); %determine channel coefficient H
d_bar = d_tilde(2:end, :); %remove pilot
d_bar = d_bar .* H; %equalizing

[m, n] = size(d_bar);
d_bar = reshape(d_bar.', 1, m*n);