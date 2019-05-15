function z_tilde = rx_filter(s_tilde, par_rx_w, switch_graph, switch_off)

%filter over the whole band
rp  = (10^(0.01/20) - 1)/(10^(0.01/20) + 1);
rst = 10^(-sqrt(40)/20);
H = firgr('minorder', [0 0.001 0.002 0.998 0.999 1], [0 0 1 1 0 0], [rst, rp, rst]);
z_tilde = filtfilt(H, 1, s_tilde);

H = ones(1, par_rx_w)/sqrt(par_rx_w);
z_tilde = conv(s_tilde, H);


%downsample
z_tilde = z_tilde(par_rx_w:par_rx_w:end);
