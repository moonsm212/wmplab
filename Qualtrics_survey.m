clear;clc
%Pretest only: GDS,TCA,NFC,FDM
%CHAMP is administered in pre, FU2, FU3
%Mini-marker at FU2

filename = {'EMQ','CFQ-MAL','GAD','MIA','TCA',...
            'FDM','NFC','WHOQOL-OLD','GSE','GDS'};
i=8;  %Choose correct survey
j=2;  %1=pretest only  2=multiple sessions 
k=2;  %1=sum  2=average (WHOQOL-OLD)
num = csvread(char(strcat(filename(i),'.csv')),3,17);
num = sortrows(num,2); %sort by session
num = sortrows(num,1); %sort by ID
if j==1
    value = num(:,2:end);
elseif j==2
    value = num(:,3:end);
% elseif j==3
%     value = num(:,3:20);
end

if i==4 || i==5   %Reverse scaling for MIA and TCA
    if i==4  %MIA
        items = [2 8 11];
    elseif i==5   %TCA
        items = [1 2 3 5];
    end
    for each=1:length(items)
        for scale=1:length(value(:,1))
            if value(scale,items(each))==1
                value(scale,items(each))=5;
            elseif value(scale,items(each))==2
                value(scale,items(each))=4;
            elseif value(scale,items(each))==4
                value(scale,items(each))=2;
            elseif value(scale,items(each))==5
                value(scale,items(each))=1;
            end
        end
    end
end

if i==10   %Scale for GDS
    for scale=1:numel(value)
        if value(scale)==0
            value(scale)=NaN;
        elseif value(scale)== 1
            continue
        elseif value(scale)== 2
            value(scale)= 0;
        end
    end
    items = [1 5 7 11 13];
    for each=1:length(items)  %Reverse scaling for GDS
        for scale=1:length(value(:,1))
            if value(scale,items(each))== 1
                value(scale,items(each))= 0;
            elseif value(scale,items(each))== 0
                value(scale,items(each))= 1;
            end
        end
    end
end


if i==7   %Scale for NFC
    for scale=1:numel(value)
        if value(scale)== 1
            value(scale)= -4;
        elseif value(scale)== 2
            value(scale)= -3;
        elseif value(scale)== 3
            value(scale)= -2;
        elseif value(scale)== 4
            value(scale)= -1;
        elseif value(scale)== 5
            value(scale)= 0;
        elseif value(scale)== 6
            value(scale)= 1;
        elseif value(scale)== 7
            value(scale)= 2;
        elseif value(scale)== 8
            value(scale)= 3;
        elseif value(scale)== 9
            value(scale)= 4;
        elseif value(scale)==0
            value(scale)=0;
        end
    end
    items = [6 8 10 11 13:16 19:25 27:29 31:34 41 43 44];
    for each=1:length(items)  %Reverse scaling for NFC
        for scale=1:length(value(:,1))
            if value(scale,items(each))== 4
                value(scale,items(each))= -4;
            elseif value(scale,items(each))== 3
                value(scale,items(each))= -3;
            elseif value(scale,items(each))== 2
                value(scale,items(each))= -2;
            elseif value(scale,items(each))== 1
                value(scale,items(each))= -1;
            elseif value(scale,items(each))== -1
                value(scale,items(each))= 1;
            elseif value(scale,items(each))== -2
                value(scale,items(each))= 2;
            elseif value(scale,items(each))== -3
                value(scale,items(each))= 3;
            elseif value(scale,items(each))== -4
                value(scale,items(each))= 4;
            end
        end
    end
end

if i<=3 %Substract 1 to adjust for 0-4 scales
    for change=1:numel(value)        
        if value(change)==0
            value(change)=NaN;
        else
            value(change)=value(change)-1;
        end
    end
end   

%Cut out items
if i==8 %WHOQOL-OLD
    value=value(:,[3:16,18:20]);
    for zero=1:length(value)
        if value(zero)==0
            value(zero)=NaN;
        end
    end
elseif i==7 %NFC
    value=value(:,3:end);
end

if k==1
    score = nansum(value,2);
elseif k==2    
    score = nanmean(value,2);
end
csvwrite(char(strcat(filename(i),'_score.csv')),horzcat(num(:,1:2),score))









