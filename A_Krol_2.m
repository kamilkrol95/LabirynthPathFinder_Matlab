function [Solution, index] = A_Krol_2(Map,Start,Goal)

%% Setting variables
StartX = Start(1);
StartY = Start(2);
GoalX = Goal(1);
GoalY = Goal(2);
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
k = 1;
Solution(1,2) = StartX;
Solution(1,1) = StartY;
CurrentX = StartX;
CurrentY = StartY;
Visited(CurrentY,CurrentX) = 1;

MinVal = realmax;
GoalReached = 0;
stuck = 0;

%% Finding Goal
while (GoalReached == 0)      

     %% Check if goal is reached
    if((GoalX == CurrentX) && (GoalY == CurrentY)) 
        GoalReached = 1;
        index = k;
        sprintf('GOAL REACHED WITH EE');
    end
    
    %% Main path finding
    for i = 1:4
        if((CurrentX + dx(i)) >= 1 && (CurrentX + dx(i)) <= Width)
            cX = CurrentX + dx(i);  end
        if((CurrentY + dy(i)) >= 1 && (CurrentY + dy(i)) <= Height)
            cY = CurrentY + dy(i);  end
        if(Visited(cY,cX) == 0)
            tmpValue = Value(cY,cX)*0.01 + Distance(cY,cX);
            if(tmpValue < MinVal) 
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
            for i = 1:4
                if((CurrentX + dx(i)) >= 1 && (CurrentX + dx(i)) <= Width)
                    cX = CurrentX + dx(i);  end
                if((CurrentY + dy(i)) >= 1 && (CurrentY + dy(i)) <= Height)
                    cY = CurrentY + dy(i);  end           
                if(Visited(cY,cX) == 0)
                    tmpValue = Distance(cY,cX);
                    if(tmpValue <= MinVal) 
                        MinVal = tmpValue;
                        nX = cX;
                        nY = cY;
                    end 
                end
            end
            continue
        end
    end
    
end
end