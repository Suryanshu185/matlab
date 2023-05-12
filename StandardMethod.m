% standard form of LPP
% 1)Right hand side of the constraint must be positive
% 2)All constraints must be of equality form.
% 3)All decision variables must be >= 0 form

% Maximize Z = 2x1 - 3x2 + 6x3
% s.t
%     x1 - 3x3        >=  4
%     2x1 -8x2 + 3x3  <=  4
%     x1 + x2         >= -7
%     x1,x2,x3        >=  0

% STANDARD FORM
% Maximize Z = 2x1 - 3x2 + 6x3
% s.t
%     x1 - 3x3 -s1         =  4
%     2x1 -8x2 + 3x3 +s2   =  4
%     -x1 - x2 + s3        =  7
%     x1,x2,x3,s1,s2,s3   >=  0

% Phase 1:Input parameters.
% Phase 2:Identify <=and >= and = type constraints
% Phase 3:Introduce slack and surplus varibles.
% Phase 4:Write the standard form

% maximize Z=3x1 + 5x2
% subject to 
%             x1 + 2x2 <= 2000
%             x1 + x2  <= 1500
%                  x2  <= 600
%             x1,x2    >= 0
format short
clear all
clc
% Phase 1:Input parameters
C=[3,5];
A=[1,2;1,1;0,1];
b=[2000;1500;600];

% Phase 2: identify <= , = , >= 
%          type constraints
IneqSign=[0 0 1]; %0 for <= sign
                  %1 for >= sign
% 
% Phase 3: Introduce the slack and
%          surplus variables
s=eye(size(A,1));

ind = find(IneqSign > 0);
s(ind,:) = -s(ind,:);

% Phase 4: Write the standard form
% express objective function
ObjFns = array2table(C); %for representing objective fn

ObjFns.Properties.VariableNames(1:2) = {'x_1','x_2'};
                                

%representaiton of constraint
Mat = [A s b];
Constraint = array2table(Mat);
Constraint.Properties.VariableNames(1:size(Mat,2)) = {'x_1','x_2','s_1','s_2','s_3','Sol'}



