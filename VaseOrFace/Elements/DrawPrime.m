function texture = DrawPrime(sci, pp, posx, posy, cond)
    if cond == 2
        rect = CenterRectOnPoint([0 0 pp.size_x pp.size_y], posx, posy);
        Screen('FillRect', sci.wnd, [255,255,255], rect)

    elseif cond == 3 || cond == 4
        % Set the folder path for images
        imageFolder = 'Images';
        if cond == 3
            imagePath = fullfile(imageFolder, 'Faces.png');
        elseif cond == 4
            imagePath = fullfile(imageFolder, 'Vase_transparent.png');
        end
        
        % Load the image
        [image, ~, alpha] = imread(imagePath);
        
        % Combine RGB and alpha channels into a single 4D array
        image(:, :, 4) = alpha;
        
        % Create a texture from the image
        texture = Screen('MakeTexture', sci.wnd, image);
        
        % Enable alpha blending
        Screen('BlendFunction', sci.wnd, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
        
        % Position the image at the specified coordinates
        rect = CenterRectOnPoint([0 0 pp.size_x pp.size_y], posx, posy);
        
        % Draw the texture on the screen at the calculated position
        Screen('DrawTexture', sci.wnd, texture, [], rect);
      
    
        % for the non transparent png: 
    else
    
        % Set the folder path for images
        imageFolder = 'Images';
        if cond == 6
            imagePath = fullfile(imageFolder, 'face_contour.png');
        elseif cond == 5
            imagePath = fullfile(imageFolder, 'Vase_contour.png');
        end
        image = imread(imagePath);
        
        texture = Screen('MakeTexture', sci.wnd, image);
    
        
        % Position the images to the left and right of the central fixation dot
        rect = CenterRectOnPoint([0 0 pp.size_x pp.size_y], posx , posy);
        
        % Draw the textures on the screen at the calculated positions
        Screen('DrawTexture', sci.wnd, texture, [], rect);
    
    end

  end