function c_hat = demodulation(d_bar, switch_mod, switch_graph)
    function det_bits = determine_bits(symbol, boundaries, bits_per_symbol)
        det_bits = [];
        num_steps = [];
        boundaries_flip = flip(boundaries);
        for jj = 1:length(boundaries) %iterate through decision boundaries
            if symbol > boundaries_flip(jj)
                num_steps = flip( de2bi( find(boundaries==boundaries_flip(jj)), bits_per_symbol/2 ));
                break;
            end
        end
        if isempty(num_steps)
            num_steps = flip( de2bi( 0, bits_per_symbol/2 ));
        end
        %convert bin to gray
        det_bits = [det_bits num_steps(1)];
        for jj = 2:bits_per_symbol/2
            det_bits = [det_bits xor(num_steps(jj), num_steps(jj-1))];
        end
    end

bits_per_symbol = 2*switch_mod + 2;
normfactor = 2/3 * (2^(2*switch_mod+2) - 1);
starting_position = -(2^(switch_mod+1) - 1); %-1, -3 or -7 for 4QAM, 16QAM, 64QAM
step = 2;
boundaries = starting_position+1:step:-starting_position;
boundaries = boundaries / normfactor;
iterations = length(d_bar);

c_hat = [];
for ii = 1:iterations
    cur = d_bar(ii);
    %find first bits_per_symbol/2 bits from real part
    bits = determine_bits(real(cur), boundaries, bits_per_symbol);
    c_hat = [c_hat bits];
    %find last bits_per_symbol/2 bits from imag part
    bits = determine_bits(imag(cur), boundaries, bits_per_symbol);
    c_hat = [c_hat bits];
end

if switch_graph == 1
    figure;
    scatter(real(d_bar), imag(d_bar), 36, 1/255 * [33 70 122]);
    grid;
    ylim([starting_position-1 -starting_position+1] / normfactor);
    xlim([starting_position-1 -starting_position+1] / normfactor);
    for ii = 1:length(boundaries)
        h = refline(0, boundaries(ii));
        v = line([boundaries(ii) boundaries(ii)], [starting_position-1 -starting_position+1]);
        h.Color = 'k';
        v.Color = 'k';
    end
    ylabel('Im');
    xlabel('Re');
    title('Modulated Symbols - Rx');
end
end