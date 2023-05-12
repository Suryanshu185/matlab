% phase1 input parameters
% phase2 plot the graph
% phase3 find corner point
% phase4 find point of intersection
% phase5 write all corner points (from 3 & 4)
% phase6 find feasible region
% phase7 compute objective function
% phase8 find optimal one

% maximize Z=3x1 + 5x2
% subject to 
%             x1 + 2x2 <= 2000
%             x1 + x2  <= 1500
%                  x2  <= 600
%             x1,x2    >= 0
 
format short %calculation of upto 4 decimal places
clear all 
clc
%Phase 1: input parameters
C=[3,5]; %cost of objective function
A=[1 2;1 1;0 1];%constraints coefficient matrix
b=[2000;1500;600];%R.H.S of constraints

%phase 2: plotting the graph
y1 = 0:1:max(b);
x21 = (b(1) - A(1,1).*y1)./A(1,2);
x22 = (b(2) - A(2,1).*y1)./A(2,2);
x23 = (b(3) - A(3,1).*y1)./A(3,2);


x21=max(0,x21);
x22=max(0,x22);
x23=max(0,x23);

plot(y1,x21,'r',y1,x22,'k',y1,x23,'b');
xlabel('Values of x1');
ylabel('Values of x2');
title('x1 vs x2')
legend('x1 + 2x2 = 2000','x1+x2 = 1500','x2=600')
grid on

% Phase 3: find corner point with axes
  cx1 = find(y1==0); %points with x1 axis
  c1  = find(x21==0);%points with x2 axis
Line1 = [y1(:,[c1 cx1]) ; x21(:,[c1 cx1])]';

  c2  = find(x22==0);
Line2 = [y1(:,[c2 cx1]) ; x22(:,[c2 cx1])]';

  c3  =  find(x23==0);
Line3 = [y1(:,[c3 cx1]) ; x23(:,[c3 cx1])]';

corpt = unique([Line1; Line2; Line3],'rows');

% Phase 4: Find point of intersection
HG=[];
for i=1:size(A,1)
    hg1=A(i,:);
    b1=b(i,:);
    for j=i+1:size(A,1)
        hg2=A(j,:);
        b2=b(j,:);
        Aa = [hg1; hg2];
        Bb = [b1;b2];
        Xx = Aa\Bb;
        HG = [HG Xx];
    end
end
pt = HG';

% Phase 5: Write all corner points
allpt = [pt;corpt];
points = unique(allpt,'rows');

% Phase 6: Find the FEASIBLE REGION
PT = constraint(points); %CONSTRAINTS
PT = unique(PT,'rows');


% Phase 7: compute objective function 
for i=1:size(PT,1)
    Fx(i,:) = sum(PT(i,:).*C);
end

Vert_Fns = [PT Fx];

% Phase 8: Find the optimal one
[fxval, indfx] = max(Fx);
        optval = Vert_Fns(indfx,:);
   OPTIMAL_BFS = array2table(optval)






