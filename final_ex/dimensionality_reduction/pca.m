function [U S V] = pca(X)
%Each column must be an example

% skip if variables already in memory
if ((exist('U', 'var') != 1) || (exist('S', 'var') != 1) || (exist('V', 'var') != 1))
  % if not in memory check if the data has been computed before
  if(exist('svd.mat', 'file') == 2)
    load('svd.mat');
  else
    m = size(X, 2);
    
    sigma = X * X' / m;
    [U S V] = svd(sigma);
    
    save svd.mat U S V;
  end
end

end
