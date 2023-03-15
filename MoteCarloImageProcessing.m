classdef MoteCarloImageProcessing < handle
    properties
        image
        boundaries
    end
    
    methods 
        function obj = MoteCarloImageProcessing()
            import Utility.*          
        end
                
        function imageResult = toBinarize(obj, image)
            obj.image = image;
            % Convert image to grayscale
            imageResult = rgb2gray(obj.image);

            % Invert Threshold Binaries
            imageResult = imbinarize(imageResult);
            imageResult = 1 - imageResult;
            obj.detectBoundaries(imageResult);
        end
        
        function [x_coor, y_coor] = detectBoundaries(obj, BinarizeImage)
            obj.boundaries = bwboundaries(BinarizeImage);
            obj.boundaries = obj.boundaries{1};
            x_coor = obj.boundaries(:, 2);
            y_coor = obj.boundaries(:, 1);            
        end
        
        function [ pos_x, pos_y, titik, hasil] = calculate(obj,min, max, n)
            tepi = obj.boundaries;
            x_tepi = tepi(:, 2);
            y_tepi = tepi(:, 1);
            
            titik = 0;
            for i = 1:n
                try
                    x_acak = Utility.randNum(min,max);
                    y_acak = round(Utility.randNum(min,max));
                catch
                    x_acak = 0;
                    y_acak = 0;
                    disp('Something went wrong')
                    break
                end
                [xMaxValue, xMinValue] = Utility.maxMin(x_tepi);
                [yMaxValue, yMinValue] = Utility.maxMin(y_tepi);
                if (x_acak > xMinValue && x_acak < xMaxValue)
                    if (y_acak > yMinValue && y_acak < yMaxValue)
                        x_target = find(x_tepi == y_acak);
                        [xTargetMaxValue, xTargetMinValue] = Utility.maxMin(x_target);
                        if (x_acak > xTargetMinValue && x_acak < xTargetMaxValue)
                            titik = titik + 1;
                        end
                    end
                end
                pos_x(i) = x_acak;
                pos_y(i) = y_acak;
%                 
            end
            [panjang, lebar] = size(obj.image);
            hasil = panjang * lebar * (titik/n);
        end
        
        function checkBoxSet(obj, Checkbox, from, to)
            val = get(Checkbox, 'value');
            if val
                [panjang, lebar] = size(obj.image);
                set(from, 'string', panjang)
                set(to, 'string', lebar)
                set(from, 'enable', 'off')
                set(to, 'enable', 'off')
            else
                set(from, 'enable', 'on')       
                set(to, 'enable', 'on')
            end
        end
        
        
        function status(obj)
            try
                [int2str(panjang), int2str(lebar)] = size(obj.image);
                disp('working on ' + panjang + ' and ' + lebar + ' image')
            catch
                disp('something gone wrong')         
            end
        end
        
       
                 
    end
end
