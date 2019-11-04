function [thresh] = CalcHaarFeature(img, x, y, winWidth, winLen, classifier)
% [thresh] = CalcHaarFeature(img, x, y, winWidth, winLen, classifier)
%
% Funkcija koja racuna Haarovu osobinu na zadatoj poziciji x, y
%
% x, y             - pocetne koordinate osobine
% winWidth, winLen - sirina i visina osobine, respektivno
% classifier       - tip klasifikatora (1, 2, 3, 4)
%
% thresh           - izracunata vrednost osobine
%

    % first, let's get our integral image
    intImg = IntImg(img);

    % two rectangles horizontally
    if (classifier == 1)
        firstRec = [x y ((winWidth/2) - 1) (winLen - 1)];
        secondRec = [x (y+winWidth/2) ((winWidth/2)-1) (winLen-1)];
        thresh = CalcRec(intImg, firstRec) + CalcRec(intImg, secondRec);
    % two rectangles vertically
    elseif (classifier == 2)
        firstRec = [x y (winWidth-1) ((winLen/2)-1)];
        secondRec = [(x+winLen/2) y (winWidth-1) ((winLen/2)-1)];    
        thresh = CalcRec(intImg, firstRec) + CalcRec(intImg, secondRec);
    % three rectangles horizontally
    elseif (classifier == 3)
        firstRec = [x y ((winWidth/3)-1) (winLen-1)];
        secondRec = [x (y+(winWidth/3)) ((winWidth/3)-1) (winLen-1)];
        thirdRec = [x (y+(2*winWidth/3)) ((winWidth/3)-1) (winLen-1)];
        thresh = CalcRec(intImg, firstRec) - CalcRec(intImg, secondRec) + CalcRec(intImg, thirdRec);
    % three rectangles vertically
    elseif (classifier == 4)
        firstRec = [x y (winWidth-1) ((winLen/3)-1)];
        secondRec = [(x+winLen/3) y (winWidth-1) ((winLen/3)-1)];
        thirdRec = [(x+2*winLen/3) y (winWidth-1) ((winLen/3)-1)];
        thresh = CalcRec(intImg, firstRec) - CalcRec(intImg, secondRec) + CalcRec(intImg, thirdRec);
    end
end

% function that calculates integral image
function [intImage] = IntImg(img)
    intImage = cumsum(cumsum(double(img)), 2);
end

% function that calculates rectangle's sum of pixels using integral image
function [result] = CalcRec(img, points)
    row_val   = points(1,1);
    col_val   = points(1,2);
    img_width = points(1,3);
    img_len   = points(1,4);
    
    pointA = img(row_val-1, col_val-1);
    pointB = img(row_val-1, col_val+img_width);
    pointC = img(row_val+img_len, col_val-1);
    pointD = img(row_val+img_len, col_val+img_width);
    
    result = pointD + pointA - pointB - pointC;
end
