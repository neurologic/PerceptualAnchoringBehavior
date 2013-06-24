function Trial=getTrial(birdID,stimfile,r)
%stimfile='SD_tones' without .wav on end
%birdID='B767';
birdDat=[birdID(1:end) '_' stimfile '.SD_rDAT'];
Trial = rdatread_SD(fullfile([r.Dir.Behavior 'B' birdID], birdDat));



