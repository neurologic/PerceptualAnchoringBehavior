function [data,rem]=databyblock(Trial,whichdata,value,blksize);


s=['usedata=Trial.' whichdata ';'];
eval(s);
numvalue=[];
numblocks=floor(size(Trial.sess,1)/blksize);
blockbins=[0:(blksize):(numblocks*blksize)];
blockbins(1)=1;
remainderblocks=mod(size(Trial.sess,1),blksize);
for iblock=1:numblocks-1;
    
    inds=find(usedata(blockbins(iblock):blockbins(iblock+1))==value);
   if isempty(inds);
       numvalue(iblock)=0;
   else
    numvalue(iblock)=size(inds,1);
   end
end
% 
% if remainderblocks~=0;
%     inds=find(usedata(blockbins(iblock+1):(blockbins(iblock+1)+remainderblocks))==value);
%     numvalue(iblock+1)=size(inds,1);
% end
   rem=remainderblocks;
   data=numvalue;