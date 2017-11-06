
%% This function displays the stimuli in this experiment. Alexis Perez Bellido 11-2017

function [Experimentalsession quest] = trial_function(win, Experimentalsession, init, quest, block, pahandle)

HideCursor;
ifi = Experimentalsession(block).init.ifi;
cond = [];
visual_stim = [];

%while(find(keycode) ~= KbName('ESCAPE')) % press this key to stop the program (resp function also checks ESC)

% First flip. Time reference of the begining of the block
init_time = Screen('Flip', win); % collect init time of the experiment
vbl = init_time;
time_log = [];

% Animation loop: we loop for the total number of trials
for iTrial = 1 : Experimentalsession(block).nTrials
    
    % create the stimuli for this trial and record the conditions
    [cond, visual_stim] = create_stimuli(Experimentalsession, block, win, quest, iTrial, cond, visual_stim);
    
    % 1: frames to start 1st trial and draw fixation
    if iTrial == 1
        waitframes = Experimentalsession(block).frame_events.INIT_DELAY;
        Screen('FillOval', win,visual_stim.color_fp, visual_stim.centeredRect_fp, visual_stim.radious_fp); % and fixation point
        vbl = Screen('Flip', win, vbl + (waitframes - 0.5) * ifi); % collect init time
    end
    
    %% I am going to verify that timing is correct
    time_exp = vbl - init_time; % measures relative elapsed time
    %plot(1:iTrial,trial_time_diff)
    trial_time_diff(iTrial) = Experimentalsession(block).time_events.TRIAL_TIMES(iTrial) - time_exp;
    time_log = [time_log vbl];
    
    % 2: draw fixation point + vstim
    waitframes = Experimentalsession(block).frame_events.FIXATION(iTrial);
    
    %% Preparing auditory stimulus to be reproduced
    PsychPortAudio('Start', pahandle, 1, Inf); % Load A stim
    PsychPortAudio('RescheduleStart',pahandle, vbl + (waitframes * ifi)); % Set the time for presenting the sound (you might need to adjust this carefully)
    
    Screen('DrawTextures', win, visual_stim.gabortex, [], visual_stim.dstRects, visual_stim.rotAngles); % draw texture
    Screen('FillOval', win, visual_stim.color_fp, visual_stim.centeredRect_fp, visual_stim.radious_fp); %color_fp
    Screen('DrawingFinished', win);
    vbl = Screen('Flip', win, vbl + (waitframes - 0.5) * ifi);
    time_log = [time_log vbl];
    
    % 3: draw fixation point - vstim
    waitframes = Experimentalsession(block).frame_events.VSTIMDUR;
    Screen('FillOval', win, visual_stim.color_fp, visual_stim.centeredRect_fp, visual_stim.radious_fp); %color_fp
    vbl = Screen('Flip', win, vbl + (waitframes - 0.5) * ifi);
    time_log = [time_log vbl];
    
    % 4: draw response options Y or N
    waitframes = Experimentalsession(block).frame_events.WAIT_FOR_RESPONSE;
    Screen('TextSize',  win, 3*init.ppd);
    DrawFormattedText(win, 'Y', init.wMid - (5*init.ppd), 'center',  [0,0,0]); % right response option
    DrawFormattedText(win, 'N', init.wMid + (3*init.ppd), 'center',  [0,0,0]); % left response option
    Screen('FillOval', win, visual_stim.color_fp, visual_stim.centeredRect_fp, visual_stim.radious_fp); %color_fp
    vbl = Screen('Flip', win, vbl + (waitframes - 0.5) * ifi);
    time_log = [time_log vbl];
    
    % collecting responses
    waitframes = Experimentalsession(block).frame_events.RESPONSETIME;
    time_resp = (waitframes-2) * ifi; % translate to time (Participant has all these frames -2 to respond)
    
    [response RT correct Experimentalsession] = resp_func(vbl, time_resp, Experimentalsession, block, iTrial, cond, visual_stim, pahandle);
    % disp(RT)
    % Experimentalsession(block).results.responses_vector
    
    % Update quest handle (you need to provide contrast in the last trial).
    quest = create_quest(quest,[] ,quest.q1.updated_contrast, correct);
    
    % 5: report feedback after response time is finished
    Screen('FillOval', win, [0 0.4 0], visual_stim.centeredRect_fp, visual_stim.radious_fp); %color_fp
    vbl = Screen('Flip', win, vbl + (waitframes - 0.5) * ifi);
    time_log = [time_log vbl];
    
    % 6: erase feedback draw fixation and move on to the next trial
    waitframes = Experimentalsession(block).frame_events.FEEDBACK;
    Screen('FillOval', win, visual_stim.color_fp, visual_stim.centeredRect_fp, visual_stim.radious_fp); %color_fp
    vbl = Screen('Flip', win, vbl + (waitframes - 0.5) * ifi);
    time_log = [time_log vbl];
    
    % close texture
    Screen('Close', visual_stim.gabortex);
    % saving presentation times in relative times between events and
    % difference relative to expected trial initiation.
    Experimentalsession(block).log.time_log = time_log;         %diff(time_log);
    Experimentalsession(block).log.trial_time_log = trial_time_diff;
    
    % if time error relative to expected is too big (> 10ms), exit program
    if(abs(trial_time_diff(iTrial)) > 0.01)
        warning('time error relative to expected time larger than 10 ms')
        break
    end
    
    %end
    
    
end


