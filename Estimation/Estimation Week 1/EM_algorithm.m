function [ mu, E] = EM_algorithm(mu, E, k, D, Hue, Sat)
%This function estimates model parameters for a guassian mixture model
% k = number of gaussian model you want to use
% E = covariance matrix, it should be a cell array
% mu = mean...it should be a cell array
% D = number of dimensions 
%syms x E_k mu_k
xi = [Hue, Sat];
%g(E_k, mu_k, x) = (1/((2*pi^D/2)*(det(E_k))^0.5))*exp(-0.5*(x-mu_k)' * E_k*(x-mu_k));
%gaussian = mvnpdf(xi(:, n), mu{m}, E{m});

% starts here
p_val = zeros(1, k);
z_i_k = zeros(1, k);
data_len = length(Hue);
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
        p_val(j) = mvnpdf(xi(i, :), mu{j}, E{j});
    end
    for m = 1:length(p_val)
        z_i_k(m) = p_val(m)/sum(p_val);
    end
    % sum of z_i_k
    z_k = z_k + z_i_k;
    
    % To calculate mean and co-variance matrix
    count = 0;
    for q = 1:k
        mean_data{q} = mean_data{q} + (z_i_k(q) * xi(i, :));
        mean_n = mu{q};
        covar{q} = covar{q} + (z_i_k(q)*((xi(i, :) - mean_n)')*(xi(i, :) - mean_n));
        prev_mean = mu{q};
        mu{q} = mean_data{q}/z_k(q); % finding the mean
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
        E{a} = val + 0.0001*eye(D);
    end
        
end
            
end

