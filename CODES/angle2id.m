function ID = angle2id( angles )
% Convert Euler angles to ID's.
% This code will only work for artificial microstructures with zero noise.
%%
nativenames = { 'phi_1', 'PHI', 'phi_2' };
sz = size( getfield( angles, nativenames{1}) );
ID = zeros( sz );
n = zeros(1,numel(sz));
for ii = 1 : 3
    [ ~,~, temp] = unique(single( getfield( angles, nativenames{ii})));
    angles = setfield( angles, nativenames{ii}, reshape(temp,sz) );
    n(ii) = max(temp(:));
end

ID(:) = sub2ind( n, angles.phi_1, angles.PHI, angles.phi_2 );
% Reindex the ridiculous subscripts I am getting
[~,ID(:)] = ismember( ID, unique(ID));