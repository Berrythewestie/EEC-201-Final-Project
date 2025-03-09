close all
clear
clc

% mfcc("GivenSpeech_Data/Training_Data/s1.wav", RunTests = true);
coeffs = mfcc("GivenSpeech_Data/Training_Data/s1.wav");

M = 1;
eps = 0.01;
y = mean(coeffs);

while size(y, 1) < M
    y1 = y * (1 + eps);
    y2 = y * (1 - eps);
    y = [y1 y2];
end

% filename = "GivenSpeech_Data/Training_Data/s1.wav";
% N1 = 256;
% M = 100;
% K = 20;
% 
% [x1, Fs] = audioread(filename);
% L = length(x1);
% x2 = zeros(N1, ceil((L - N1 + 1) / M));
% 
% for i = 1 : size(x2, 2)
%     j = M * (i - 1) + 1;
%     x2(:, i) = x1(j : j + N1 - 1);
% end
% 
% fb = melfb(K, N1, Fs);
% X1 = fft(x2 .* hamming(N1));
% N2 = 1 + floor(N1 / 2);
% X2 = abs(X1(1 : N2, :));
% X3 = fb * X2 .^ 2;
% coeffs = dct(X2);