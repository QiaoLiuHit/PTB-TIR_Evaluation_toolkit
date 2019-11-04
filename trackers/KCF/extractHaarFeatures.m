function [features] = extractHaarFeatures(image)
% [features] = extractFeatures(image)
% 
% Funkcija koja ekstraktuje sve osobine definisanog tipa na zadatoj slici
%
% image    - slika iz koje zelimo osobine
%
% features - niz osobina
%

%init
featureTypes = [1 2; 2 1; 1 3; 3 1];
windowSize = 19; % we use training examples that are 19x19
count = 1;
    for i=1:4
        sizeX = featureTypes(i,1); % x value (length)
        sizeY = featureTypes(i,2); % y value (width)
        % for all pixels inside the selected feature
        for x = 2:windowSize-sizeX
            for y = 2:windowSize-sizeY
                % for each width and length possible in our small window
                for winLen = sizeX:sizeX:windowSize-x
                    for winWidth = sizeY:sizeY:windowSize-y
                   %     fprintf('Calculating best threshold for selected feature...\n')
                    %    fprintf('x: %e\n', x);
                    %    fprintf('y: %e\n', y);
                   %     fprintf('width: %e\n', winWidth);
                   %     fprintf('length: %e\n', winLen);
                   %     fprintf('ClassifierType: %e\n', i);
                        features(count) = CalcHaarFeature(image, x, y, winWidth, winLen, i);
                    %    info(count,:) = [x y winWidth winLen i];
                        count= count+ 1;
                    end
                end
            end
        end
    end
end