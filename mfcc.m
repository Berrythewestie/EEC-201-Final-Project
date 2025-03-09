function coeffs = mfcc(filename, N1, M, K, NameValueArgs)
    arguments
        filename
        N1 = 256
        M = 100
        K = 20
        NameValueArgs.RunTests = false
    end
    
    [x1, Fs] = audioread(filename);
    L = length(x1);
    x2 = zeros(N1, ceil((L - N1 + 1) / M));

    for i = 1 : size(x2, 2)
        j = M * (i - 1) + 1;
        x2(:, i) = x1(j : j + N1 - 1);
    end

    fb = melfb(K, N1, Fs);
    X1 = fft(x2 .* hamming(N1));
    N2 = 1 + floor(N1 / 2);
    X2 = abs(X1(1 : N2, :));
    S = fb * X2 .^ 2;
    C = dct(S);
    coeffs = C(2 : end, :);

    if NameValueArgs.RunTests
        figure
        nexttile
        plot(1 : L, x1)
        title("TEST 2")
    
        for i = 2 .^ (7 : 9)
            nexttile
            stft(x1, Fs, Window = hamming(i), ...
                OverlapLength = round(2 * i / 3));
        end
    
        nexttile
        plot(linspace(0, Fs / 2, N2), fb'),
        title("Mel-spaced filterbank")
        xlabel("Frequency (Hz)");
    
        nexttile
        plot(1 : N2, X2);
    
        nexttile
        plot(1 : N2, S);
    end
end