%% Basic example of an instructions screen
function task_instructions = task_instructions(init, win)
Screen('FillRect', win, init.gray);

% some general parameters
max_n_ofcharperline = 60;
linesep = init.ppd * 0.04;

Screen('TextSize',  win, round(init.ppd * 0.65));

title = ['WELCOME TO THE EXPERIMENT DEMO'];
DrawFormattedText(win,title , 'center', init.hMid-init.ppd*5, [200,0,0], max_n_ofcharperline,0,0,linesep);

Screen('TextSize',  win, init.ppd * 0.5);
firstext = ['Do this. BLABLABLABLA BLABLABLABLABLABLABLABLA...', ...
    ''];
DrawFormattedText(win,firstext , 'center', init.hMid-init.ppd*2, init.white, max_n_ofcharperline,0,0,linesep);


Screen('TextSize',  win, round(init.ppd * 0.5));
secondtext = ['REMEMBER: Press the button located in the same side as the number of times "0, 1 or 2" that you saw the ring flicker.' ];
DrawFormattedText(win,secondtext , 'center', init.hMid+init.ppd*0.5, [255,255,255], max_n_ofcharperline,0,0,linesep);

thirdtext = ['If you are ready, press one of the buttons to continue..' ];
Screen('TextSize',  win, round(init.ppd * 0.3));
DrawFormattedText(win,thirdtext , 'center', init.hMid+init.ppd*5, init.black, max_n_ofcharperline,0,0,linesep);


% print buffer (update window)
Screen(win,'Flip');

end
