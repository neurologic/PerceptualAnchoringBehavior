% specify bird ID and options for analysis
r=rigdef('manu')
birdID='1153';
stimfile='SD_DRC2';

%% read in rDAT file
Trial=getTrial(birdID,stimfile,r);


%% look at data starting from the last restart
% uses "filtSession" which takes the trial struct and the trial start and
% end indices that you want
session=Trial.sess;
startsess=find(session==1);  %finds session #1 trials

trials=Trial.trialno;
starttrial=find(trials==1); %finds trial #1 trials
%the following "for" loop finds all trials where both trial number and
%session number ==1
startinds=[];
index=1;
for isess=1:size(startsess,1)
    for itrial=1:size(starttrial,1)
        if startsess(isess)==starttrial(itrial);
            startinds(index)=startsess(isess); %all times that trial=sess=1
            index=index+1;
        end
    end
end
startinds
lastSession=filtSession(Trial,max(startinds),max(size(Trial.sess)));
Trial=lastSession;
 figure; scatter([1:size(lastSession.tod,1)],lastSession.tod)

 today=max(unique(Trial.day));
lastDay=filtTrial(Trial,'day',today);
correct=filtTrial(lastDay,'resp',1);
fed=filtTrial(correct,'reinfor',1);
feedstoday=size(fed.trialno,1)

%%
% make a different subplot for each anchor rep
options.blocksize=1000; %chunks trials into blocks; in that block the distribution of responses and trial types calculated
options.anchorRange=[1:10]; %will loop through Trial.anchor
options.responses=[1,0]; %loops through Trial.RspAc
correct=1;
incorrect=0;
noresp=2;

% initialize all of the result records
CorrectDetect=NaN(1,max(options.anchorRange));
IncorrectDetect=NaN(1,max(options.anchorRange));
FalseAlarm=NaN(1,max(options.anchorRange));
TargetNoResp=NaN(1,max(options.anchorRange));
AnchorNoResp=NaN(1,max(options.anchorRange));
for ianchor=1:max(options.anchorRange);
    anchorRep=ianchor;
    
%get correct and incorrect detection (trials when target played)
    TargetPlay=filtTrial(Trial,'targetplay',1);
    %these are trials in which a left peck would be required for food
    repcount=anchorRep;
    TargetTrialType=filtTrial(TargetPlay, 'rep', repcount);
    % from this (anchorRep=repcount followed by target) we can calculate
    % correct and incorrect detection
    CorrectDetect(ianchor)=max(size(find(TargetTrialType.resp==1)));
    IncorrectDetect(ianchor)=max(size(find(TargetTrialType.resp==0)));

%get false alarm struct (trials when no target played)
    NoTarget=filtTrial(Trial,'targetplay',0);
    %these are trials from which we get false alarm data and no response
    %data
    %for false alarms repcount should be +1 of correct/incorrect repcount
    repcount=anchorRep+1;
    SameTrialType=filtTrial(NoTarget, 'rep', repcount);
    %false alarms
    FalseAlarm(ianchor)=max(size(find(SameTrialType.resp==0)));
    
% get correct observe (repcount is +1 from trial type and target could have
% played or not)
    repcount=anchorRep+1;   
    PlusOneTrialType=filtTrial(Trial,'rep',repcount);
    CorrectSame(ianchor)=max(size(find(PlusOneTrialType.resp==1)));

%get no responses
    repcount=anchorRep;
    TargetNoResp(ianchor)=max(size(find(TargetTrialType.resp==2)));
    AnchorNoResp(ianchor)=max(size(find(SameTrialType.resp==2)));
end
totaltargetplay=max(size(find(Trial.targetplay==1)));
totalnotarget=max(size(find(Trial.targetplay==0)));

figure;
hold all
h(1)=plot(CorrectDetect);
h(2)=plot(IncorrectDetect);
h(3)=plot(FalseAlarm);
h(4)=plot(TargetNoResp);
h(5)=plot(AnchorNoResp);
h(6)=plot(CorrectSame);
legend('CorrectDetect','IncorrectDetect','FalseAlarm','TargetNoResp','AnchorNoResp','CorrectSame')
title([birdID ' targetplay:' num2str(totaltargetplay) ' notarget:' num2str(totalnotarget)])