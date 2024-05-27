% Specify the path to your input images and output directory
inputDir = 'F:\Cooprations\ECG-ID database\Reject';
outputDir = 'F:\Cooprations\ECG-ID database\Reject';

% List all image files in the input directory
imageFiles = dir(fullfile(inputDir, '*.png')); % Update the extension if needed

% Augmentation parameters
rotationAngles = [-15, 0, 15]; % Rotation angles in degrees
flipDirections = {'horizontal', 'vertical'}; % Flip directions
resizeFactors = [0.8, 1.0, 1.2]; % Resize factors

% Loop through each image and apply augmentations
for i = 1:length(imageFiles)
    % Load the original image
    imagePath = fullfile(inputDir, imageFiles(i).name);
    originalImage = imread(imagePath);

    % Apply rotation augmentation
    for angle = rotationAngles
        rotatedImage = imrotate(originalImage, angle, 'crop');
        outputFilename = sprintf('rotated_%d_%s', angle, imageFiles(i).name);
        imwrite(rotatedImage, fullfile(outputDir, outputFilename));
    end

    % Apply flipping augmentation
for direction = flipDirections
    if strcmp(direction, 'horizontal')
        flippedImage = flip(originalImage, 2); % Flip horizontally along dimension 2 (width)
    elseif strcmp(direction, 'vertical')
        flippedImage = flip(originalImage, 1); % Flip vertically along dimension 1 (height)
    end
    
    outputFilename = sprintf('flipped_%s_%s', direction{:}, imageFiles(i).name);
    imwrite(flippedImage, fullfile(outputDir, outputFilename));
end
    % Apply resizing augmentation
    for factor = resizeFactors
        resizedImage = imresize(originalImage, factor);
        outputFilename = sprintf('resized_%.1f_%s', factor, imageFiles(i).name);
        imwrite(resizedImage, fullfile(outputDir, outputFilename));
    end
end
