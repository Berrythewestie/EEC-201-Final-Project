function [C, S] = mfcc(filename, N1, M, K, NameValueArgs)
    arguments
        filename
        N1 = 256
        M = 100
        K = 20
        NameValueArgs.RunTests = false
    end
    
    [x1, Fs] = audioread(filename);
    x1 = x1(:, 1);
    L = length(x1);
    x2 = zeros(N1, ceil((L - N1 + 1) / M));

    for i = 1 : size(x2, 2)
        j = M * (i - 1) + 1;
        x2(:, i) = x1(j : j + N1 - 1);
    end

    fb = melfb(K, N1, Fs);
    X = fft(x2 .* hamming(N1));
    N2 = floor(N1 / 2) + 1;
    pxx = abs(X(1 : N2, :)) .^ 2;
    S = fb * pxx;
    C = dct(S(2 : end, :));

    if NameValueArgs.RunTests
        nexttile
        plot((1 : L) / Fs, x1)
        axis tight
        xlabel("Time (s)")
        ylabel("Amplitude")
        title("Time-Domain Signal")

        for i = 2 .^ (7 : 9)
            nexttile
            stft(x1, Fs, Window = hamming(i), ...
                OverlapLength = round(2 * i / 3));
        end

        nexttile
        plot(linspace(0, Fs / 2, N2), fb'),
        title("Mel-Spaced Filterbank")
        xlabel("Frequency (Hz)");

        nexttile
        plot(linspace(0, Fs / 2, N2), mag2db(mean(pxx, 2)));
        xlabel("Frequency (Hz)")
        ylabel("Power/Frequency (dB/Hz)")
        title("PSD")

        nexttile
        plot(linspace(0, Fs / 2, K), mag2db(mean(S, 2)));
        xlabel("Frequency (Hz)")
        ylabel("Power/Frequency (dB/Hz)")
        title("Mel-Scale PSD")
    end
end