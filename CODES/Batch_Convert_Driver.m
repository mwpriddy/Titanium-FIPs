
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
    %% Create some Images
    %% Publish the page
    h5out = horzcat( h5_to_dir_lcl, regexprep( ff(ii).name ,'.mat','.h5') );
    StructureData( h5out, DATA, true );
    
    
    ml = createDataset( h5out );
  
    
    dictname = 'Stress-States';
    ml.dict = dictname;
    ml.input.location = horzcat( mat_to_dir, ff(ii).name );
    AttachDictionary( ml, [], dictname );
    PublishDataset(ml);
    
end