function X = dkm(l1,l2, q1,q2)
    % Compute direct kinematic model
    x = l1*cos(q1) + l2*cos(q1+q2);
    y = l1*sin(q1) + l2*sin(q1+q2);
    X=[x,y]';
    
end