% Populates the parameter dictionary with values for the Moore replication
%
%
%################# H I S T O R Y #####################
% 26.04.2024 (LS = Lisa Schwetlick, LPSY@EPFL):
%   * First version.

function p = MakeP()
    %% Populate p
    p.ScreenDist = 74;
    p.Screen = [];
    p.DvFilename = 'asd.dv';

    p.VernierOffset = 360; %125  % offset from the center---
    
    %% Experiment Details
    p.LineColor = [120,120,120];
    
    %Primer
    p.PrimerDuration = 1000;%100; % ms
    p.IntermediateDuration = 1000;%400; % ms 

    % Vernier
    p.VernierLength = 2500; % arcsec
    p.VernierGap = 0;
    p.LineWidth = 150;       % CHECK+
    p.VernierDuration = 1000;%200; %75; % 100 ms
    p.VernierOri = 0;

    %Image
    p.periph = 1;
    p.periph_offs = 6; % arcdeg
    p.vert_offs = 4; %  arcdeg
    p.size_x = 7; %  arcdeg
    p.size_y = 7; %  arcdeg

    p.boarder1 = 0.1 % arcdeg
    p.boarder2 = 0.3 % arcdeg
    p.color_boarder = 120;


     % Fixation Cross
    p.fc_lw = 120;
    p.fc_LineColor = [255,0,0];
    p.fc_size = 300;
    p.fc_dur = 1.2;
    p.fc_lw = 205;
    
    p.col = [0,0,0];
    p.periphDir = 1;
    
    p.ResponseTimeout= 9999;
    p.cond=9;
    % DISPLAY PARAMS
    p.PosJitter = 1.9;

    p.BgLum = 120;
    p.pacLum = 25;

    p.NegFeedbackVol = 10;
    p.WarningsVol=10;
    p.posStim = 1; % 0 = horizontally
                   % 1 = vertically
                     

end
