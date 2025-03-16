close all
clear
clc

speaker1 = "GivenSpeech_Data/Training_Data/s2.wav";
speaker2 = "GivenSpeech_Data/Training_Data/s10.wav";

coeffs1 = mfcc(speaker1, RunTests = true);

coeffs2 = mfcc(speaker2);

nexttile
hold on
scatter(coeffs1(6, :), coeffs1(7, :), 'x')
scatter(coeffs2(6, :), coeffs2(7, :))
xlabel("mfcc-6")
ylabel("mfcc-7")
legend("Speaker 2", "Speaker 10")
title("MFCC Space")

codebook1 = lbg(coeffs1, 8);
codebook2 = lbg(coeffs2, 8);

nexttile
hold on

scatter1 = scatter(coeffs1(6, :), coeffs1(7, :), 'x');
scatter2 = scatter(coeffs2(6, :), coeffs2(7, :));
scatter3 = scatter(codebook1(6, :), codebook1(7, :), 'x');
scatter4 = scatter(codebook2(6, :), codebook2(7, :));
scatter1.MarkerEdgeAlpha = .5;
scatter2.MarkerEdgeAlpha = .5;
scatter3.LineWidth = 2;
scatter4.LineWidth = 2;
xlabel("mfcc-6")
ylabel("mfcc-7")
legend("", "", "Speaker 2", "Speaker 10")
title("MFCC Space")