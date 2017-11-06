
%% Experiment conditions and design

function [Experimentalsession] = exp_design(Experimentalsession, block, dataFile);

% Define the different conditions
exp_cond.v_stim = {'signal','noise'};
exp_cond.modality = {'V','AV'}; % ,'AV'

% Define number of repetitions
reps =  5;

% Combinations of conditions and randomization
allCombinations = combvec([1:length(exp_cond.v_stim)],[1:length(exp_cond.modality)]);
allCombinations = allCombinations'; % transposing all combinations matrix
sizeComb        = length(allCombinations);
nTrials         = reps*sizeComb;
allCombinations = repmat(allCombinations,reps,1);

%generic variable to randomize trials order inside the allCombination
rand_trials_vector = 1 : nTrials;
rand_trials_vector = rand_trials_vector(randperm(nTrials));  % This will serve to select the corresponding arrow during the experiment.

%randomize order
stim_combinations = allCombinations(rand_trials_vector,:);

Experimentalsession(block).design.stim_combinations = stim_combinations;
Experimentalsession(block).design.repetitions = reps;

% save the different conditions conforming your experimental design
Experimentalsession(block).design.exp_cond.v_stim = exp_cond.v_stim
Experimentalsession(block).design.exp_cond.modality = exp_cond.modality

Experimentalsession(block).nTrials = nTrials;


% saving the updated matrix (you can move this step to the end later
save(dataFile,'Experimentalsession');


end