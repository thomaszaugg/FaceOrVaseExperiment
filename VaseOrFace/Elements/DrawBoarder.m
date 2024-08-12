% Draws the bistable picture.

function DrawBoarder(sci, pp, posx, posy, cond) 

    % if cond == 1 || cond == 2 || cond == 3
    %     
    if cond == 4 || cond == 5 || cond == 6
            size_x=pp.boarder1_x;
            size_y=pp.boarder1_y;
    elseif cond == 7 || cond == 8 || cond == 9
            size_x=pp.boarder2_x;
            size_y=pp.boarder2_y;
    else
        error('ConditionNotHandled:UnexpectedCondition', 'An unexpected condition was encountered.');
    end
 
    % Position the images to the left and right of the central fixation dot
    rect = CenterRectOnPoint([0 0 size_x size_y], posx , posy);
   
    
    Screen('FillRect', sci.wnd, pp.color_boarder, rect);
end