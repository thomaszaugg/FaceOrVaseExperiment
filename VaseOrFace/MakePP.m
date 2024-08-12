% computes the effective sizes needed for display
%
%
%################# H I S T O R Y #####################
% 26.04.2024 (LS = Lisa Schwetlick, LPSY@EPFL):
%   * First version.

function pp = MakePP(p,pp)
    %% --- Unit conversion and rounding of parameter values.
    %      pp-units are usually pixels, refresh frames, color values ex [0,255]. 
    %      Values all possibly rounded. Most pp names are the same as p names.
    pp.BgLum = min(255, round(p.BgLum/100*255));

    pp.VernierDuration = max(1, round(lpsy.msec2frame(p.VernierDuration)));
    pp.PrimerDuration = max(1, round(lpsy.msec2frame(p.PrimerDuration)));
    pp.IntermediateDuration = max(1, round(lpsy.msec2frame(p.IntermediateDuration)));

    pp.LineColor = p.LineColor;
    pp.fc_lc = p.fc_LineColor;
    pp.fc_size = lpsy.arcsec2pix(p.fc_size);
    pp.fc_lw = lpsy.arcsec2pix(p.fc_lw);
    %luma = 0.299 * p.col(1) + 0.587 * p.col(2) + 0.114 * p.col(3);
    %pp.bgcolFC = [luma, luma, luma]*p.fc_bg_lumdiff;
    
    pp.periph_offs = lpsy.arcdeg2pix(p.periph_offs);
    pp.vert_offs = lpsy.arcdeg2pix(p.vert_offs);
    pp.size_x = lpsy.arcdeg2pix(p.size_x);
    pp.size_y = lpsy.arcdeg2pix(p.size_y);

    pp.boarder1_x = lpsy.arcdeg2pix(p.boarder1)*2+pp.size_x; 
    pp.boarder1_y = lpsy.arcdeg2pix(p.boarder1)*2+pp.size_y; 
    pp.boarder2_x = lpsy.arcdeg2pix(p.boarder2)*2+pp.size_x; 
    pp.boarder2_y = lpsy.arcdeg2pix(p.boarder2)*2+pp.size_y; 
    pp.color_boarder = p.color_boarder;


    %--- For the sake of simplicity, we never use anti-aliasing along the vertical
    %    axis, and we always center the stimulus between screen pixels vertically.
    %    This requires the vernier gap to have an even number of pixels.
    if p.VernierGap==0
        pp.VernierGap = 0;
    else
        pp.VernierGap = max(2, 2*round(lpsy.arcsec2pix(p.VernierGap)/2));
    end
    pp.VernierLength = max(pp.VernierGap+2, 2*round(lpsy.arcsec2pix(p.VernierLength)/2));
    pp.VernierOffset = lpsy.arcsec2pix(p.VernierOffset);
    pp.LineWidth = max(1, lpsy.arcsec2pix(p.LineWidth));

    pp.fc_lc = p.fc_LineColor;
    pp.fc_size = lpsy.arcsec2pix(p.fc_size);
    pp.fc_lw = max(1, lpsy.arcsec2pix(p.fc_lw));
    pp.periph_offs = lpsy.arcdeg2pix(p.periph_offs);
    
    %--- Possibly expand a single value to a 2-value vector and round up the value(s).
    pp.PosJitter = ceil(p.PosJitter(:))' .* [1,1];

    
    if p.ResponseTimeout==0
        pp.ResponseTimeout = 9999;
    else
        pp.ResponseTimeout = p.ResponseTimeout;
    end
end