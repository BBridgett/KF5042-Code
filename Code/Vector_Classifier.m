%Word Embeddings Sentiment Classifier
idx = ~isVocabularyWord(emb,sents.Vocabulary);
removeWords(sents, idx);

sentimentScore = zeros(size(sents));

for ii = 1 : sents.length 
docwords = sents(ii).Vocabulary;
   vec = word2vec(emb,docwords);
   [~,scores] = predict(model,vec);
   sentimentScore(ii) = mean(scores(:,1));
   
    if (sentimentScore(ii)>=1)
        sentimentScore(ii)=1;
    elseif (sentimentScore(ii)<=-1)
        sentimentScore(ii) = -1;
    end
    fprintf('Sent: %d, words: %s, FoundScore: %d, GoldScore: %d\n', ii, joinWords(sents(ii)), sentimentScore(ii), actualScore(ii));
end

ZeroVal = sum(sentimentScore == 0);
covered = numel(sentimentScore) - ZeroVal;
tp = sentimentScore((sentimentScore>0) & ( actualScore==1));
tn = sentimentScore((sentimentScore<0) &( actualScore == 0));
fprintf("Total of positive and negative classes: %2.2f%%, Distinct %d, NotFound or Neutral: %d\n", (covered * 100)/numel(sentimentScore), covered, ZeroVal);

acc = (numel(tp) + numel(tn))*100/covered;
fprintf("Accuracy: %2.2f%%, TP: %d, TN: %d\n", acc, numel(tp), numel(tn));
figure
confusionchart(actualScore, sentimentScore);