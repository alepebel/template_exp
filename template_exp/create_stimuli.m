%% In this function I select the parameters for the stimuli in this trial. %
% I also update visual and auditory stimuli if it is necessary.
% It returns the visual stimuli, the conditions names of this trial, and
% the new state in the trial.

function [cond, visual_stim] = create_stimuli(Experimentalsession, block, win, quest, iTrial, cond, visual_stim)

init = Experimentalsession(block).init;

%% Visual symbols color codes (FPs)
visual_stim.color_fp = [0 0 0]; % rgb black
visual_stim.radious_fp = 1*init.ppd; % size of radius of fp in visual degrees
visual_stim.baseRect_fp = [0 0 visual_stim.radious_fp  visual_stim.radious_fp ]; % create a fake box to set the center of ovals
visual_stim.centeredRect_fp = CenterRectOnPointd(visual_stim.baseRect_fp, init.w/2, init.h/2);

%% see the names of your conditions
% Experimentalsession(block).design.exp_cond

%% Selecting conditions parameters and saving in structure
v_stim                 =   Experimentalsession(block).design.stim_combinations(iTrial,1); % signal or noise?
cond(iTrial).v_stim    =   Experimentalsession(block).design.exp_cond.v_stim(v_stim);
modality               =   Experimentalsession(block).design.stim_combinations(iTrial,2); % visual or audiovisual?
cond(iTrial).modality  =   Experimentalsession(block).design.exp_cond.modality(modality);

%% Creating grating texture; Selecting appropiated parameters and applying them..  
% (here you can prepare anyother V stim texture)

% (if you know a priori the characteristics of the stimuli, this part can
% be moved to the pre-buffering section and create all the stimuli at once prior running trials).

% visual stim contrast. If it is noise, contrast should be = 0
if strcmp (cond(iTrial).v_stim, 'noise')
    contrast = 0;
else
    if quest.q1.updated_contrast > 0 % We should limit that the quest creates negative contrast values
        contrast = quest.q1.updated_contrast;
    else
        contrast = 0;
    end
end


tilt    =  0 + (359-0).* rand(1,1); % generate a random orientation for this trial (between 0 and 359 degrees
sf      =  2;      % generate a random jitter for this trial
phi     = rand;
[img] = gabor_stim(init, contrast, tilt, sf, phi, init.gray, init.ppd);

% saving stim characteristics in a struct.
visual_stim.gtilt = tilt;
visual_stim.sf = sf;
visual_stim.contrast = contrast;
visual_stim.phi = phi;

%% Here I prepare the targets texture. Working with textures saves memory in the computer
% all the target textures were pre-generatedthe at the begining). Save the matrix always
% for regression analyses

% Creating textures and visual stim information (you can create multiple
% stimulus if you want, combining for loops and 
visual_stim.gabortex = Screen('MakeTexture', win, img); %Texture generated
% Now we get some information of the stimulus to locate the texture in the screen
visual_stim.texrect  = Screen('Rect', visual_stim.gabortex); %Extract information about texture size
visual_stim.scale    = 1; % keep same proportion...
visual_stim.rotAngles = [0]; % we create the gratings already rotated, so no rotation parameter should be applied to the texture.
visual_stim.dstRects  = CenterRectOnPoint(visual_stim.texrect*visual_stim.scale , init.wMid, init.hMid); % coordinates to center the square


end
