function DrawText(text, oDisp, tColor, tSize)

if ~exist('tColor', 'var'), tColor = [0 0 0]; end
if ~exist('tSize', 'var'), tSize = 50; end

Screen('TextSize', oDisp.windowPtr, tSize);
yOff = round(length(text) * 9.5 * tSize/40);
xOff = round(2 * tSize);
Screen('DrawText', oDisp.windowPtr, text, oDisp.windowRect(3)/2-yOff, oDisp.windowRect(4)/2-xOff, tColor);
Screen('Flip', oDisp.windowPtr);


end
