function completed_matrix = MIMAT(num_rows, num_columns, observation_mask, observed_matrix, tolerance1, tolerance2, observation_percentage, iteration)
%This Function Solve Matrix Completion with MIMAT algorithm
   missing_mask = ~observation_mask;
   current_approx = observed_matrix;
   Z=zeros(num_rows, num_columns);
   current_rank = 1;
   [U, Sigma, V]=svd(current_approx,'econ');
   current_mu = Sigma(current_rank, current_rank);
   Sigma_sup = Sigma - current_mu * eye(num_rows, num_columns);
   T1 = Sigma_sup >= 0 ;
   Sigma_nn = Sigma_sup .* T1 ;
   
   current_approx = (U * Sigma_nn * V');
   error1 = norm(observed_matrix , 'fro');
   error2 = 10;
   while (error1 >= tolerance1)
       %disp('---------------------------');
       error2 = norm(current_approx, 'fro') * 10 * tolerance2;
       while ((error2 / norm(current_approx, 'fro')) >= tolerance2)
           [U, Sigma, V] = svd(current_approx,'econ');  
           Sigma_nn = diag(diag(Sigma) .* (diag(Sigma) >= current_mu));
           current_approx = (U * Sigma_nn * V');
           Z = current_approx;
           current_approx = observed_matrix .* missing_mask + current_approx .* observation_mask ;
           error2 = norm ((current_approx - current_approx), 'fro');
           current_approx = current_approx;
       end
       current_rank = current_rank + 1;
       S = svd(current_approx) ;
       if current_rank >= length(S)
           break;
       end
       current_mu = S(current_rank) ;
       fprintf('observation percentage: %d ; iteration no:%d\n' , observation_percentage, iteration);
       error1 = norm((observed_matrix - Z) .* (missing_mask), 'fro') / norm(observed_matrix, 'fro');
   end
           
    completed_matrix = observed_matrix .* missing_mask + current_approx .* observation_mask ;
end 