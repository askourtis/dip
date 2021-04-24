function saveasppm(x, filename , K)
% Saves the given image as a ppm file
%
% Parameters:
%   x        - The image           [Array NxKx3]
%   filename - The filename        [String]
%   K        - Quantization levels [Scalar]

%% Checks
assert(ndims(x) == 3, "x does not have 3 dimensions")
assert(size(x,3) == 3, "x is not an image array (last dim is not 3)")
assert(isnumeric(x), "x is not numeric")

assert(isstring(filename), "filename is not a string")

assert(isnumeric(K), "K is not numeric")
assert(isscalar(K), "K is not scalar")
assert(K == floor(K), "K is not an integer")
assert(K > 0, "K is not positive")


%% Code
% Permute so that after dimension removal the resulting vector will be
% formated as RGBRGBRGB...
q = permute(x, [3 2 1]);
% Remove dimensions
q = q(:);


% Open file in write mode
file = fopen(filename, 'w');

% Write header
fprintf(file, "P6 %d %d %d ", size(x,2), size(x,1), K);

if K > 255
    % If quantization levels are more than 256 then 2 bytes are needed for
    % each color writen as big-endian
    fwrite(file, q, 'uint16', 'ieee-be');
else
    % Trivial case one byte per color
    fwrite(file, q, 'uint8');
end

% Release resources
fclose(file);

end

