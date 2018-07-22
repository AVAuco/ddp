function xr = mj_rescale(x, lw, up)
% xr = mj_rescale(x, lw, up)
% Rescale values to a given range
%
% Input:
%  - x: the data
%  - lw: lower value
%  - up: upper value
%
% Output:
%  - xr: values rescaled to selected range
%
% (c) MJMJ/2018

xr = lw + (( x-min(x(:)) ) ./ ( max(x(:))-min(x(:)) ) ) .* (up - lw);