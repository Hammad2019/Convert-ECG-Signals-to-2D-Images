ECG Image Augmentation and Signal Processing

This repository contains MATLAB scripts for augmenting ECG images and processing ECG signals. The image augmentation script performs various transformations such as rotation, flipping, and resizing, while the signal processing script loads and processes ECG signals from .mat files.
Files

    image_augmentation.m: MATLAB script for augmenting ECG images.
    signal_processing.m: MATLAB script for loading and processing ECG signals.

Prerequisites

    MATLAB (a product of The MathWorks, Inc.)
    The Image Processing Toolbox (for image augmentations).

Usage
Image Augmentation Script

The image_augmentation.m script performs the following tasks:

    Reads ECG images from the specified input directory.
    Applies rotation, flipping, and resizing augmentations.
    Saves the augmented images to the specified output directory.

Parameters

    inputDir: Path to the directory containing the input images.
    outputDir: Path to the directory where the augmented images will be saved.
    rotationAngles: Array of rotation angles in degrees.
    flipDirections: Cell array of flip directions ('horizontal', 'vertical').
    resizeFactors: Array of resize factors.

Example

matlab

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
            flippedImage = flip(originalImage, 2); % Flip horizontally
        elseif strcmp(direction, 'vertical')
            flippedImage = flip(originalImage, 1); % Flip vertically
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

Signal Processing Script

The signal_processing.m script performs the following tasks:

    Loads ECG signals from .mat files.
    Extracts and processes a specific segment of each signal.
    Plots the processed signal and saves the plot as a PNG image.

Example

matlab

clc;
clear;
close all;

% Load signals
for i = 1:243
    load(strcat('1 (', num2str(i), ').mat'));
    y1 = val(1,:); % The vector in the mat file
    f = 1000;
    T = 1/f;
    N = length(y1);
    ls = size(y1);
    t = (0 : N-1) / f;
    y1new = y1(8001:10000);
    t2 = (0 : length(y1new) - 1) / f;
    fig = figure;
    plot(y1new);
    axis off;
    print(fig, num2str(i), '-dpng');
end

close all;
