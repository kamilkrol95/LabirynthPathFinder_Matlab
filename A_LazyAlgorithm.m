function [Solution] = A_LazyAlgorithm(Map,Time,Start,Goal)


pause(10);  % A lazy algorithm is lazy...

MapSizeY = length(Map(:,1));
MapSizeX = length(Map(1,:));

GoalX = Goal(1) ;                % The goal is at the end of the map
GoalY = Goal(2) ;    

Solution(1,:) = [Start(1),Start(2)];      % Solution will be stored here, in a form of consecutive steps
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

