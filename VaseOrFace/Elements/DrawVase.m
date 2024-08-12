% Draws the bistable picture.

function texture = DrawVase(sci, pp, posx, posy, cond) 

 imageFolder = 'Images';
    if cond == 1 || cond == 2 || cond == 3
        imagePath = fullfile(imageFolder, '100_140.png');
    elseif cond == 4 || cond == 5 || cond == 6
        imagePath = fullfile(imageFolder, '80_160.png');
    elseif cond == 7 || cond == 8 || cond == 9
        imagePath = fullfile(imageFolder, '60_180.png');
    end
    image = imread(imagePath);
    texture = Screen('MakeTexture', sci.wnd, image);
    
    % Position the images to the left and right of the central fixation dot
    rect = CenterRectOnPoint([0 0 pp.size_x pp.size_y], posx , posy);
   
    
    % Draw the textures on the screen at the calculated positions
    Screen('DrawTexture', sci.wnd, texture, [], rect);
   
end
