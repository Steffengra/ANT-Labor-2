function c = channel_coding2(b, par_H, par_N_zeros, switch_off)

if switch_off == 0
    c = [];
    %create generator matrix G from H-------------------------------
    %find parity bit indices
    index_pbit = [];
    for i = 1:length(par_H)
        if sum(par_H(:,i)) == 1 %parity bit columns have just one 1
            index_pbit = cat(2, index_pbit, i); %save indices
        end
    end
    %find data bit indices:
    %remove parity bit indices, data bit indices remain
    index_dbit = 1:7; 
    index_dbit(index_pbit) = []; 
    %create G
    %G has one 1 and three 0 for data bits, so that multiplication only
    %transfers the data bit
    %G has three 1 and one 0 for parity bits, depending on which data bit
    %each parity bit covers
    G = zeros(7, 4);
    for ii = 1:3
        G(index_pbit(ii),:) = par_H(ii, index_dbit);
    end
    for ii = 1:4
        buffer = zeros(1,4);
        buffer(ii) = 1;
        G(index_dbit(ii),:) = buffer;
    end
    %---------------------------------------------------------------
    
    %encode b with G in 4 bit batches-------------------------------
    %encoding is multiplication G*b, modulo 2
    iterations = length(b)/4;
    for ii = 1:iterations
        cur = b(1+(ii-1)*4:4+(ii-1)*4);
        enc = mod(G * cur.', 2);
        c = [c enc.'];
    end
    
    %Zero-pad to ensure correct OFDM frame length if specified
    c = [c zeros(1, par_N_zeros)];
    %---------------------------------------------------------------
else %Case switch_off == 1, no channel coding applied
    c = b;
end