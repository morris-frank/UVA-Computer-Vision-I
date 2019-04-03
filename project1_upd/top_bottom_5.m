
function [top5, bot5] = top_bottom_5(score)

s = sort(score(:, 1));
%indexes of top 5
top5 = find(score(:, 1) <= s(5));

s = score(:, 1);
s= s(s < 0);
s = sort(s, 'descend');
s(5)

bot5 = find(score(:, 1) >= s(5) & score(:, 1) <= 0);

end