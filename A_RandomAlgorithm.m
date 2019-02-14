function [Solution] = A_RandomAlgorithm(Map,Time,Start,Goal)


% An example of random algorithm

MapSizeY = length(Map(:,1));
MapSizeX = length(Map(1,:));

GoalX = Goal(1) ;               
GoalY = Goal(2) ;       

Solution(1,:) = [Start(1),Start(2)];      % Solution will be stored here
index = 1;                      
EndingCriterion = 0;

    while ( EndingCriterion ~= 1)
          if(Solution(index,1) ~= GoalX && Solution(index,2) ~= GoalY)     % until we hit the straight path to the goal....
              if(rand() > 0.5)
                        Solution(index+1,1) = Solution(index,1) + 1*sign(GoalX - Solution(index,1));        % Make one step in x direction
                        Solution(index+1,2) = Solution(index,2);
              else
                        Solution(index+1,2) = Solution(index,2) + 1*sign(GoalY - Solution(index,2));         % or make one step in y direction
                        Solution(index+1,1) = Solution(index,1);
              end
              
              
          elseif(Solution(index,1) ~= GoalX)                   % later, follow until in target...
              Solution(index+1,1) = Solution(index,1) +  1*sign(GoalX - Solution(index,1));
              Solution(index+1,2) = Solution(index,2);
          else
              Solution(index+1,2) = Solution(index,2) + 1*sign(GoalY - Solution(index,2));
              Solution(index+1,1) = Solution(index,1);
          end
          
          index = index + 1;
          
          if(Solution(index,1) == GoalX && Solution(index,2) == GoalY)      % If goal has been reached
              EndingCriterion = 1;
              return;
          else
          end
          
    end

end

