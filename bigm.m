format short 
clc
clear all
M=1000;
cost=[5 3 0 0 0 -M 0];
a=[1 1 1 0 0 0;5 2 0 1 0 0;2 8 0 0 -1 1];
b=[2;10;12];
artifical_var=[6];
BV=[3 4 6];

A=[a b];
Var={'x1','x2','s1','s2','s3','A3','solution'};
ZjCj=cost(BV)*A-cost;
simplex_table=[ZjCj; A];
array2table(simplex_table,'VariableNames',Var)
RUN=true;
while RUN
if any(ZjCj(1:end-1)<0) 
fprintf('BFS solution is not optimal.\n');
fprintf('OLD BASIC VARIABLES = ');
disp(BV);
fprintf('=========THE NEXT ITERATION RESULTS=========');
ZC=ZjCj(1:end-1);
[Enter_value,pvt_col]=min(ZC)

sol=A(:,end);
column=A(:,pvt_col);
if (column<=0)
error('LPP is unbounded');
else 
for i=1:size(column,1)
if (column(i)>0)
ratio(i)=sol(i)./column(i);
else
ratio(i)=inf;
end
end
[leaving_value,pvt_row]=min(ratio)
end

BV(pvt_row)=pvt_col;
disp('NEW BASIC VARIABLES = ')
disp(BV)

pvt_key=A(pvt_row,pvt_col)

A(pvt_row,:)=A(pvt_row,:)/pvt_key;
for i=1:size(A,1)
if (i~=pvt_row)
A(i,:)=A(i,:)-A(i,pvt_col).*A(pvt_row,:) ;
end
end
ZjCj=ZjCj-ZjCj(pvt_col).*A(pvt_row,:);

next_table=[ZjCj;A];
array2table(next_table,'VariableNames',Var)

BFS=zeros(1,size(A,2));
BFS(BV)=A(:,end);
BFS(end)=sum(BFS.*cost);
Current_BFS=array2table(BFS,'VariableNames',Var)
else
RUN=false;
if any (BV==artifical_var(1))
error('Solution is infeasible')
else
disp('Optimal Solution Reached--Obtained table is optimal')
disp('------------------FINAL SOLUTION------------------')
disp(Current_BFS)
fprintf('Optimal value is %f\n',ZjCj(end))
end
end
end
