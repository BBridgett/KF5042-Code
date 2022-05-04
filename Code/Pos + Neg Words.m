%Open the word dataset
fidPositive = fopen(fullfile('opinion-lexicon-English','positive-words.txt'));
C = textscan(fidPositive,'%s','CommentStyle',';');
wordsPositive = string(C{1});
fclose all;

%Create the hash table
words_hash = java.util.Hashtable;

%Placing the positive words in the table
[possize, ~] = size(wordsPositive);
for ii = 1:possize
    words_hash.put(wordsPositive(ii,1),1);
end


%Repeat for Negative Dataset
fidNegative = fopen(fullfile('opinion-lexicon-English','negative-words.txt'));
C2 = textscan(fidNegative,'%s','CommentStyle',';');
wordsNegative = string(C2{1});
fclose all;

%Placing the negative words in the table
[negsize, ~] = size(wordsNegative);
for ii = 1:negsize
    words_hash.put(wordsNegative(ii,1),1);
end

%Check table for word
words_hash.get('yawn')
words_hash.get('zippy')
