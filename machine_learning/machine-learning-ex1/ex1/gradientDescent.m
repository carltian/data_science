function [theta, J_history] = gradientDescent(X, y, theta, alpha, num_iters)
%GRADIENTDESCENT Performs gradient descent to learn theta
%   theta = GRADIENTDESENT(X, y, theta, alpha, num_iters) updates theta by 
%   taking num_iters gradient steps with learning rate alpha

% Initialize some useful values
m = length(y); % number of training examples
J_history = zeros(num_iters, 1);

for iter = 1:num_iters

    % ====================== YOUR CODE HERE ======================
    % Instructions: Perform a single gradient step on the parameter vector
    %               theta. 
    %
    % Hint: While debugging, it can be useful to print out the values
    %       of the cost function (computeCost) and gradient here.
    %
    delta = 0;
%    for iter = 1:m
%      x_iter=X(iter,:);
%      y_iter=y(iter);
%      disp('x');
%      disp(x_iter);
%      disp('y');
%      disp(y_iter);
%      delta = delta + (1/m)*(theta'*x_iter'-y_iter)*x_iter;
      %printf('An integer: %i. A real: %f. This is a %s.\n', x, y, z);
%    endfor

     %disp(size(X));
     %disp(size(theta));
     theta = theta - alpha*1/m*((X*theta-y)'*X)';   

    % ============================================================

    % Save the cost J in every iteration    
%    theta = theta-alpha*delta;
    J_history(iter) = computeCost(X, y, theta);
end

end
