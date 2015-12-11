function X = parseEmail(directory, email_size)

if(exist(strcat(directory, '_data.mat')))
  load(strcat(directory, '_data.mat'));
  X = eval(strcat('X', directory));
  disp(strcat(directory, ' already computed, loading...'));
  return;
else
  if(exist(directory) != 7)
    disp(cstrcat('error: ', directory, ' directory does not exist.'));
    X = [];
    return;
  end
end

vocabList = getVocabList();
for i = 1:length(vocabList)
  vocabulary.( vocabList{i} ) = i;
end

X = zeros(numfields(vocabulary), email_size);

for i = 1:email_size
  file_name = sprintf("%s/%04d.txt", directory, i);
  file_contents = readFile(file_name);
  email = processEmail(file_contents);

  
  X(:, i) = emailWords(email, vocabulary);
  i
end

end
