
%% Collect subject info and initializes paths
% verifies that data are not overwritten.

function [Experimentalsession, block, path, outputFolder, dataFile] = subj_ID(init);


% universal file separator across operative systems is filesep

prompt = {'Enter subject initials: ', 'Contrast Guess: '};
input = inputdlg(prompt);
initials = input{1}; % Collect subject initials (You can add more inputs/variables required for the experiment.
guess = input{2};  % Provide a contrast guess value for the participant threshold

% save parameters of this block (imagine that you have blocks with
% different contrast levels, here you can tweak it.
params.initials = initials;
params.guess = str2num(guess);

%% Set current directory and paths
path = mfilename('fullpath'); % Finds current location of file

[pathstr] = fileparts(path); % Removes file information, saves directory
path = pathstr;
outputFolder = [path, filesep 'results' filesep ,initials, filesep];
 

% create folder to save data
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

% file where we will save all the data
dataFile = [outputFolder initials,init.exp_name,'.mat']; 

if exist(dataFile, 'file')
    disp('This subject has been already tested, checking block number');
    load(dataFile);
    n_blocks_runned = length(Experimentalsession);
    uiwait(msgbox(['Block tested previously = ', num2str(n_blocks_runned)],'modal'));
end


% Selecting block and check that has not been tested before
prompt = {'Enter block number: '};
input = inputdlg(prompt);
block = input{1};
block = str2num(block);
choice = [];

if exist(dataFile, 'file') %
    
    if sum([1:n_blocks_runned] == block)
        choice = questdlg('Block tested previously. Do you want to overwrite?', ...
            'Yes', 'No');
    end
    
    if strcmp(choice,'No')
        clear;
        % disp('Avoiding overwritting data. block stops')
        error('Avoiding overwritting data. Block stops');
    end
end

% attaching some variables of interest to the main experiment variable
Experimentalsession(block).init = init;
Experimentalsession(block).date = datetime;
Experimentalsession(block).params = params;

% creating the  subject file;
save(dataFile,'Experimentalsession');



end