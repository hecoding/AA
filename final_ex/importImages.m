function [X Y] = importImages(path, attributes)
%This function reads all the images into 'path' and successively concatenates
% them as a column vector in the X matrix. The values of this matrix
% are between 0 and 1.
% It also use 'attributes' to parse the name of the image to build Y, the matrix
% of y's. The argument 'attributes' must be a cell array.
% The y's are in the same order as the attributes given.
%
% All the images in the directory of 'path' are supposed to be grayscaled and
% of the same size.
%

filelist = readdir (path);
num_images = numel(filelist) - 2; % It takes 2 for . and ..
oldpwd = cd (path);
sample = imread(filelist{3}); % skip . and .. and take the first image

% Allocate space to store the images column-wise
X = zeros(size(sample,1) * size(sample,2), num_images);
Y = zeros(num_images, length(attributes));

for i = 1:num_images % skip special files . and ..

  % save image as a column vector
  image_name = filelist{i + 2};
  image = imread(image_name);
  X(:,i) = reshape(image, size(image, 1) * size(image, 2), 1);
  
  % for every attribute, search it and save 1 if found
  for j = 1:length(attributes)
    pattern = strcat('^.*_', attributes{j}, '_.*$'); % look for _attribute_
    if (regexp(image_name, pattern))
      Y(i,j) = 1;
    else
      Y(i,j) = 0;
    end
  end
  
end

X = X / 255;
cd (oldpwd);

end