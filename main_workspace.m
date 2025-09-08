close all;
clear all;
clc;

% link lenght
l1=1;
l2=0.2;
% joint limits
% set q1_min>-180 and q1_max<180
q1_min=-70;
q1_max=45;
% set q2_min>-180 and q2_max<180
q2_min=-70;
q2_max=45;

% function to plot the workspace without the obstacle
workspace(l1,l2,q1_min, q1_max, q2_min, q2_max);

% function to plot the workspace with the obstacle
workspace_obst(l1,l2,q1_min, q1_max, q2_min, q2_max,0.5,0,0.2);