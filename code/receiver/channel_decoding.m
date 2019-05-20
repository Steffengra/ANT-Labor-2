function b_hat = channel_decoding(c_hat, par_H, par_N_zeros, switch_off)

b_hat = [];
if switch_off == 0
    iterations = length(c_hat) / 7;
    %create decoder matrix R-------------
    %find parity bit indices
    index_pbit = [];
    for i = 1:length(par_H)
        if sum(par_H(:,i)) == 1
            index_pbit = cat(2, index_pbit, i);
        end
    end
    %find data bit indices
    index_dbit = 1:7;
    index_dbit(index_pbit) = [];

    R = zeros(4, 7);
    for i = 1:4
        R(i, index_dbit(i)) = 1;
    end
    %-------------------------------------
    for ii = 1:iterations
        cur = c_hat(1+7*(ii-1):7+7*(ii-1));
        %error correction--------------------
        syndrome = mod(par_H * cur.', 2);
        if not(isequal(syndrome, [0 0 0]'))     % if error:
            cur(bi2de(syndrome')) = not(cur(bi2de(syndrome'))); % flip bit if error at position
        end
        %------------------------------------
        b_hat = [b_hat (cur*R.')];
    end
    
else
    b_hat = c_hat;
end