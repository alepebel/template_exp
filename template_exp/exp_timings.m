
%% short description of what it should happen in each trial. This design might change across experiments.
% In this example experiment there will be a random duration of the
% fixation point, then the visual and auditory stimuli will be presented
% briefly. The participant will have the opportunity to select the correct
% response and will receive some feedback
function [Experimentalsession] = exp_timings(Experimentalsession, block);

% flip interval timing with this monitor to a simpler variable
ifi = Experimentalsession(block).init.ifi;

%% Experiment timings

% These times that are always the same in all trials. Convert taking into
% account monitor ifi
[frame_events.INIT_DELAY time_events.INIT_DELAY] = frame_converter(2, ifi); % time before the first trial in each block
[frame_events.VSTIMDUR time_events.VSTIMDUR] = frame_converter(0.2, ifi); % time before the first trial in each block
[frame_events.ASTIMDUR time_events.ASTIMDUR] = frame_converter(0.2, ifi); % time before the first trial in each block
[frame_events.WAIT_FOR_RESPONSE time_events.WAIT_FOR_RESPONSE] = frame_converter(1, ifi); % time before the first trial in each block
[frame_events.RESPONSETIME time_events.IRESPONSETIME] = frame_converter(1, ifi); % time before the first trial in each block
[frame_events.FEEDBACK time_events.FEEDBACK] = frame_converter(0.25, ifi); % time before the first trial in each block

%% Creating vector with the experiment events timings normalized to frames.
for t_idx = 1 : Experimentalsession(block).nTrials % I am randomizing the ITI in each trial using FP
    
    % intertrial time (fixation point, time before stimulus is random here,
    % extracted from a unirform distribution 1 to 0.5 s). All trial events
    % with a random duration should be defined here.
    [frame_events.FIXATION(t_idx) time_events.FIXATION(t_idx)]  = frame_converter( 0.5 + (1.5 - 0.5) * rand(1,1), ifi);
    
    if (t_idx== 1) % only before the first trial there is the INIT_DELAY /this can be useful in an fMRI design to withold starting the experiment until the dummy scans are done.
        frame_events.TRIAL_TIMES(t_idx) = frame_events.INIT_DELAY;
        
    else
        
        % creating the frames_events vector according to number of frames
        % in the previous trial
        frame_events.TRIAL_TIMES(t_idx) = frame_events.TRIAL_TIMES(t_idx-1) + ...
            frame_events.FIXATION(t_idx-1) + frame_events.VSTIMDUR  + ...
            frame_events.WAIT_FOR_RESPONSE + frame_events.RESPONSETIME + ...
            frame_events.FEEDBACK;
    end
    % transform frames to time units using IFI value. This is not
    % necesary, but I want to have this particular values in time
    time_events.TRIAL_TIMES(t_idx) = frame_events.TRIAL_TIMES(t_idx)*ifi;
end

Experimentalsession(block).time_events = time_events; % times provided initially
Experimentalsession(block).frame_events = frame_events; % times transformed to program


end
