close all
clear
clc
tic

dataSets = [
    "Original Set"
    "Additional Voices"
    "Notch Filters"
    "Augmented Set"
    "2024 0 Set"
    "2024 12 Set"
    "2024 Full Set"
    "2025 5 Set"
    "2025 11 Set"
];

rng(0)
adjustedIndices = [1 : 4 6 : 19];
randomNumbers = randperm(18);
randomNumbers = adjustedIndices(randomNumbers(1 : 10));
accuracies = zeros(9, 1);
training{1} = "GivenSpeech_Data/Training_Data/s" + (1 : 11) + ".wav";

training{3} = "GivenSpeech_Data/Training_Data/s" + (1 : 11) + ".wav";
training{5} = "2024StudentAudioRecording/Zero-Training/Zero_train" + adjustedIndices + ".wav";
training{4} = [training{5}(randomNumbers) training{1}];
training{6} = "2024StudentAudioRecording/Twelve-Training/Twelve_train" + adjustedIndices + ".wav";
training{7} = [training{5} training{6}];
training{8} = "EEC201AudioRecordings/Five Training/s" + (1 : 23) + ".wav";
training{9} = "EEC201AudioRecordings/Eleven Training/s" + (1 : 23) + ".wav";
testing{1} = "GivenSpeech_Data/Test_Data/s" + (1 : 8) + ".wav";

testing{3} = "MySpeech_Data/NotchTest_Data/s" + (1 : 8) + ".wav";
testing{5} = "2024StudentAudioRecording/Zero-Testing/Zero_test" + adjustedIndices + ".wav";
testing{4} = [testing{5}(randomNumbers) testing{1}];
testing{6} = "2024StudentAudioRecording/Twelve-Testing/Twelve_test" + adjustedIndices + ".wav";
testing{7} = [testing{5} testing{6}];
testing{8} = "EEC201AudioRecordings/Five Test/s" + (1 : 23) + ".wav";
testing{9} = "EEC201AudioRecordings/Eleven Test/s" + (1 : 23) + ".wav";

for i = 1 : 9
    numTrainingFiles = length(training{i});
    numTestingFiles = length(testing{i});
    codebooks = zeros(19, 128, numTrainingFiles);
    id = zeros(1, numTestingFiles);

    for j = 1 : numTrainingFiles
        disp(training{i}(j))
        codebooks(:, :, j) = lbg(mfcc(training{i}(j)));
    end

    for j = 1 : numTestingFiles
        disp(testing{i}(j))
        distances = zeros(1, numTrainingFiles);
        coeffs = mfcc(testing{i}(j));

        for k = 1 : numTrainingFiles
            distances(k) = mean(min(disteu(codebooks(:, :, k), coeffs)));
        end

        [~, id(j)] = min(distances);
    end

    accuracies(i) = 100 * nnz(id == 1 : numTestingFiles) / numTestingFiles;
end

disp(' ')
disp(table(dataSets, accuracies, VariableNames = {'Data Set', 'Accuracy (%)'}))
toc