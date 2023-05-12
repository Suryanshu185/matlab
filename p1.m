format short
clear all
clc
noofvars=3;
c=[-1 3 -2];
info=[3 -1 2;-2 4 0;-4 3 8];
b=[7;12;10];    
s=eye(size(info,1));
A=[info s b];
cost=zeros(1,size(A,2));
cost(1:noofvars)=c;

BV=1+noofvars:size(A,2)-1;
ZjCj = cost(BV)*A-cost;
ZCj=[ZjCj;A];
simplexTable= array2table(ZCj)
simplexTable.Properties.VariableNames(1:size(A,2))={'x1','x2','x3','s1','s2','s3','sol'}
run=true
while run

if any(ZjCj<0)
    fprintf('the current BFS is not optimal \n')
    fprintf('\n ============next iteration result ====================\n')
    disp('old Basic Variable (BV) =');
    disp(BV); 

    ZC=ZjCj(1:end-1);
    [EnterCol,Pvt_Col]=min(ZC);
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

    [MinRatio,pvt_row] = min(ratio);

    end

    BV(pvt_row)=Pvt_Col;
    disp('new basic variable =');
    disp(BV);

    pvt_key=A(pvt_row,Pvt_Col); 
    A(pvt_row,:)=A(pvt_row,:)./pvt_key;

    for i=1:size(A,1)
        if i~=pvt_row
            A(i,:)=A(i,:)-A(i,Pvt_Col).*A(pvt_row,:);
        end
        ZjCj =ZjCj-ZjCj(Pvt_Col).*A(pvt_row,:);
    end

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