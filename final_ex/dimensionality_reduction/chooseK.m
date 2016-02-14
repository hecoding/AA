function k = chooseK(S, percentage)

Si = 0;
Sn = sum(sum(S, 2));

for i = 1:size(S,1)
  Si += S(i,i);
  if(Si/Sn >= percentage)
    break;
  end
end

k = i;

end
