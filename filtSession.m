function filterSession=filtSession(Trial, trialnumstart, trialnumend)

trialindex=fieldnames(Trial);
for iindex=1:size(trialindex,1)
    s=['tempindex=Trial.' trialindex{iindex} '(' num2str(trialnumstart) ':' num2str(trialnumend) ');'];
    eval(s);
     s=['filterSession.' trialindex{iindex} '=tempindex;'];
     eval(s);
end