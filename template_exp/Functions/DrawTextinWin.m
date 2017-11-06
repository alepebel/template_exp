% I have created this function independently of th Drawtext. This function
% has the advantage that can be used with for the screens 

function DrawTextinWin(text, win,winRect, tColor, tSize)
if ~exist('winRect', 'var'), winRect = [0     0   640   480]; end
if ~exist('tColor', 'var'), tColor = [0 0 0]; end
if ~exist('tSize', 'var'), tSize = 50; end

Screen('TextSize', win,  tSize);
yOff = round(length(text) * 9.5 * tSize/40);
xOff = round(2 * tSize);
Screen('DrawText',win, text, winRect(3)/2-yOff, winRect(4)/2-xOff, tColor);


end
