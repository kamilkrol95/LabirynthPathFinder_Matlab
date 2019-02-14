function[CostSummary] = PathEvaluation(Map,Start,Goal,Solution,color)


hold on

% 
% for z = 1:length(Solution)
%     plot(Solution(z,1),Solution(z,2),color); 
%     hold on
% end

plot(Solution(:,1),Solution(:,2),color);

% Cost estimation
CostSummary = 0;
for k = 1:length(Solution)
    CostSummary = CostSummary + cast(Map(Solution(k,2),Solution(k,1)),'double');    % Coordinates are switched when it comes to matrices
end

Validity = 1;
% Validity estimation
if(Solution(1,1) ~= Start(1) || Solution(1,2) ~= Start(2) || Solution(length(Solution),1) ~= Goal(1) || Solution(length(Solution),2) ~= Goal(2))
    Validity = 0;
    sprintf('error 1')
else
end

for p = 2:length(Solution)
    stepX = Solution(p,1) - Solution(p-1,1);
    stepY = Solution(p,2) - Solution(p-1,2);
    if(abs(stepX) == 1)         % If a step in x direction is equal to 1 or -1
        if(abs(stepY) == 0)      
                                % stepY must be equal to 0
        else
           Validity = 0;        % Otherwise, the trajectory is invalid         
            sprintf('error 2')
        end
    elseif(stepX == 0)          % If a step in x direction is equal to 0
        if(abs(stepY) == 1)     
                                % StepY must be equal to 1 or -1
        else
            Validity = 0;       % Otherwise, you know.
            sprintf('error 3')
        end
    else                        % StepX can be only 1, -1 or 0!
        Validity = 0;
        sprintf('error 4')
    end
            
end

if(Validity == 0)

    CostSummary = 0;           
else
end

