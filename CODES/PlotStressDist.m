function PlotStressDist( DATA );

for ii = 1 : 6 subplot( 2,3,ii); 
    hist( DATA{ii+1}.spatial.vonmises(:), 51 ); 
end