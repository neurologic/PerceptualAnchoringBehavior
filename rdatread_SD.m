function Trial = rdatread_SD(fname)
% Script to read in cleaned up rdat file
% set up for go-nogo
fid=fopen(fname);
C=textscan(fid, '%d %d %d %s %s %d %d %d %d %d %d %d %d', ...
    'CommentStyle', {'File', 'Date'});
fclose(fid);


% parse into trial structure
Trial.sess=C{1};
Trial.trialno=C{2};
Trial.trialtype=C{3};
Trial.anchor=C{4};
Trial.target=C{5};
Trial.REPcnt=C{6};
Trial.max=C{7};
Trial.targetplay=C{8};
Trial.RspAc=C{9};
Trial.reinfor=C{10};
Trial.rxntime=C{11};
Trial.TOD=C{12};
Trial.day=C{13};

