function [ResultSolution] = A_Krol_1(Map,Time,Start,Goal)
timer = tic;
%% Setting variables
StartX = Start(1); StartY = Start(2);
GoalX = Goal(1); GoalY = Goal(2);
% Map dimensions
[Height,Width] = size(Map);
% Visit matrix
Visited = uint8(zeros(Height,Width));
% Map value matrix (1 - 255)
Value = double(Map);
% Manhattan distance to GOAL matrix
Distance = Inf(Height,Width);
for k = 1:Height
    for j = 1:Width
        dist = abs(GoalY - k) + abs(GoalX - j);
        Distance(k,j) = dist;        
    end        
end
% Neighbours vectors
dx = [1; 0; -1; 0];
dy = [0; 1; 0; -1];

% Initialization values
k = 1; s = 1;
Solution(1,2) = StartX;
Solution(1,1) = StartY;
CurrentX = StartX;
CurrentY = StartY;
Visited(CurrentY,CurrentX) = 1;
StuckX = StartX;
StuckY = StartY;

MinVal = realmax;
GoalReached = 0;
totalValue = 0;
stuck = 0;
returnIndex = 1;

%% Check if START/GOAL point not on wall [ON = 1 / OFF = 0]
CorrectStartGoal = 1;
if(CorrectStartGoal == 1 && (Value(StartY,StartX) > 250 || Value(GoalY,GoalX) > 250))
    sprintf('WRONG START/GOAL POINTS')
    return
end

%% Finding Goal
while (GoalReached == 0)  
    currentTime = toc(timer);
    Limit = min(1.5,Time-0.5);
    %% Emergency exit
    if(currentTime > Limit)
        [Solution, index] = A_Krol_2(Map,Start,Goal);
        CurrentX = Solution(index,2);
        CurrentY = Solution(index,1);
        k = index;
    end
  
     %% Check if goal is reached
    if((GoalX == CurrentX) && (GoalY == CurrentY)) 
        GoalReached = 1;       
        for ind = 1:k
            ResultSolution(ind,2) = Solution(ind,1); %Y
            ResultSolution(ind,1) = Solution(ind,2); %X           
            totalValue = totalValue + Value(Solution(ind,1),Solution(ind,2));
        end
        sprintf('GOAL REACHED');
        return
    end
    
    %% Main path finding
    for i = 1:4
        if((CurrentX + dx(i)) >= 1 && (CurrentX + dx(i)) <= Width)
            cX = CurrentX + dx(i);  end
        if((CurrentY + dy(i)) >= 1 && (CurrentY + dy(i)) <= Height)
            cY = CurrentY + dy(i);  end
        if(Visited(cY,cX) == 0)
            tmpValue = Value(cY,cX) + Distance(cY,cX);
            if(tmpValue <= MinVal) 
                MinVal = tmpValue;
                nX = cX;
                nY = cY;
            end
        end
    end
    k = k+1;
    Visited(nY,nX) = 1;
    CurrentX = nX;
    CurrentY = nY;
    Solution(k,2) = CurrentX;
    Solution(k,1) = CurrentY;
    
    %% Diffrent path
    if(Solution(k-1,2) == CurrentX && Solution(k-1,1) == CurrentY)
        stuck = stuck + 1;
        k = k-1;
        if(stuck == 2) 
            stuck = 0;
            MinVal = realmax;
            CurrentX = Solution(k-1,2);
            CurrentY = Solution(k-1,1);
            StuckX(s) = CurrentX;
            StuckY(s) = CurrentY;
            if(s == 1) returnIndex = k-1; end
            k = k-1;
            s = s+1;
            continue
        end
    end
   
    %% Avoid edges
    if(Value(CurrentY,CurrentX) > 20)
        k = k-1;
        CurrentX = StuckX(1);
        CurrentY = StuckY(1);
        k = returnIndex;
        s = 1;
        % predecessor with free neighbour
        flag = 0;
        while(flag == 0 && k > 2)
            for i = 1:4
                if((CurrentX + dx(i)) >= 1 && (CurrentX + dx(i)) <= Width)
                    cX = CurrentX + dx(i);  end
                if((CurrentY + dy(i)) >= 1 && (CurrentY + dy(i)) <= Height)
                    cY = CurrentY + dy(i);  end
                if(Visited(cY,cX) == 0 && Value(cY,cX) < 20)
                    flag = 1;
                end
            end
            CurrentX = Solution(k-1,2);
            CurrentY = Solution(k-1,1);
            k = k-1;
        end        
end    

end
end