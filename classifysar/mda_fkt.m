function [ Q,V] = mda_fkt( A_train)
%UNTITLED3 Summary of this function goes here
%   ALGORITHM 2 - COMPUTE QR DECOMPOSITION FOR MDA/FKT APPROACH
% A_train contains a 1xC cell array where C is the number of classes. Each
% cell contains a D x num_samples matrix where D is dimensionality of data
% and num_samples is the number of samples in the class.
%

C = length(A_train);
n_train = zeros ( [ C, 1]);
train_label = (1:C)';


% test_label = A_test(end,:); %not given but used to compute score
% A_test = A_test(1:end-1,:); %test matrix

D = size(A_train{1},1);

for ii = 1 : C  
    n_train(ii,1) = size(A_train{ii},2) ;
end

%% STEP 1   - EXTRA & INTRA CLASS MATRICES

%PART A - COMPUTE H_I

N_I = sum(n_train.*(n_train-1)/2);
H_I = zeros(D,N_I);

idx = 1;
for ii = 1:C % loop through classes
    for jj = 1:n_train(ii) % loop through samples in a class
        for kk = jj+1:n_train(ii)
            H_I(:,idx) = A_train{ii}(:,jj)-A_train{ii}(:,kk);
            idx = idx+1;
        end
    end
end

H_I = (1/sqrt(N_I) )* (H_I );


%PART B - COMPUTE H_E

N_E = 0;
for i=1:C
    for j=i+1:C
        N_E = N_E + n_train(i)*n_train(j);
    end
end
% combos = combntns(n_train,2); % I don't have combntns, hence for loop
% N_E =  nchoosek(C,2)* sum(prod(combos,2));

H_E = zeros(D, N_E);
idx = 1;

for ii = 1:C % loop through first class
    for jj = ii+1:C % loop through second class
        for kk = 1:n_train(ii)  % kkth column of first class
            for pp = 1:n_train(jj)   % ppth column of second class
    
            H_E(:,idx) = A_train{ii}(:,kk)-A_train{jj}(:,pp);
            idx = idx+1;
            
            end
        end
    end
end


H_E = 1/sqrt(N_E) * (H_E ) ; 

%%PART C  - COMPUTE H_T

N = sum(n_train);
H_T = zeros(D,N);

Stacked = [];
for ii = 1:C

    Stacked = [Stacked ,  A_train{ii} ] ;

end
global_avg = mean(Stacked,2); % m 
H_T = Stacked -  repmat(global_avg,[1,N]);


%%

% check lemma 2
%Sigma_E = H_E*H_E' ;
%Sigma_I = H_I*H_I' ;
%Sigma_T = H_T*H_T';
%
%[V_i, D_i ] = eig(Sigma_I)
%
%[V_e, D_e] = eig(Sigma_E);
%[Vgen, Dgen] = eig(Sigma_E,Sigma_I);
%
%
%CHECK_LEMMA_2 =  (N*Sigma_T - N_E*Sigma_E - N_I*Sigma_I ).^2 ;
%CHECK_LEMMA_2 = sum(CHECK_LEMMA_2(:));


%% STEP 2 - Q DECOMPOSITION
r = rank(H_T);
[Q,R] = qr(H_T); % Q should be size Dxr where r = rank(H_T)
Q = Q(:,1:r);
R = R(1:r,:);

%% STEP 3 - S_tilde
S_tilde = R*R';

%% STEP 4 - Z
Z = Q'*H_I;

%% STEP 5 - Sigma_I
Sigma_I_prime = (N_I/(N)) * Z*Z';

%% STEP 6 - evecs / vals of S_tilde^-1'*Sigma_I
P = S_tilde\Sigma_I_prime;
% [V,L] = eig(P);
[V,L] = eigs(P,rank(P));

%% STEP 7 - generalized evals
d = diag(L);
lambda =  N_I*(1-d)./(N_E*d);


%Nvec = [N, N_I, N_E]


%% STEP 8 - sort evecs in decreasing order
% sorting statistic: lambda + 1/lambda
sortstat = lambda + 1./lambda;
[sortstat,i] = sort(sortstat,'descend');
V = V(:,i);

%% STEP 9 - projection matrix
% if k>size(V,2)
%     k = size(V,2)
% end
% projmat = Q*V(:,1:k);

end
