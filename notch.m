if ~exist("MySpeech_Data/NotchTest_Data", "dir")
    mkdir MySpeech_Data/NotchTest_Data
end

for i = 1 : 8
    [x, Fs] = audioread(sprintf("GivenSpeech_Data/Test_Data/s%d.wav", i));
    [~, S] = mfcc(sprintf("GivenSpeech_Data/Test_Data/s%d.wav", i));
    [~, I] = max(mean(S, 2));
    L = size(x, 1);
    k = floor(L / 40);
    H1 = ones(L / 2, 1);
    H1(k * max(0, I - 2) + 1 : k * min(20, I + 2)) = 0;
    H2 = [H1; flip(H1)];
    y = real(ifft(fft(x) .* H2));
    audiowrite(sprintf("MySpeech_Data/NotchTest_Data/s%d.wav", i), y, Fs);
end