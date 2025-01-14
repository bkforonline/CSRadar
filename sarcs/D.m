function [dist] = D(rt,rr,r)
% D returns the distance a pulse needs to travel from the transmitter (located at rt) 
% to a point (located at r) and back to a receiver (located at rr)
% 
% Let N be the number of timesteps
%
% rt: a matrix of size N x 3 that contains the position of the transmitter at each
% timestep
%
% rr: a matrix of size N x 3 x R that contains the position of the receivers at each
% timestep. (assuming R receiver)
% 
% r: a vector of size 3 representing a point of interest to determine the distance D(r)

N = size(rt,1);
R = size(rr,2);
r = reshape(r,[1,1,3]);
r = repmat(r,[N,R,1]); % now N x R x 3
rt = repmat(rt,[1,R,1]); % now N x R x 3
rt_r = sqrt(sum((rt-r).^2,3));
r_rr = sqrt(sum((rr-r).^2,3));
dist = rt_r + r_rr;
