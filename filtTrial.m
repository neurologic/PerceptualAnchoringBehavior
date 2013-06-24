function filterTrial=filtTrial(Trial, index, value)

s=['useind=Trial.' index ';'];
eval(s);
inds=[];
inds=find(useind==value);

trialindex=fieldnames(Trial);
for iindex=1:size(trialindex,1)
    s=['useind=Trial.' trialindex{iindex} ';'];
    eval(s);
    filtype=useind(inds);
     s=['filterTrial.' trialindex{iindex} '=filtype;'];
     eval(s);
end