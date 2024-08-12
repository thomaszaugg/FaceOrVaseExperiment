% Modify a picture

% Define the variables
a = 0; % Value to find and replace with b
b = 60; % New value to set for pixels with value a
c = 255; % Value to find and replace with d
d = 180; % New value to set for pixels with value c

% Load an image from file
imagePath = 'Rubin_bicolor.png';
if exist(imagePath, 'file') ~= 2
    error('Image file does not exist.');
end
grayImage = imread(imagePath);

% Check if the image is RGB and convert to grayscale if needed
if size(grayImage, 3) == 3
    grayImage = rgb2gray(grayImage);
end

% Display the original grayscale image
figure;
imshow(grayImage);
title('Original Grayscale Image');

% Create a copy of the image to modify
modifiedImage = grayImage;

% Set all pixels with value a to b
modifiedImage(grayImage == a) = b;

% Set all pixels with value c to d
modifiedImage(grayImage == c) = d;

% Display the modified image
figure;
imshow(modifiedImage);
title(['Modified Image (', num2str(a), ' -> ', num2str(b), ', ', num2str(c), ' -> ', num2str(d), ')']);

% Create a string from the variables and add '.png' at the end
filename = [num2str(b) '_' num2str(d) '.png'];
disp(['Saving the modified image as ' filename]);

% Save the modified image to a file
imwrite(modifiedImage, filename);

disp('Modified image saved successfully.');
