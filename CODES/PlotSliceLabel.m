function [ nm] = PlotSliceLabel( DATA, peaklocation , topath, h5out )
% THis is attached to the input-structure.

ID = angle2id( DATA{1}.spatial );

maxgrain = ID( peaklocation.id );

shifts = [ eye(3); -1*eye(3) ];

temp = zeros( size( ID ) );
nearest = [];
for ii = 1 : 6
    temp(:) = circshift( ID, shifts( ii,:));
    nearest = unique([nearest; unique( temp( ID == maxgrain ) )]);
end


%%  Plot the nearest grain map 
% This is attached the Input-Structure dataset
close all;
co = cbrewer( 'qual','Paired',numel(nearest) );
temp(:) = nan;
temp( ID == maxgrain ) = 1;
str{1} = sprintf('Cntr: (%.2f,%.2f,%.2f)',structfun( @(x)x(find( ID == maxgrain,1,'first')), DATA{1}.spatial ) );
for ii = 1 : numel(nearest)
    temp( ID == nearest(ii) ) = ii + 1;
    str{ii+1} = sprintf('(%.2f,%.2f,%.2f)',structfun( @(x)x(find( ID == nearest(ii),1,'first')), DATA{1}.spatial ) );
end

vol3d( 'Cdata',temp,'Alpha',~isnan(temp) + zeros(size(temp)));
colormap( co );
hcob = colorbar;
grid on;
axis equal;

set( hcob, ...
    'Ytick', 0 : max(temp(:)), ...
    'Yticklabel', str );
view(3)
set( gcf,'Position',[ 1          89        1440         717] );



    nm = sprintf('%s%cSliceNearMax-%s-%s.png', topath,filesep, ....
        regexprep( fliplr(strtok(fliplr(h5out),filesep)),'.h5',''),...
        DATA{1}.name)
    
    saveas( gcf, nm );
%%  Plot the von Mises slices

