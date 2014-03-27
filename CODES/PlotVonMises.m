function nm = PlotVonMises( DATA, peaklocation, topath, h5out )

close all;
sz = size( DATA{2}.spatial.vonmises );
temp = zeros( sz );
for ii = 2 : 7
    temp(:) = DATA{ii}.spatial.vonmises
    temp( 1 : peaklocation(ii).x, ...
        1 : peaklocation(ii).y,...
        peaklocation(ii).z:end ) = nan;
    
    h = vol3d( 'Cdata', temp );
    axis equal;
    
    colorbar;
    box on;
    axis equal
    set( gca,'Xtick',[],'Ytick',[],'Ztick',[] );
    view(3)
    
    
    nm{ii} = sprintf('%s%cVonMisesContour-%s-%s.png', topath,filesep, ....
        regexprep( fliplr(strtok(fliplr(h5out),filesep)),'.h5',''),...
        DATA{ii}.name)
    
    saveas( gcf, nm{ii} );
    
end