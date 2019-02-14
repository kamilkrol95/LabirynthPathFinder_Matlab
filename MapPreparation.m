function[Map] = MapPreparation(name)

close all

Map = imread(name);     % Loading of a map
Map = rgb2gray(Map);    % Conversion to a grayscale

MapSizeY = length(Map(:,1));    % Size definition
MapSizeX = length(Map(1,:));

for x = 1:length(Map(:,1))
    for y = 1:length(Map(1,:))
        Map(y,x) = Map(y,x);        
        if(Map(y,x) <=0)
            Map(y,x) = 1;           % 0 cost should not be allowed
        elseif(Map(y,x) >= 255)
            Map(y,x) = 255;         % Same for higher costs
        else
        end
        
        
    end
end

imshow(Map)                         % Show the map

end