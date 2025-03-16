function y = lbg(coeffs, M, eps1, eps2)
    arguments
        coeffs
        M = 128
        eps1 = 0.01
        eps2 = 0.01
    end

    y = mean(coeffs, 2);
    m = 1;
    
    while m < M
        y = [y + eps1 y - eps1];
        m = 2 * m;
        D1 = zeros(m, 1);
        [M1, I] = min(disteu(y, coeffs));
        D2 = mean(M1);
    
        while abs((D1 - D2) / D2) >= eps2
            for i = 1 : m
                y(:, i) = mean(coeffs(:, I == i), 2);
            end
    
            D1 = D2;
            [M1, I] = min(disteu(y, coeffs));
            D2 = mean(M1);
        end
    end
end