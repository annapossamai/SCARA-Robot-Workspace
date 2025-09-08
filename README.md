# Optimal Kinematic Design of Robots – Lab 1: SCARA Workspace Design

**Author:** Anna Possamai  
**Instructor:** Philippe Wenger  
**Department:** Control and Robotics Engineering  
**Date:** October 18, 2023  

---

## Introduction

This repository contains the MATLAB implementation for **Lab 1: Workspace-based Design of a SCARA Robot**. The lab demonstrates how to use the concept of **workspace** in the design of an interactive MATLAB function for a SCARA robot, taking into account joint limits, link lengths, and obstacles.

---

## Work Plan

### 1. Direct Kinematics and Singularities
- The direct kinematics model was computed to determine the end-effector position as a function of joint angles:
  
$$
\begin{cases}
x = a_1 \cos(q_1) + a_2 \cos(q_1 + q_2) \\
y = a_1 \sin(q_1) + a_2 \sin(q_1 + q_2)
\end{cases}
$$

- The Jacobian was used to identify joint singularities, which occur at `q2 = 0` and `q2 = π`.

### 2. Workspace Analysis
- **Main function:** `main_workspace.m` allows users to input joint limits and link lengths to visualize the robot's workspace.
- **Workspace without obstacle:** `workspace(l1, l2, q1min, q1max, q2min, q2max)` calculates the workspace boundaries using the direct kinematics function `dkm`.
- **Workspace with obstacle:** `workspace_obst(l1, l2, q1min, q1max, q2min, q2max, xo, yo, ro)` considers a disk-shaped obstacle that obstructs link 1, calculates joint limits to avoid collisions, and plots the restricted workspace.
- The code currently handles the case where both `q1min` and `q1max` intersect the obstacle, displaying an error if the trajectory cannot be plotted.

---

## Design for Point-to-Point Tasks
- SCARA robot joint limits: `±132°` (θ1), `±141°` (θ2).  
- Obstacle: disk with radius `0.3 m` at `(1.2, 0.1) m`.  
- Maximum reach: `2 m`.  
- Goal: find the optimal link length ratio for picking parts from an **L-shaped palette** and placing them into another identical palette.  
- Optimal link lengths: `l1 = 0.9 m`, `l2 = 1.1 m`.  
- The configuration allows the robot to reach all points on the L-shaped palette for **pick-and-place tasks**, with temporary singularities not posing an issue.

---

## Design for Process Tasks
- In process tasks (e.g., laser applications), singularities must be avoided to prevent loss of control or trajectory errors.  
- The previously selected link lengths provide a workspace that avoids singularities while following the contours of the shape.

---

## Conclusion
- This lab demonstrates **workspace analysis**, **singularity identification**, and **MATLAB function development** for SCARA robots.  
- The repository includes tools for visualizing the robot's workspace with or without obstacles.  
- Optimized link lengths allow the robot to perform both **point-to-point pick-and-place** and **process tasks** efficiently.  

---

## Files in the Repository
- `main_workspace.m` – main script to visualize workspace  
- `workspace.m` – function for workspace boundaries without obstacles  
- `workspace_obst.m` – function for workspace boundaries with obstacle  
- `dkm.m` – direct kinematics function  
- Other MATLAB scripts for plotting, calculations, and demonstrations  
- `README.md` – this file  

---

## Usage
1. Open MATLAB and navigate to the repository folder.  
2. Run `main_workspace.m` and provide the joint limits and link lengths.  
3. For obstacle analysis, use `workspace_obst.m` with obstacle parameters.  
4. Visualize workspace boundaries and analyze the robot's reachable positions.  

