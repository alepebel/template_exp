
%% Here we close video and audio devices and shows cursor if removed
function close_program(pahandle)

ShowCursor;
Screen('Closeall')
PsychPortAudio('Close', pahandle)


end


