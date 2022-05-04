%Ensemble Sentiment Classifier
%filename = "yelp_labelled.txt";
filename = "Star_Wars_Tweets.txt";
%filename = "imdb_labelled_2.txt";
%filename= "amazon_cells_labelled.txt";

dataReviews = readtable(filename,'TextType','string');
textData = dataReviews.review;
actualScore = dataReviews.score;
sents = preprocessReviews(textData);
fprintf('File: %s, Sentences: %d \n', filename, size(sents));

sentimentScore = zeros(size(sents));


for ii = 1 : sents.length
    docwords = sents(ii).Vocabulary;
    for jj = 1 : length(docwords)
        if words_hash.containsKey(docwords(jj))
            sentimentScore(ii) = sentimentScore(ii) + words_hash.get(docwords(jj));
        end
    end
    if sentimentScore(ii) == 0
        vec = word2vec(emb,docwords);
        [~,scores] = predict(model,vec);
        sentimentScore(ii) = mean(scores(:,1));
        if isnan(sentimentScore(ii))
            sentimentScore(ii) = 0;
        end
    end
    

    % if tokens were found by either classifier
    if sentimentScore(ii) ~= 0
        fprintf('+++Sent: %d, words: %s, FoundScore: %d, GoldScore: %d\n', ii, joinWords(sents(ii)), sentimentScore(ii), actualScore(ii));
    else
        fprintf('---Sent: %d, words: %s, Not Covered, GoldScore: %d\n', ii, joinWords(sents(ii)), actualScore(ii));
    end
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