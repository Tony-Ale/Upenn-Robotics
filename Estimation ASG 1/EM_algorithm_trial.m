function [ mu, E] = EM_algorithm_trial(mu, E, k, D, Hue, Sat)
%This function estimates model parameters for a guassian mixture model
% k = number of gaussian model you want to use
% E = covariance matrix, it should be a cell array
% mu = mean...it should be a cell array
% D = number of dimensions 
% Hue = column vector
% Sat = column vector

%syms x E_k mu_k

xi = [Hue, Sat];
%g(E_k, mu_k, x) = (1/((2*pi^D/2)*(det(E_k))^0.5))*exp(-0.5*(x-mu_k)' * E_k*(x-mu_k));

% starts here
data_len = length(Hue);
p_val = zeros(data_len, k);
z_i_k = zeros(data_len, k);

mu_sum = zeros(1, D);
sigma_sum = zeros(D, D);
z_k = zeros(1, k);
covar = cell(1, k);
mean_data = cell(1, k);

for n_cell = 1:k
    covar{n_cell} = zeros(D, D);
    mean_data{n_cell} = zeros(1, D);
end


for i = 1:data_len
    for j = 1:k
        p_val(:, j) = mvnpdf(xi, mu{j}, E{j});
    end
    for m = 1:size(p_val, 1)
        z_i_k(m, :) = p_val(m, :)/sum(p_val(m, :));
    end
    % sum of z_i_k
    z_k = sum(z_i_k);
    
    % To calculate mean and co-variance matrix
    count = 0;
    for q = 1:k
        prev_mean = mu{q};
        mu{q} = sum(z_i_k(:, q) .* xi)/z_k(q);
        mean_n = prev_mean;
        for data_point = 1:data_len
            covar{q} = covar{q} + (z_i_k(data_point, q)*((xi(data_point, :) - mean_n)')*(xi(data_point) - mean_n));
        end
        
        E{q} = covar{q}/z_k(q); % finding the covariance matrix
        curr_mean = mu{q};
        
        pp = sum(abs(prev_mean - curr_mean));
        if q == k
            mu{2}
            pp
        end
        % criterion to stop the loop
        if sum(abs(prev_mean - curr_mean)) < 0.001
            count = count + 1;
        end
        if count == k
            i
            return
        end
    end
    % To ensure co-variance matrix have the right properties; positive-
    % definite, symmetric etc.
    for a = 1:k
        val = E{a};
        E{a} = val + 0.00001*eye(D);
    end
        
end
            
end

