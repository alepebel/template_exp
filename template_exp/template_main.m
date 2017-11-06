function template_exp()

%% This is an example of a simple audiovisual experiment with a modular design and different
% Alexis Perez-Bellido 30-8-2017
% The functions can be flexibly changed in order to fit different experimental designs...

%% First of all initialize main parameters of this experiment
init_variables;

%% Collecting subject data and verifying whether is the first session.
[Experimentalsession, block, path, outputFolder, dataFile] = subj_ID(init);

%% Creating the different combinations of conditions for the experiment 
[Experimentalsession] = exp_design(Experimentalsession, block, dataFile);

%% Initialize media devices (window to draw visual stimuli and sound buffer)
% Screen('Preference', 'SkipSyncTests', 1);  % You might need to run this
% if your screen if PTB3 screen tests failed in your monitor. Dont use SkipSyncTest for accurate time presentation
init_media_devices;

%% Creating the timing vector for the events on this experiment. It creates the timing relative to the monitor frame rate
[Experimentalsession] = exp_timings(Experimentalsession, block);

%% Creating an empty matrix to record online the conditions and subject responses during the experiment
[Experimentalsession] = data_matrix(Experimentalsession, block);

%% Pre-buffering visual and/or auditory stimuli (if you are using always a finit number of visual or auditory stim, it makes sense to precreate the texture here.
[pahandle]  = pre_buffering_stim(Experimentalsession, block, init, pahandle); 

%% Display some text with instructions 
task_instructions(init, win);

%% Create quest object variable to attach handles (inside of the function create_quest yo can configure your quests... 
% You can use the same function to update the quest after a correct or incorrect response)
quest = [];
quest.guess = Experimentalsession(block).params.guess;
% Create quest handle (you dont need to provide contrast now, only a guess value).
quest = create_quest(quest, quest.guess, [], 0);

%% Lets start to present the different trials
[Experimentalsession quest] = trial_function(win, Experimentalsession, init, quest, block, pahandle);
Experimentalsession(block).quest = quest;

% save data in m matrix
save(dataFile,'Experimentalsession');

% save matrix data to txt file. This is convenient for analyses in R
% Experimentalsession(block).results.responses_vector % verify that the format is correct 

%fileID = fopen([dataadaptoutput],'wt'); % try to write on top
%formatSpec = '%i %i %f %f %f %f %f %s %s %s %i %f %f %f %s %s %i %f %s \r\n';  
%for row = 1 : nrows
%    fprintf(fileID, formatSpec, quest.responses_vector{row,:}) ;
%end
%fclose(fileID);


%% Close video and audio
close_program(pahandle);



end
