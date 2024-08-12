% Draws all the distractors/flankers of the stimulus.
%
%################# H I S T O R Y #####################
% 26.04.2024 (LS = Lisa Schwetlick, LPSY@EPFL):
%   * First version.

function DrawFlankers(sci, pp, centerX, centerY, cond, vert)
    
    flen = pp.flanker_len;
    lw = pp.LineWidth;

    if cond ==1
        % 1 just vernier
        flankers_on = 0;
        pac_on = 0;
        illusory_on = 0;
        flankers_type=0;
        pac_side = 0;
        % no flankers
    elseif cond==2
        % 2 short flankers
        flankers_on = 1;
        pac_on = 0;
        illusory_on = 0;
        flankers_type=0;
        pac_side = 0;
        % flankers no pac
    elseif  cond==3
        % 3 long flankers
        flankers_on = 1;
        pac_on = 0;
        illusory_on = 0;
        flankers_type=1;
        pac_side = 0;
    elseif cond==4
        % 4 gapped flankesrs, no IL
        flankers_on = 1;
        pac_on = 0;
        illusory_on = 0;
        flankers_type = 2;
        pac_side = 0;
    elseif cond==5
        % 5 long flankers, pacmen inside, no IL 
        flankers_on = 1;
        flankers_type = 2;
        pac_on = 1;
        pac_side = 1;
        illusory_on = 0;
    elseif cond==6
        % 6 gapped flankers, pacment inside, IL
        flankers_on = 1;
        pac_on = 1;
        pac_side = 1; %inside
        illusory_on = 1;
        flankers_type = 1;
    elseif cond==7
        % 7 long flankers, pacmen outside 
        flankers_on = 1;
        pac_on = 1;
        pac_side = 0;
        illusory_on = 0;
        flankers_type = 1;
    elseif cond==8
        % 8 gapped flankers, pacment outside
        flankers_on = 1;
        pac_on = 1;
        pac_side = 0;
        flankers_type = 1;
        illusory_on = 1;
    elseif cond==9
        % 9 gapped flankers IL
        flankers_on = 1;
        pac_on = 0;
        pac_side = 0;
        illusory_on = 1;
        flankers_type = 1;
    end

    if flankers_on
        if flankers_type == 1
            Flankers(sci, pp, centerX, centerY, pp.fl_offset, pp.n_flankers, flen, lw, vert);
        elseif flankers_type == 0
            Flankers_short(sci, pp, centerX, centerY, pp.fl_offset, pp.n_flankers, lw, vert);
        else 
            Flankers_gaps(sci, pp, centerX, centerY, pp.fl_offset, pp.n_flankers, lw, vert);
        end
    end
    if pac_on  
        Pacman(sci, pp, centerX, centerY, pac_side, vert);
    end
    if illusory_on
        IllusoryLine(sci, pp, centerX, centerY, pac_side, vert);
    end

end