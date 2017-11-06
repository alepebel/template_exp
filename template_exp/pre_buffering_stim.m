%% Pre-creating some stimuli.
% This can save time during the stimulus presentation. In some cases where the features
% of the visual or auditory stimulus are adaptatively updated as a function of the participants
% responses, visual and auditory buffers can be created during fixation point time in each
% trial
function [pahandle]  = pre_fuffering(Experimentalsession, block, init, pahandle); 
%% Creating sound buffer
ASTIMDUR  = Experimentalsession(block).time_events.ASTIMDUR; %sec.

% creating a whitenoise example
white_noise = (rand(1,round(ASTIMDUR*init.fs))*2-1); % LETS create some whitenoise.
white_noise = linramp(white_noise,ASTIMDUR,init.fs,0.015); % apply ramp on/off
white_noise = [white_noise ; white_noise]; % fill the two channels

% create a warning beep example 
freq             = 1000; % hz
amplitude        = 1; % arbitrary units
beep_noise       = amplitude*sin(linspace(0, ASTIMDUR *freq*2*pi, round(ASTIMDUR*init.fs))); 
beep_noise       = linramp(beep_noise,ASTIMDUR,init.fs,0.005); % apply ramp on/of
beep_noise       = [beep_noise ; beep_noise]; % fill the two channels

% load memory buffers with auditory stimulus. Ready to fire!.
PsychPortAudio('FillBuffer', pahandle, white_noise); % Auditory stimulus
% PsychPortAudio('FillBuffer',pahandle, beep_noise); % warning signal

% clear ASTIMDUR;

end
