%% This function is used to define the response actions. Data are also recorded to the data frame.
% if you want a finit ammount of time to respon, provide time_resp.
% Otherwise you can set this time as Inf.
% Alexis Perez Bellido 2017

function [response RT correct Experimentalsession] = resp_func(vbl, time_resp, Experimentalsession, block, iTrial, cond, visual_stim, pahandle)
 
 % Define the keyboard keys that are listened for. We will be using the left
% and right arrow keys as response keys for the task and the escape key as
% a exit/reset key
escapeKey   = KbName('ESCAPE');
leftKey     = KbName('LeftArrow');
rightKey    = KbName('RightArrow');

% initialize some flags
respToBeMade = true;
rel_time = 0;
response = 0; % no response

while (respToBeMade == true & rel_time < time_resp) % enter response loop and exit two frames before feedback 
    rel_time = GetSecs - vbl; % compute time relative to last flip
    [keyIsDown,secs, keyCode] = KbCheck;
    if keyCode(escapeKey)
        close_program(pahandle)
        break;
        return
    elseif keyCode(leftKey)
        response = 1;
        disp(keyIsDown)
        respToBeMade = false;
    elseif keyCode(rightKey)
        response = 2;
        disp(keyIsDown)
        respToBeMade = false;
    end
end
% adjust for correct or incorrect response if you want feedback
correct = 1; 
RT = secs - vbl;

%% Saving responses vector in datamatrix
% Experimentalsession.results.responses_vector_variables % 'subject_ID'    'block'    'trial'    'Stim_time'    'grating_tilt' 'contrast'    'SF'    'keypressed' 'correct'    'RT'
subj = Experimentalsession.params.initials;
trial_data = {subj block iTrial vbl visual_stim.gtilt visual_stim.contrast visual_stim.sf response correct RT};%

% Append to results matrix 
Experimentalsession(block).results.responses_vector(iTrial,:) = trial_data;

end