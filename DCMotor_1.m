%======================================================================%
%=======================DC Motor Control Program=======================%
%============================ipmsm.github.io===========================%
%===========================lhjoon14@gmail.com=========================%
%=== Please visit EasyDrives, There are other examples as well ========%
clear all; 
Torque = 0; 
Speed = 1;
%====================== Do not edit upper area=========================%
%======================================================================%
%% Operating mode
Operation.Mode = Torque;     %Torque , Speed

%% Control Inputs
ControlInputs.Speed = 10;                    % Speed refrence [rev/min]
ControlInputs.Torque = 10;                  % Torque refrence [Nm]
ControlInputs.LoadSpeed = 10;               % Load machine speed refrence [rev/min]
ControlInputs.SwitchingFrequency = 10e3;    % Switching frequency [Hz]

%% Motor and Inverter Ratings
Power=3336;               % Power[W]
Va_rated=140;             % Rated Voltage [V]
Ia_rated=25;              % Rated Current [A]
Wm_rated=3000*2*pi/60;    % Rated Angular Velocity[rad/s]
Te_rated=Power/Wm_rated;  % Rated Torque [Nm]

%% 
Ra=0.26;                  % Resistance [Ohm]
La=1.7e-3;                % Inductance [H]
J=.00252;                 % Moment of inertia [kg-m^2]
B=.0;                     % Coefficient of viscous friction [kgm^2/sec]  

Kt=Te_rated/Ia_rated;     % Torque constant [Nm/Wb/A]
K=Kt;      

%-- Current Controller Gains ------------------------------------------
Wcc=2*pi*500;             % current controller bandwidth [rad/s]
Kpc=La*Wcc;               % P gain
Kic=Ra*Wcc;               % I gain
Kac=1/Kpc;                % Anti-windup gain

%--- Speed Controller Gains -------------------------------------------
Wsc=2*pi*50;              % speed controller bandwidth [rad/s]
Ksp=J*Wsc;                % P gain
Ksi=Ksp*Wsc/5;            % I gain
Ksa=1/Ksp;                % Anti-windup gain
Te_limit=Te_rated;
Ia_limit=Ia_rated;

Vdc=140;
