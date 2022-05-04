ZeroVal = sum(sentimentScore == 0);
covered = numel(sentimentScore) - ZeroVal;
tp = sentimentScore((sentimentScore>0) & ( actualScore==1));
tn = sentimentScore((sentimentScore<0) &( actualScore == 0));
fprintf("Total of positive and negative classes: %2.2f%%, Distinct %d, NotFound or Neutral: %d\n", (covered * 100)/numel(sentimentScore), covered, ZeroVal);

acc = (numel(tp) + numel(tn))*100/covered;
fprintf("Accuracy: %2.2f%%, TP: %d, TN: %d\n", acc, numel(tp), numel(tn));
%figure
%confusionchart(actualScore, sentimentScore);