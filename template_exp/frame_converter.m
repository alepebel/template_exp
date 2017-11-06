
%% This function transform a time value to frames and then updates the timing to the number of frames.
% Alexis Perez Bellido 2017
function [frames new_time] = frame_converter(time, ifi)

frames     =        round(time/ifi); % round to frame
new_time   =        frames * ifi; % reconverting to time units multiple of the n of frames


end