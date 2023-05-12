% Algebraic method

% Phase 1: Input the matrix as C,A,b
% Phase 2: Define the number of constraints (m) &
%          No. of variables(n). Make sure n>m
% Phase 3: choose nCm basic variables & the 
%          the pairs of basic variables
% Phase 4: Construct a basic matrix B from A
% Phase 5: Find the basic solution as XB = b^-1 A
%         and check
%             1)if XB > 0 then non-degenerate BFS
%             2)if XB = 0 then degenerate BFS
%             3)if XB < 0 then infeasible solution(not a BFS)
% Phase 6: Compute the objective function
% Phase 7: Print all the solutions

% Max Z = 2x1 + 3x2 + 4x3 + 7x4
% s.t.
%     2x1 + 3x2 - x3 + 4x4 = 8
%      x1 - 2x2 + 6x3 -7x4 =-3
%      xi>=0 

% Phase 1 input parameters
C=[2,3,4,7];
A=[2,3,-1,4; 1,-2,6,-7];
b=[8 ; -3];

% Phase 2: No. of constraints and variables
m=size(A,1); % no. of constraints
n=size(A,2); % no. of variables

% Phase 3: compute nCm BFS
nv=nchoosek(n,m); %no. of basic solution
t= nchoosek(1:n,m);

% Phase 4: construct the Basic solution 
sol=[];     %default solution is zero
if n>=m
    for i=1:nv
        y = zeros(n,1);
        x = A(:,t(i,:))\b;
%        check feasibility condition
       if all(x>=0 & x~=inf &x~=-inf)
         y(t(i,:)) = x;
         sol=[sol y];
       end
     end
    else
        error('Equation is larger than Variables')
end
% Phase 5: objective function
z= C*sol;
%Phase 6: finding optimal value
[zmax,zind] = max(z);
BFS = sol(:,zind);
%Phase 7: print all the solutions
optval = [BFS' zmax];   %index corresponding to max value
OPTIMAL_BFS = array2table(optval);%print in table
OPTIMAL_BFS.Properties.VariableNames(1:size(OPTIMAL_BFS,2)) = {'x_1','x_2','x_3','x_4','value_of_z'}
  
