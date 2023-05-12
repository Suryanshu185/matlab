format short
clear all
clc
%% input parameters 
noofvars=3;
c=[-1 3 -2];
info=[3 -1 2;-2 4 0;-4 3 8];
b=[7;12;10];    
s=eye(size(info,1));

A=[info s b];

cost=zeros(1,size(A,2));
cost(1:noofvars)=c;

%%constraint bv
BV=1+noofvars:size(A,2)-1

%%calculate Zj-Cj
ZjCj = cost(BV)*A-cost;

%%to print the table
ZCj=[ZjCj;A];
simplexTable= array2table(ZCj)
simplexTable.Properties.VariableNames(1:size(A,2))={'x1','x2','x3','s1','s2','s3','sol'}

%%simplex table start
run=true
while run
%%check if any negative value is present 

if any(ZjCj<0);
    fprintf('the current BFS is not optimal \n')
    fprintf('\n ============next iteration result ====================\n')

    disp('old Basic Variable (BV) =');
    disp(BV); 
    
    %%finding entering variable
    ZC=ZjCj(1:end-1);
    [EnterCol,Pvt_Col]=min(ZC)

    %%finding leaving variable
    sol= A(:,end);
    column=A(:,Pvt_Col);
    if all(column<=0)
        error('LPP is unbounded')
    else
    for i=1:size(column,1)
        if column(i)>0
            ratio(i)=sol(i)./column(i);
        else
            ratio(i)=inf;
        end
    end
    
    %%finding the minimum
    [MinRatio,pvt_row] = min(ratio);
    end
    BV(pvt_row)=Pvt_Col;
    disp('new basic variable =');
    disp(BV);

    %%Pivot key 
    pvt_key=A(pvt_row,Pvt_Col);

    %% update the table for next iteration 
    A(pvt_row,:)=A(pvt_row,:)./pvt_key;
    for i=1:size(A,1)
        if i~=pvt_row
            A(i,:)=A(i,:)-A(i,Pvt_Col).*A(pvt_row,:);
        end
        ZjCj =ZjCj-ZjCj(Pvt_Col).*A(pvt_row,:);
    end
%% for printing purpose
ZCj=[ZjCj;A];
table=array2table(ZCj);
table.Properties.VariableNames(1:size(ZCj,2))={'x1', 'x2','x3','s1','s2','s3','sol'}

BFS=zeros(1,size(A,2));
BFS(BV)=A(:,end);
BFS(end)=sum(BFS.*cost);
current_BFS=array2table(BFS);
current_BFS.Properties.VariableNames(1:size(A,2))={'x1','x2','x3','s1','s2','s3','sol'}
else
    run=false;
    disp('optimal solution reached')
end

end