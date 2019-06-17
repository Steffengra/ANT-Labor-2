function s = tx_filter(z, par_tx_w, switch_graph, switch_off)
%https://www.mathworks.com/help/comm/examples/f-ofdm-vs-ofdm-modulation.html
if switch_off == 0
    %upsample-------------------------------------
    z_upsampled = z;
    for ii = length(z):-1:1
        z_upsampled = [z_upsampled(1:ii) zeros(1,par_tx_w-1) z_upsampled(ii+1:end)];
    end
    H = ones(1, par_tx_w);
    s = conv(z_upsampled, H)/sqrt(par_tx_w);
    s = s(1:end-(par_tx_w-1));
    %---------------------------------------------

    %filter over the whole band-------------------
    rp  = (10^(0.01/20) - 1)/(10^(0.01/20) + 1);
    rst = 10^(-sqrt(40)/20);
    H = firgr('minorder', [0 0.001 0.002 0.998 0.999 1], [0 0 1 1 0 0], [rst, rp, rst]);
    s = filtfilt(H, 1, s);
    %---------------------------------------------
    
    %Leistungsnormierung--------------------------
    s = sqrt(par_tx_w) * s;
    %---------------------------------------------
    
elseif switch_off == 1
    s = z;
end

if switch_graph == 1
    figure;
    plot(abs(s), 'color', 1/255 * [33 70 122]);
    title('tx: Filter Output');
    ylabel('Magnitude');
end
