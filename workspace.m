function workspace(l1,l2,q1_min, q1_max, q2_min, q2_max)
% Number of points for interpolation 
j=100;
% Convert joint limits from degrees to radians
q1_mi=deg2rad(q1_min);
q1_ma=deg2rad(q1_max);
q2_mi=deg2rad(q2_min);
q2_ma=deg2rad(q2_max);

%Compute the workspace boundary
q1 = linspace(q1_mi, q1_ma, j);
q2 = linspace(q2_mi, q2_ma, j);

% Create arrays to store workspace boundary points
xp=zeros(j,2);
xp1=zeros(j,2);
xp2=zeros(j,2);
xp3=zeros(j,2);
xp4=zeros(j,2);

% Calculate the direct kinematic model for different joint configurations
for i=1:j
    xp(i,:) = dkm(l1,l2,q1(i),q2_ma);
    xp1(i,:) = dkm(l1,l2,q1(i),q2_mi);
    xp2(i,:) = dkm(l1,l2,q1(i),0);
    xp3(i,:) = dkm(l1,l2,q1_ma,q2(i));
    xp4(i,:) = dkm(l1,l2,q1_mi,q2(i));
end
figure;

% joint limits
x1 = l1*cos(q1_mi);
y1 = l1*sin(q1_mi);
x2 = l1*cos(q1_ma);
y2 = l1*sin(q1_ma);
x3 = l1*cos(q1_mi) + l2*cos(q1_mi + q2_mi);
y3 = l1*sin(q1_mi) + l2*sin(q1_mi + q2_mi);
x4 = l1*cos(q1_ma) + l2*cos(q1_ma + q2_ma);
y4 = l1*sin(q1_ma) + l2*sin(q1_ma + q2_ma);


% Plot the workspace boundary
hold on
axis("equal")

% plot joint limits
plot([0 x1], [0 y1], 'k','LineWidth', 1.5);
plot([0 x2], [0 y2], 'k','LineWidth', 1.5);
plot([x1 x3], [y1 y3], 'k','LineWidth', 1.5);
plot([x2 x4], [y2 y4], 'k','LineWidth', 1.5);

% plot workspace lines
plot(xp(:,1), xp(:,2), 'b','LineWidth', 1.5); 
plot(xp1(:,1), xp1(:,2), 'y','LineWidth', 1.5);
plot(xp2(:,1), xp2(:,2), 'r','LineWidth', 1.5);
plot(xp3(:,1), xp3(:,2), 'g','LineWidth', 1.5);
plot(xp4(:,1), xp4(:,2), 'c','LineWidth', 1.5);

end