function d = modulation(c, switch_mod, switch_graph)
%modulation(reshape(de2bi(0:63).', 1, 6*64), 2, 1);
bits_per_symbol = 2*switch_mod + 2;
starting_position = -(2^(switch_mod+1) - 1);
step = 2;
iterations = floor( length(c) / bits_per_symbol );
normfactor = sqrt( 2/3 * (2^(2*switch_mod+2) - 1) );

d = [];

for ii = 1:iterations
    cur = c(1+bits_per_symbol*(ii-1):bits_per_symbol+bits_per_symbol*(ii-1));
    %find horizontal position using the first half of bits
    %convert gray to binary
    re = cur(1);
    for jj = 2:bits_per_symbol/2
        if cur(jj) == 0
            re = [re re(end)];
        else
            re = [re not(re(end))];
        end
    end
    re = starting_position + bi2de(flip(re)) * step;
    %find vertical position using the last half of bits
    %convert gray to binary
    im = cur(bits_per_symbol/2 + 1);
    for jj = (bits_per_symbol/2 + 2):bits_per_symbol
        if cur(jj) == 0
            im = [im im(end)];
        else
            im = [im not(im(end))];
        end
    end
    im = starting_position + bi2de(flip(im)) * step;
    d = [d re + 1i*im];
end
%normalize d--------------------------------------
d = d / normfactor;
%-------------------------------------------------

if switch_graph == 1
    figure;
    scatter(real(d), imag(d), 36, 1/255 * [33 70 122]);
    grid;
    ylim([starting_position-1 -starting_position+1] / normfactor);
    xlim([starting_position-1 -starting_position+1] / normfactor);
    ylabel('Im');
    xlabel('Re');
    title('Modulated Symbols - Tx');
end

