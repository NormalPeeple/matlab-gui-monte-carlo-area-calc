classdef Utility   
    methods(Static)        
        function filename =  getInputFile(currentDir)
            try
                [file, path] = uigetfile({'*.jpg; *.JPG; *.jpeg; *.JPEG; *.img; *.IMG; *.png; *.PNG'}, 'Pilih Gambar', currentDir);
                filename = fullfile(path, file);
            catch
                filename = '';
            end
        end
        
        function randomNumber = randNum(min,max)
            randomNumber = rand*(max-min) + min;
        end
        
        function setter(handler, type, value)
            set(handler, type, value)
        end
        
        function[maxVal, minVal] = maxMin(array)
            maxVal = max(array);
            minVal = min(array);
        end
        
        function checkPlotIfExist(axesHandle,x_cor, y_cor, dir)
            if isempty(dir) == 0
                axes(axesHandle); 
                cla reset;
                plot(axesHandle, x_cor, y_cor)                
            else
                plot(axesHandle, x_cor, y_cor)
            end
        end
        

        
    end
end