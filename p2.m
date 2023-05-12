format short
clear all
clc

numvars=3;
up=[-1 3 -2];
left=[3 -1 2;-2 4 0 ; -4 3 8];
right=[7;12;10];

s=eye(size(left,1));
A=[left s right];

cost=zeros(1,size(A,2));
cost(1:numvars)=up;

BV=1+numvars:size(A,2)-1;
zjcj=cost(BV)*A-cost;
zcj=[zjcj ;A];
simplextable=array2table(zcj);
simplextable.Properties.VariableNames(1,size(zcj,2))={'x1','x2','x3','s1','s2','s3','sol'};

run = true
while run
    if any(zjcj<0)
        fprintf('current BFS is not optimal');
        fprintf('\n next iteration\n');
        disp('old basic variables =');
        disp(BV);

        zc=zjcj(1:end-1);
        [enterval , pvtcol]= min(zc);
        sol=A(:,end);
        column=A(:,pvtcol);
        if all (column<=0)
            error('LPP is unbounded')
            for i=1:size(column,1)
                if column(i)>0
                    ratio(i)=sol(i)./column(i);
                else
                    ratio(i)=inf;
                end 
            end
            [MinRatio , pvt_row]=min(ratio);
        end
        



                
            
