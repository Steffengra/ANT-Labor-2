function z_tilde = rx_filter(s_tilde, par_rx_w, switch_graph, switch_off)

if switch_off == 0
    %filter over the whole band-------------------------
    rp  = (10^(0.01/20) - 1)/(10^(0.01/20) + 1);
    rst = 10^(-sqrt(40)/20);
    H = firgr('minorder', [0 0.001 0.002 0.998 0.999 1], [0 0 1 1 0 0], [rst, rp, rst]);
    z_tilde = filtfilt(H, 1, s_tilde);
    %---------------------------------------------------

    %downsample-----------------------------------------
    H = ones(1, par_rx_w)/sqrt(par_rx_w);
    z_tilde = conv(s_tilde, H);
    z_tilde = z_tilde(par_rx_w:par_rx_w:end);
    %---------------------------------------------------

    %Leistungsnormierung--------------------------------
    z_tilde = z_tilde/sqrt(par_rx_w);
    %---------------------------------------------------
    
elseif switch_off == 1
    z_tilde = s_tilde;
end

if switch_graph == 1
    eyediagram(z_tilde, 2);
end
