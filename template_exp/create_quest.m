%% This function is designed to create a quest and updated it after subject responses.

function [quest] = quest_fun(quest, tGuessMean, contrast, correct)

% If you have different stimuli, you can provide a vector with parameters for each QUEST

if ~isfield(quest,'q1') % if there is not a quest created -> CREATE
    % initialize quest parameters
    pThreshold         = 0.72; % (previous was 0.75 and gamma 0.5)
    tGuessSd           = 0.035;
    beta               = 3.5;
    delta              = 0.01;
    gamma              = 0.5; % gamma is the proportion correct of responses that are expected when stimulus is not present. slope, threshold and minimum value (it is a 3AFC, noise, 2 x tilt )
    % the quest is designed only to update in noise and signal trials
    see_quest          = 0;
    range              = 0.1; % range below and above threshold to be tested
    %grain = 0.001;
    
    % lets initialize one quest handle (if you want to run multiple quests in
    % parallel, just create another quest handle.
    quest.q1 =                   QuestCreate(tGuessMean,tGuessSd,pThreshold,beta,delta,gamma,[],range,see_quest);
    quest.q1.normalizePdf =      1; % This adds a few ms per call to QuestUpdate, but otherwise the pdf will underflow after about 1000 trials.
    quest.q1.updated_contrast =  QuestQuantile(quest.q1); % assign a first tTest value
    
else
    % update quests with previous contrast and
    quest.q1 = QuestUpdate(quest.q1,contrast,correct);
    
    % record the new contrast estimate
    quest.q1.updated_contrast = QuestQuantile(quest.q1);
    
end

end
