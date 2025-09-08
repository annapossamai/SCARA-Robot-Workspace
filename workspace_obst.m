function workspace_obst(l1,l2,q1_min, q1_max, q2_min, q2_max, xo, yo, ro)
% Number of points for interpolation  
j=100;

% Check if the obstacle obstructs link 2
if(sqrt(xo^2+yo^2)+ro)>=(l1-l2)
    disp("the obstacle obstruct link2!")
else
    % Interaction control for link1 and obstacle

    % Convert joint angle limits to radians
    q1_mi=deg2rad(q1_min);
    q1_ma=deg2rad(q1_max);
    q2_mi=deg2rad(q2_min);
    q2_ma=deg2rad(q2_max);

    % Angle of the disk center distance vector
    theta_o= atan2(yo,xo);
    % Lenght of disk tangent line and his angle wrt theta_o
    lt=sqrt(xo^2+yo^2-ro^2);
    alpha=atan2(ro,lt);

    % joint 1 limit angles due to the obstacle
    q1_ma_o=theta_o+alpha;
    q1_mi_o=theta_o-alpha;
    
    % if control to check if the configuration does not permit any trajectory due to the obstacle

    % set two control flags
    f1=0;
    f2=0;
    
    if q1_ma_o>q1_ma
        q1_ma_o=q1_ma;
        f1=1;
    end
    if q1_mi_o<q1_mi
        q1_mi_o=q1_mi;
        f2=1;
    end
    % Check if the configuration is not permitted
    if f1+f2==2
        disp("the obstacle obstruct link1 and no path is possible!")

    else
        % After the previous checks, start the workspace plotting

        % Compute the workspace boundary
        q2 = linspace(q2_mi, q2_ma, j);

        q1_minim = linspace(q1_mi, q1_mi_o, j);
        q1_maxim = linspace(q1_ma_o, q1_ma, j);

        figure;
        xp=zeros(j,2);
        xp1=zeros(j,2);
        xp2=zeros(j,2);
        xp3=zeros(j,2);
        xp4=zeros(j,2);
        xp5=zeros(j,2);
        xp6=zeros(j,2);
        xp7=zeros(j,2);
        xp8=zeros(j,2);
        xp9=zeros(j,2);

        % Calculate workspace points for various joint configurations
        for i=1:j
            xp(i,:) = dkm(l1,l2,q1_ma_o,q2(i));
            xp1(i,:) = dkm(l1,l2,q1_mi_o,q2(i));
            xp2(i,:) = dkm(l1,l2,q1_ma,q2(i));
            xp3(i,:) = dkm(l1,l2,q1_mi,q2(i));
            xp4(i,:) = dkm(l1,l2,q1_minim(i),q2_mi);
            xp5(i,:) = dkm(l1,l2,q1_maxim(i),q2_mi);
            xp6(i,:) = dkm(l1,l2,q1_maxim(i),q2_ma);
            xp7(i,:) = dkm(l1,l2,q1_minim(i),q2_ma);
            xp8(i,:) = dkm(l1,l2,q1_minim(i),0);
            xp9(i,:) = dkm(l1,l2,q1_maxim(i),0);

        end

        % joint limits
        x1 = l1*cos(q1_mi);
        y1 = l1*sin(q1_mi);
        x2 = l1*cos(q1_ma);
        y2 = l1*sin(q1_ma);
        x3 = l1*cos(q1_mi) + l2*cos(q1_mi + q2_mi);
        y3 = l1*sin(q1_mi) + l2*sin(q1_mi + q2_mi);
        x4 = l1*cos(q1_ma) + l2*cos(q1_ma + q2_ma);
        y4 = l1*sin(q1_ma) + l2*sin(q1_ma + q2_ma);

        % Plot the obstacle: a circle of center (x0,y0) and radius r0
        theta = linspace(0,2*pi,100);
        xobs = xo + ro*cos(theta);
        yobs = yo + ro*sin(theta);

        hold on
        axis("equal")

        plot(xobs, yobs, 'r','LineWidth', 2);

        % plot joint limits

        plot([0 x1], [0 y1], 'k', 'LineWidth', 1.5);
        plot([0 x2], [0 y2], 'k', 'LineWidth', 1.5);
        plot([x1 x3], [y1 y3], 'k', 'LineWidth', 1.5);
        plot([x2 x4], [y2 y4], 'k', 'LineWidth', 1.5);
        plot([0 l1*cos(q1_mi_o)], [0 l1*sin(q1_mi_o)], 'k','LineWidth', 1.5);
        plot([0 l1*cos(q1_ma_o)], [0 l1*sin(q1_ma_o)], 'k','LineWidth', 1.5);
        plot([l1*cos(q1_ma_o) xp(1,1)], [l1*sin(q1_ma_o) xp(1,2)], 'k','LineWidth', 1.5);
        plot([l1*cos(q1_mi_o) xp1(end,1)], [l1*sin(q1_mi_o) xp1(end,2)], 'k','LineWidth', 1.5);

        % Plot the workspace boundary

        plot(xp(:,1), xp(:,2), 'r','LineWidth', 1.5);
        plot(xp1(:,1), xp1(:,2), 'r','LineWidth', 1.5);
        plot(xp2(:,1), xp2(:,2), 'g','LineWidth', 1.5);
        plot(xp3(:,1), xp3(:,2), 'c','LineWidth', 1.5);
        plot(xp4(:,1), xp4(:,2), 'y','LineWidth', 1.5);
        plot(xp5(:,1), xp5(:,2), 'y','LineWidth', 1.5);
        plot(xp6(:,1), xp6(:,2), 'b','LineWidth', 1.5);
        plot(xp7(:,1), xp7(:,2), 'b','LineWidth', 1.5);
        plot(xp8(:,1), xp8(:,2), 'r','LineWidth', 1.5);
        plot(xp9(:,1), xp9(:,2), 'r','LineWidth', 1.5);

    end

end