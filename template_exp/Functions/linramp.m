function [ramped_stim] = linramp(raw_stim,DUR,fs,ramp_size)
% Filters input stimulus waveform with linear on-off ramps. 
% Ramp size (ramp_size) is a percentage of the total stimulus duration (DUR)
%
% USAGE: [ramped_stim] = linramp(raw_stim,DUR,fs,ramp_size)
% raw_stim: original waveform
% DUR: stimulus duration (secs)
% fs: sampling frequency
% ramp_size: proportion of stimulus duration (e.g., 0.1)
%
% Written 7/17/2014 JMY

fullr_samples         = numel(raw_stim);
% fullr_samples       = floor(fs*DUR);

r_samples    = floor(ramp_size*fullr_samples); % calculate total samples in ramp
r = linspace(0,1,r_samples); % set ramp values (0-1 across ramp)

full_r = [r ones(1, fullr_samples - 2*r_samples) fliplr(r)]; % concat full ramp filter function (on, plat, off)

ramped_stim = raw_stim.*full_r; % apply ramp filter

% figure; plot(ramped_stim);