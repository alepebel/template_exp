%% Init file. Initialize general/global parameters for the experiment (Alexis Perez Bellido 1/2/2017)

init.exp_name = 'Example_exp';
init.location = 'laptop';

disp(['Your program is setup to run at the ' init.location  ])
switch init.location
    
    case 'laptop'
        rng('shuffle'); % Randomize seed of random number generator
        init.screenwidhsize = 33; %
        init.screen_width_resolution = 2560; %
        init.distance2screen = 40; % in cm
    case 'cubicle'
        rng('shuffle'); % Randomize seed of random number generator
        init.screenwidhsize = 50; % in c
        init.screen_width_resolution = 1920; %
        init.distance2screen = 75.0; % in cm
        
    case 'MEG'
        rng('shuffle'); % Randomize seed of random number generator
        init.screenwidhsize = 50; %
        init.screen_width_resolution = 1920;
        init.distance2screen = 75.0; % in cm
end

%% Monitor/stimulus size calibration
init.pixel_size = init.screenwidhsize/init.screen_width_resolution; %Pixels are squared, so we only need to know one dimension
init.one_degree_length_incm = tan(deg2rad(1/2))*init.distance2screen*2;
init.one_degree_length_in_px = init.one_degree_length_incm/init.pixel_size;
%init.one_degree_length_in_px = 2*init.distance2screen*tan((1/2)*(pi/180))*(init.screen_width_resolution/init.screenwidhsize);


init.ppd = round(init.one_degree_length_in_px); % pixels per degree of visual angle

% Auditory stim sampling freq.
init.fs = 44100 %sampling fq


%%


