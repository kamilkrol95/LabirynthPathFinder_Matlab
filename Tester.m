clear all
close all;
clc

% Load a map
Map = MapPreparation('Maps/Map2.png');

Start =[50,370];
Goal = [385,100];

% Define a time limit
Time = 5;

TimeObtained = [];

% Start one of functions (straight line)
fprintf('\nTesting simple algorithm\n');
SolutionTimer = tic;                                            % Start timer
VectSimple = A_SimpleAlgorithm(Map,Time,Start,Goal) ;          % Start the algorithm
TimeObtained(1) = toc(SolutionTimer);
if(TimeObtained(1) > Time)                                      % Check if time limit was exceeded
    fprintf('Time exceeded\n');
else end

% Start second function (random algorithm)
fprintf('\nTesting random algorithm\n');
SolutionTimer = tic; 
VectRandom = A_RandomAlgorithm(Map,Time,Start,Goal);
TimeObtained(2) = toc(SolutionTimer);
if(TimeObtained(2) > Time)
    fprintf('Time exceeded\n');
else end

% Start third function (random algorithm that utilizes full time avilable)
fprintf('\nTesting random algorithm with time control\n');
SolutionTimer = tic; 
VectRC = A_RandomControl(Map,Time,Start,Goal);
TimeObtained(3) = toc(SolutionTimer);
if(TimeObtained(3) > Time)
    fprintf('Time exceeded\n');
else end

% Start fourth function (directed algorithm - choice of better option out of two)
fprintf('\nTesting directed algorithm\n');
SolutionTimer = tic; 
VectDS = A_DirectedSimpleAlgorithm(Map,Time,Start,Goal);
TimeObtained(4) = toc(SolutionTimer);
if(TimeObtained(4) > Time)
    fprintf('Time exceeded\n');
else end

% % Start fifth function (A lazy algorithm that generates simple trajectory
% % but in 10 seconds)
% fprintf('\nTesting lazy algorithm\n');
% SolutionTimer = tic; 
% VectLazy = A_LazyAlgorithm(Map,Time,Start,Goal);
% TimeObtained(5) = toc(SolutionTimer);
% if(TimeObtained(5) > Time)
%     fprintf('Time exceeded\n');
% else end

fprintf('\nTesting Krol_Mucha algorithm\n');
SolutionTimer = tic; 
VectorOur = A_Krol_1(Map,Time,Start,Goal);
TimeObtained(5) = toc(SolutionTimer);
if(TimeObtained(5) > Time)
    fprintf('Time exceeded\n');
else end

% Evaluate results returned by all three algorithms
TimeOfTravel(1,:) = PathEvaluation(Map,Start,Goal,VectSimple,'-b');
TimeOfTravel(2,:) = PathEvaluation(Map,Start,Goal,VectRandom,'-r');
TimeOfTravel(3,:) = PathEvaluation(Map,Start,Goal,VectRC,'-y');
TimeOfTravel(4,:) = PathEvaluation(Map,Start,Goal,VectDS,'-m');
TimeOfTravel(5,:) = PathEvaluation(Map,Start,Goal,VectorOur,'-c');

fprintf('\n\n Time used for computations by tested algorithms:');
TimeObtained'
fprintf('\n\n Quality of obtained path');
TimeOfTravel

hold off;

