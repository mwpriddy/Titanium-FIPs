
fig_to_dir = 'https://dl.dropboxusercontent.com/u/22455492/Ti-FIPs/Figures/';
mat_to_dir = 'https://www.dropbox.com/s/c1tx6z7qwfyxynx/';
h5_to_dir_lcl = './Converted/';
h5_to_dir_url = 'https://www.dropbox.com/s/lyntwf8r25cvtxy/';
% THere is a test H5 file on the repository.

for ii = 1 : 10
    
    %% Structure the Data
    DATA = StructureTiFIP( ff(ii).name )
    DATA = cellfun( @(x)setfield(x,'link',horzcat( h5_to_dir_url, regexprep( ff(ii).name ,'.mat','.h5') ) ), DATA, 'UniformOutput',false );
    % The command below will at the thumbnails.
    %     DATA = cellfun( @(x)setfield(x,'image',horzcat( h5_to_dir_url, regexprep( ff(ii).name ,'.mat','.h5') ) ), DATA, 'UniformOutput',false );
    
    % Reorder the variable names for easy publishing
    DATA = {DATA{[1,3,2,5,4,7,6]}};
    
    
    
    for jj = 2 : numel(DATA)
        [ DATA{jj}.spatial.vonmises peaklocation(jj) ] = VonMisesStress( DATA{jj}.spatial );
        DATA{jj}.aggregate.vonmisesmax = max( DATA{jj}.spatial.vonmises(:) );
        DATA{jj}.aggregate.vonmisesmean = mean( DATA{jj}.spatial.vonmises(:) );
    end
    

    %% Create some Images
    %% Publish the page
    h5out = horzcat( h5_to_dir_lcl, regexprep( ff(ii).name ,'.mat','.h5') );
        
    
    nm = PlotSliceLabel( DATA, peaklocation(2), '~/Dropbox/Public/Ti-FIPs/Figures/',h5out);
    DATA{1}.image = horzcat( fig_to_dir, fliplr( strtok( fliplr( nm ), filesep)) );
    
    nm = PlotVonMises( DATA, peaklocation, '~/Dropbox/Public/Ti-FIPs/Figures/',h5out);
    for jj = 2 : 7
        DATA{jj}.image = horzcat( fig_to_dir, fliplr( strtok( fliplr( nm{jj} ), filesep)) );
    end
    
    StructureData( h5out, DATA, true );
    ml = createDataset( h5out );
    
    
    dictname = 'Stress-States';
    ml.dict = dictname;
    ml.input.location = horzcat( mat_to_dir, ff(ii).name );
    AttachDictionary( ml, [], dictname );
    PublishDataset(ml);
end