clear
quick_mode=1;
KbName('UnifyKeyNames')
addpath("Elements\")
subjnr =4; %input('Subject Code? ','s');
DvFilename = strcat('results\MooreRate_',subjnr,'.dv');

trial_list = MakeTL(quick_mode);
results = zeros(size(trial_list,1), 5);

% This Makes the configuration for the Moore Setup!
p = MakeP();
pp = [];

%%
try
    %% --- Open the screen.
    lpsy.init();
    Screen('Preference', 'SkipSyncTests', 1);
    if isempty(p.Screen)
        p.Screen = lpsy.getSysPmtr('Several','DefaultScreenNo',0);
    end


    pp.BgLum = min(255, round(p.BgLum));%min(255, round(p.BgLum/100*255));
    wnd = lpsy.openWindow(p.Screen, pp.BgLum);
    %--- For accurate anti-aliasing we have to rely on a good monitor
    %    calibration (i.e. gamma correction), and we need blending to be enabled.
    %    This is also used for text rendering.
    %    Both (gamma and blending) should not have an effect on the stimulus
    %    if anti-aliasing is actually not used, provided we don't make mistakes
    %    with rounding pixel coordinates and such.

    lpsy.setGammaTab(1.0, 'gray');
    Screen('BlendFunction', wnd, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    %---
    sci = Screen('Resolution', p.Screen);
    sci.wnd = wnd;
    lpsy.setScreenDistCM(p.ScreenDist);
    HideCursor();

    %% --- Initialize pretty text rendering.
    lpsy.prepDrawPrettyText(wnd);

    dontRoundJitterX = false;
    %--- To which multiple number of pixels do we have to round the vernier offset?
    %    Note that the center of a 0-offset vernier defines the center of the stimulus,
    %    which might either lie on a pixel or between two pixels (along X), depending
    %    on the line width.

    if rem(p.PosJitter(1),1)>0
        %--- Anti-aliasing and a not whole-numbered jitter value for X: Use the value "as is".
        pp.PosJitter(1) = p.PosJitter(1);
        dontRoundJitterX = true;
    end

    pp = MakePP(p, pp);

    % writes the parameters for the exact Moore replication to file
    %writeppp2DV(p, pp, dontRoundJitterX)
    
    %--- In case the window was open already, make sure the screen is cleared.
    lpsy.flip(wnd);

    %% Iterate over trials
    for trial = 1:size(trial_list, 2)

        % Get the Information what type of trial it should be from the trial lists
        cond = trial_list(trial);
        p.cond = cond;
        minusPlusOne = [-1,1];         % -1: left: 1:right
        vOffsetDir = minusPlusOne(randi(2));


        %% Decide stimulus position
        center = [sci.width, sci.height]/2 + round((2*rand()-1)*(pp.PosJitter+0.4999));
        %

        % decide position of the stimulus
        posx = center(1);
        posy = center(2);

        %possibility to alternate
        if p.periphDir == 0
            side = rand() < 0.5;
        elseif p.periphDir == 1
            side = 0;
        else
            side=1;
        end


        if p.periph
            if side
                if p.posStim
                    posy = center(2) +  pp.vert_offs; 
                else
                    posx = center(1) + pp.periph_offs;
                end
           else
                if p.posStim
                    posy = center(2) -  pp.vert_offs; 
                else       
                    posx = center(1) - pp.periph_offs;
                end
            end
        end

        %% BEGIN PRESENTATION
        lpsy.releaseKeyWait();

        % Set BgLum based on the condition
            if p.cond == 1
                BgLum = 100;
            elseif p.cond == 2 || p.cond == 5 ||p.cond == 8
                BgLum = 120;
            elseif p.cond == 3
                BgLum = 140;
            elseif p.cond == 4
                BgLum = 80;
            elseif p.cond == 6
                BgLum = 160;
            elseif p.cond == 7
                BgLum = 60;
            elseif p.cond == 9
                BgLum = 180;
            else
                error('Invalid condition specified in p.cond');
            end

        keyListEscape = KbName({'esc'});
        keyList = KbName({'left','right'});        

        Screen('FillRect', sci.wnd, BgLum, [], []);
        DrawFormattedText(sci.wnd, 'Press a key to continue', center(1)-300, center(2), [255 255 255]);
        lpsy.flip(sci.wnd);

        [isEsc, keyIdx, time] = lpsy.getKey(keyList, 200);
       

        %random wait
                fd = p.fc_dur+(rand()-0.5)/2; % randomness between -0.25 and 0.25
                WaitSecs(fd);

              
        DrawFixationCross_basic(sci, pp, center(1), center(2))
        lpsy.flip(sci.wnd);
       
        %change fixation cross
        

       
  
       DrawBoarder(sci, pp, posx, posy, p.cond);
       DrawFixationCross_basic(sci, pp, center(1), center(2))
       vasetex = DrawVase(sci, pp, posx, posy, p.cond);
       
     
       %DrawVernier(sci, pp, posx, posy, vOffsetDir*pp.VernierOffset, p.VernierOri);
       %DrawVernier(sci, pp, posx, posy, 0, p.VernierOri);

        WaitSecs(p.IntermediateDuration/1000); 
        vernierOnsetSecs = lpsy.flip(sci.wnd);
        %% Get Keys
        flipDelayVernier = lpsy.frame2sec(pp.VernierDuration);

        %--- Await end of stimulus presentation.
        [~, isEsc, keyIdx, responseSecs] = lpsy.flipOrGetKey(sci.wnd, vernierOnsetSecs, flipDelayVernier, keyList,1);
        [isEsc, keyIdx, responseSecs] = lpsy.getKey(keyList, p.ResponseTimeout);
        if p.cond >= 2
            Screen('Close', vasetex);
        end
    
        %% --- Handle VERNIER response
        if isEsc
            error('Aborted with Escape.');
        end
        %---
        if keyIdx
            %--- We have a response.
            answerTi = 1000*(responseSecs-vernierOnsetSecs);
            %--- Check for early response.
            answerDir = minusPlusOne(keyIdx);
        else
            % No answer
            answerTi = 0;
            isHit = 0;
            answerDir = 99;
        end
% 
% 
        results(trial, 1) = vOffsetDir;
        results(trial, 2) = answerDir;
        results(trial, 3) = answerTi;
        results(trial, 4) = p.cond;
%         results(trial, 4) = answerTi;
    end


    lpsy.showInfoScreen(wnd, "DONE", 0);
    lpsy.cleanup();

    writematrix(results, strcat('results/jdgmt_', subjnr, '.csv'));

catch err

    lpsy.cleanup(err);
end

sca

