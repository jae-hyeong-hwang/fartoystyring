function plot_tecplot(filename,colorcode,figno)
% PLOT_TECPLOT (MSS HYDRO)
%
% Plot Tecplot geometry files (*_pan.dat) for semisubs in 3D
% This file is generated by WAMIT (se example 15)
%
% Examples:
%
% >> plot_tecplot(filename,colorcode,figno);
% >> plot_tecplot('test15_pan','black',1);       % WAMIT Example 15
%
% -------------------------------------------------------------------------
% Inputs:
%    filename:    Wamit generated Techplot file without extension
%    colorcode:   'r','g','b','c','m','y','w','k' or coslormaps [0 0 1] etc.
%    figno:       figure number
%
% -------------------------------------------------------------------------
% Author:    Thor I. Fossen 
% Date:      2005-09-24 
% Revisions: 
% _________________________________________________________________________
%
% MSS HYDRO is a Matlab toolbox for guidance, navigation and control.
% The toolbox is part of the Marine Systems Simulator (MSS).

clear gdf_data x y z

if ~exist('colorcode')
    colorcode = 'black';
end

if ~exist('figno')
    figno = 1;
end


% -------------------------------------------------------------------------
% Read Techplot panels
% -------------------------------------------------------------------------
fid1 = fopen([filename '.dat']);   % open Wamit file

i = 1;
    
while feof(fid1) == 0,

    txt       = char(fgetl(fid1));
    if strcmp(txt(1:4),'zone')
        txt       = char(fgetl(fid1));
    end
    numbers   = str2num(txt); 
    gdf_data(i,1:3) = numbers;
    i = i+1;
end 

fclose(fid1);                    % close Wamit file

Npanels = max(size(gdf_data));
% -------------------------------------------------------------------------
% Plot panels in 3D
% -------------------------------------------------------------------------
figure(figno)
figure(gcf)

% Loop over panels

j = 1;
for i = 1:Npanels/4
    gdf_data2(i,:) = [gdf_data(j,:) gdf_data(j+1,:) gdf_data(j+2,:) gdf_data(j+3,:)];
    j = j + 4;
end

% Loop over panels
for n = 1:Npanels/4
	
	% Vector with panel coordinates
	panel = gdf_data2(n,:);
	x{n} = [panel(1), panel(4), panel(7), panel(10)];
    y{n} = [panel(2), panel(5), panel(8), panel(11)];
    z{n} = [panel(3), panel(6), panel(9), panel(12)];

    % plot vessel
    patch(x{n},y{n},z{n},colorcode);

end


xlabel('X-axis (m)')
ylabel('Y-axis (m)')
zlabel('Z-axis (m)')
title(strcat('3D Visualization of Tecplot data file: *pan.dat'))
view(30,30)
axis('equal')
grid
