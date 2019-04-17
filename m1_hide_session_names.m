% initialisation
clearvars
clc

%define path and participants
path = '/Volumes/fernandd-02/sara/rawdata/m1';
participants = { 'c03'
    'c04'
    'c05'
    'c07'
    'c09'
    'c10'
    'c11'
    'c12'
    'c13'
    'c14'
    'c15'
    'c16'
    'c17'
    'c18'
    'c19'
    'c20'
    'c21'
    'c22'
    'c23'
    'c24'
    'c25'
    'c26'
};

%loop through each participant and find the three folders with sessions
for i = 1:numel(participants)
    thisparticipant = sprintf('%s%s', path,'/',participants{i});
    sessiondir = dir(thisparticipant);
    alldirs = sessiondir([sessiondir.isdir]);
    sessions = alldirs(3:end);
    
    %loop through each session folder and modify the name
    for j = 1:length(sessions)
        current = sessions(j);
        current_name = current.name;
        oldname = fullfile(thisparticipant,current.name);
        
        if strcmp(current_name(4:length(current_name)), 'anodal')
            newname = [fullfile(thisparticipant,current.name(1:3)) 'lung'];
        else if strcmp(current_name(4:length(current_name)), 'cathodal')
                newname = [fullfile(thisparticipant,current.name(1:3)) 'foot'];
            else if strcmp(current_name(4:length(current_name)), 'sham')
                    newname = [fullfile(thisparticipant,current.name(1:3)) 'back'];
                end
            end 
        end
        
        movefile(oldname,newname);
        
        
    end
end
