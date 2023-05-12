format short
clear all
clc

noofvariables=3;
c=[-1 3 -2];
info=[3 -1 2;-2 4 0 ; -4 3 8];
b=[7;12;10];
s=eye(size(info,1));
A=[info s b];
cost=zeros(1,size(A,2));
cost(1:noofvariables)=c;

BV=1+noofvariables:size(A,2)-1;
zjcj=cost(BV)*A-cost;
zcj=[zjcj; A];
simplexTable=array2table(zcj);
simplexTable.Properties.VariableNames(1:size(A,2))={'x1','x2','x3','s1','s2','s3','sol'};

run=true; 
while run
    if any(zjcj<0)
        fprintf("current bfs is not optimal\n")
        fprintf('============next iteration===========')
        disp('old basic variables');
        disp(BV);

        zc=zjcj(1:end-1);
        [EnterCol,Pvt_Col]=min(zc);
        sol=A(:,end);
        column=A(:,Pvt_Col);
        if all(column<=0)
            error('lpp is unbounded')
        else
            for i=1:size(column,1)
                if column(i)>0
                    ratio(i)=sol(i)./column(i);
                else
                    ratio(i)=inf;
                end 
            end
            [MinRatio , pvt_row]=min(ratio);
        end

        BV(pvt_row)=Pvt_Col;
        disp('new basic variable=');
        disp(BV);

        pvt_key=A(pvt_row,Pvt_Col);
        A(pvt_row,:)=A(pvt_row,:)./pvt_key;

        for i=1:size(A,1)
            if i~=pvt_row
                A(i,:)=A(i,:)-A(i,Pvt_Col).*A(pvt_row,:);
            end
            zjcj=zjcj-zjcj(Pvt_Col).*A(pvt_row,:);
        end
zcj=[zjcj;A];
table=array2table(zcj);
table.Properties.VariableNames(1:size(A,2))={'x1','x2','x3','s1','s2','s3','sol'}

BFS=zeros(1,size(A,2));
BFS(BV)=A(:,end);
BFS(end)=sum(BFS.*cost);
current_BFS=array2table(BFS);
current_BFS.Properties.VariableNames(1:size(A,2))={'x1','x2','x3','s1','s2','s3','sol'}
    end 
end

      
