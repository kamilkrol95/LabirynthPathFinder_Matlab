function [Solution] = A_SimpleAlgorithm(Map,Time,Start,Goal)
a = tic;
clear Solution

% An example of straight line algorithm

MapSizeY = length(Map(:,1));
MapSizeX = length(Map(1,:));

GoalX = Goal(1) ;               
GoalY = Goal(2) ;      

Solution(1,:) = [Start(1),Start(2)];      % Solution will be stored here
index = 1;                      
EndingCriterion = 0;

    while ( EndingCriterion ~= 1)
          if(abs(GoalX - Solution(index,1)) > abs(GoalY - Solution(index,2))) 
              Solution(index+1,1) = Solution(index,1) + 1*sign(GoalX - Solution(index,1));
              Solution(index+1,2) = Solution(index,2);
          else
              Solution(index+1,2) = Solution(index,2) + 1*sign(GoalY - Solution(index,2));
              Solution(index+1,1) = Solution(index,1);
          end
          index = index + 1;
          
          if(Solution(index,1) == GoalX && Solution(index,2) == GoalY)
              EndingCriterion = 1;
          else
          end
          
    end

end

