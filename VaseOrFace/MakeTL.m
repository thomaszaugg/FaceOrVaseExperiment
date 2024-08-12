% Make judgement Experiment trial list
%
%################# H I S T O R Y #####################
% 26.04.2024 (LS = Lisa Schwetlick, LPSY@EPFL):
%   * First version.

function TL_org = MakeTL(short)
    % conditions are with the following luminescence
        % face; vase;   background    (vernier always 120)
    % 1:  100   140     100      
    % 2:  100   140     120  
    % 3:  100   140     140  
    % 4:  80    160     80  
    % 5:  80    160     120  
    % 6:  80    160     160  
    % 7:  60    180     60  
    % 8:  60    180     120 
    % 9:  60    180     180 

    %% Original
    if short 
        nrep = 1;
        conds_o = [4,5,6,7,8,9];
    else
        nrep = 20;
        conds_o = [4,5,6,7,8,9];
    end

    % then sides randomly
    c1 = repmat(conds_o, 1, nrep);
    c = Shuffle(c1, 1);
    TL_org = c;

end
