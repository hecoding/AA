function email_vocab = emailWords(email, vocabulary)
email_vocab = zeros(numfields(vocabulary), 1);

while ~isempty(email)
  [str, email] = strtok(email, [' ']);
  
  if(isfield(vocabulary, str) && ~email_vocab(vocabulary.(str)))
    email_vocab(vocabulary.(str)) = 1;
  end
end

end
