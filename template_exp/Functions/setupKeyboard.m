function kb = setupKeyboard()
% Setup universal Mac/PC keyboard and keynames

KbName('UnifyKeyNames');
kb.escKey = KbName('ESCAPE');
kb.oneKey = KbName('1!');
kb.twoKey = KbName('2@');
kb.threeKey = KbName('3#');
kb.fourKey = KbName('4$');
kb.fiveKey = KbName('5%');
kb.sixKey = KbName('6^');
kb.sevenKey = KbName('7&');
kb.eightKey = KbName('8*');
kb.nineKey = KbName('9(');
kb.bKey = KbName('b');
kb.vKey = KbName('v');
kb.gKey = KbName('g');
kb.yKey = KbName('y');
kb.tKey = KbName('t');
kb.qKey = KbName('q');
kb.wKey = KbName('w');
kb.eKey = KbName('e');
kb.rKey = KbName('r');
kb.spaceKey = KbName('space');
kb.pKey = KbName('p');
kb.oKey = KbName('o');
kb.iKey = KbName('i');
kb.kKey = KbName('k');
kb.lKey = KbName('l');
kb.zKey = KbName('z');
kb.xKey = KbName('x');
kb.cKey = KbName('c');
kb.aKey = KbName('a');
kb.sKey = KbName('s');
kb.dKey = KbName('d');
kb.fKey = KbName('f');

% Set up mappings for IRC response pad in key-repeat mode
kb.yesKey = kb.bKey;
kb.noKey = kb.yKey;
kb.triggerKey = kb.tKey;
% kb.triggerKey = kb.bKey; % for testing button response at scanner
if (ispc || IsLinux)
  kb.int = [];
  kb.ext = [];
else
  devices = getDevices;
  
  if length(devices.keyInputInternal) > 1
    disp(['More than one internal keypad, devices: ', int2str(devices.keyInputInternal)])
    kb.int = input('Specify internal device number to use: ');
  else
    kb.int = devices.keyInputInternal;
  end
  if length(devices.keyInputExternal) > 1
    disp(['More than one external keypad, devices: ', int2str(devices.keyInputExternal)])
    kb.ext = input('Specify external device number to use: ');
%     kb.int = input('Specify "internal" device number to use: ');
  else
    kb.ext = devices.keyInputExternal;
  end
end
end