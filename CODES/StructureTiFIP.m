function DATA = StructureTiFIP( fn )

variable_names = whos( '-file', fn );
load( fn );

NAMES = strsplit(regexprep('S11, S22, S33, S12, S13, S23, PS11, PS22, PS33, PS12, PS13, PS23',',',''));

%% Organize Independent Structure Variables
sz = [26 26 26];
NAMES = {'PHASE','phi_1','PHI','phi_2'};

DATA{1}.name = 'Input-Structure'
DATA{1}.spatial.phi_1 = reshape( data_PH_EUL(:,2), sz );
DATA{1}.spatial.PHI = reshape( data_PH_EUL(:,3), sz );
DATA{1}.spatial.phi_2 = reshape( data_PH_EUL(:,4), sz );




%% Organize Dependent Structure Variables ( Elastic Response )

varorder = strsplit('data_SPS_C1_max data_SPS_C2_max data_SPS_C2_min  data_SPS_C3_max data_SPS_C3_min data_SPS_C4_min');

NAMES = strsplit(regexprep('S11, S22, S33, S12, S13, S23, PS11, PS22, PS33, PS12, PS13, PS23',',',''));
% The values reported are stress values in MPa
for ii = 1 : numel( varorder )
    if mod(ii,2)==1
        str = 'Valley';
    else
        str = 'Peak';
    end
    DATA{ii+1}.name = sprintf( '%s-%i',str, ceil(ii./2) );
    for jj = 1 : numel( NAMES )
        
        eval( sprintf( 'DATA{%i}.spatial.%s = reshape( %s(:,%i), sz );', ii+1, NAMES{jj},  varorder{ii}, jj ) );
        
        %% Organize Dependent Structure Variables ( Plastic Response )
        % The values reported are stress values in MPa
    end
    
end
