function y = lbg(coeffs, M, eps)
    y = mean(coeffs);

    while size(y, 2) < M
        y = [y + eps; y - eps];
        new_codebook = y;

        while disteu(y, new_codebook) < eps
            assignments = assign_vectors_to_codebook(coeffs, y);
            y = update_codebook(coeffs, assignments, size(y, 2));
        end
    end
end

function assignments = assign_vectors_to_codebook(training_vectors, codebook)
    num_vectors = size(training_vectors, 1);
    num_codewords = size(codebook, 1);
    assignments = zeros(num_vectors, 1);
    
    for i = 1:num_vectors
        distances = sum((training_vectors(i, :) - codebook).^2, 2);
        [~, idx] = min(distances);
        assignments(i) = idx;
    end
end

function new_codebook = update_codebook(training_vectors, assignments, num_codewords)
    new_codebook = zeros(num_codewords, size(training_vectors, 2));

    for i = 1:num_codewords
        assigned_vectors = training_vectors(assignments == i, :);
        if ~isempty(assigned_vectors)
            new_codebook(i, :) = mean(assigned_vectors, 1);
        else
            new_codebook(i, :) = zeros(1, size(training_vectors, 2));
        end
    end
end