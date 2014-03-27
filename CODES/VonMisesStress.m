function [ VM maxstress ]  = VonMisesStress( Tensor )
% Using the equation validated in https://github.com/mwpriddy/Titanium-FIPs/issues/3
% or the determinant of the stress tensor.

nativevars = {'S11','S22','S33','S12','S13','S23',};



VM = (Tensor.S11 - Tensor.S22).^2 + ...
    (Tensor.S11 - Tensor.S33).^2 + ...
    (Tensor.S33 - Tensor.S22).^2 + ...
    6 * (Tensor.S12.^2 + Tensor.S13.^2 + Tensor.S23.^2);

VM(:) = sqrt( VM./2);

[~,maxstress.id] = max( VM(:) );

[ maxstress.x maxstress.y maxstress.z ] = ind2sub( size(VM), maxstress.id );
