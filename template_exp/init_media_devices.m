%% Initializing media devices & stimuli


%% setup keyboard basic parameters %%

KbName('UnifyKeyNames')

%% Video set up %%

% Screen('Preference', 'SkipSyncTests', 1); % In lab I dont need to skip syn
PsychDefaultSetup(2); % 0 only run AsserOpenGL, 1 also runs unify keyboard, 2 change the color scale to 0-1 (instead 255)
%PsychDebugWindowConfiguration; % transparent window to debug

% Selects most peripheral screen. Screen can be specified manually here.
whichScreen = max(Screen('Screens'));

rect = [0 0 640 480]; % mini-screen. just in case you want to test something in a smaller screen

% Select the external screen if it is present, else revert to the native
% screen

% Define black, white and grey
init.black = BlackIndex(whichScreen);
init.white = WhiteIndex(whichScreen);
init.gray = init.white / 2;
% Taking the absolute value of the difference between white and gray will
% help keep the grating consistent regardless of whether the CLUT color
% code for white is less or greater than the CLUT color code for black.
init.absoluteDifferenceBetweenWhiteAndGray = abs(init.white - init.gray);


% Open graphics window on peripheral screen at certain rect resolution (if
% rect is not given, window will be as big as the screen
% [win winRect] = Screen('OpenWindow', whichScreen, init.gray); % ,rect

% Open an on screen window and color it grey
[win winRect] = PsychImaging('OpenWindow', whichScreen, init.gray);

% Set the blend funciton for the screen
Screen('BlendFunction', win, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

% Retreive the maximum priority number and set max priority (we can play
% with this depending on calculating stuff or drawing stimuli.
topPriorityLevel = MaxPriority(win);
Priority(topPriorityLevel);

% Measure the vertical refresh rate of the monitor
init.ifi = Screen('GetFlipInterval', win);

% Numer of frames to wait when specifying good timing. Note: the use of
% wait frames is to show a generalisable coding. For example, by using
% waitframes = 2 one would flip on every other frame. See the PTB
% documentation for details. In what follows we flip every frame.
% init.waitframes = 1;

[init.w, init.h] = RectSize(winRect);
init.wMid = [init.w/2]; init.hMid = [init.h/2];
init.poscenter = [init.w/2, init.h/2];


% You can write sca to close the screen
%% Audio setup %%
% Perform basic initialization of the sound driver :
InitializePsychSound;
nrchannels          = 2; % remember creating 2 channels later on for each headphone (you must use a REALTEK ASIUS sound card on windows for good timing)
devices             = PsychPortAudio('GetDevices')
audiodevice         = 1; % check devices variable and see what audiodevice has output function in this system

% Open one auditory buffer to load the stimuli (is possible to create
% multiple auditory buffers and pre-load all the sound waves to avoid speed
% loss.
pahandle   =  PsychPortAudio('Open',audiodevice, [], 1, init.fs, nrchannels);


Experimentalsession(block).init = init;

