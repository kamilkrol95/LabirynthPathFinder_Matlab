function [navVect] = A_RandomControl(Map,Time,Start,Goal)

a = tic;

% An example of random algorithm with time control

MapSizeY = length(Map(:,1));
MapSizeX = length(Map(1,:));

GoalX = Goal(1) ;             
GoalY = Goal(2) ; 

Solution(1,:) = [Start(1),Start(2)];              % Final solution will be stored here
Quality = 0;                        % Current-best solution estimate will be stored here
Instance = 1;
Time = Time - 0.5;                  % For a safety margin

while(toc(a) < Time)                % While there's time left...             
    clear Solution          % Clear previous solution
    Solution(1,:) = [Start(1),Start(2)];  % Initialize it
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
              break;
          else
          end
          
    end
    
    % Evaluate obtained solution
    CostSummary = 0;
        for k = 1:length(Solution)
            CostSummary = CostSummary + cast(Map(Solution(k,2),Solution(k,1)),'double');    % Coordinates are switched when it comes to matrices
        end
        
    if(Instance == 1)               % If a solution is obtained for the first time, save it
        Quality = CostSummary;
        Instance = Instance + 1;
        navVect = Solution;
    else
       if(CostSummary < Quality)    % Otherwise if current solution is better than best obtained...
           Quality = CostSummary;   % Preserve its cost
           Instance = Instance + 1;
           navVect = Solution;  % And save it
       else
           Instance = Instance + 1;     % Increase a counter
       end
        
    end
   
end
end

