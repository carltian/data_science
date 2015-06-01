function [J, grad] = costFunction(theta, X, y)
%COSTFUNCTION Compute cost and gradient for logistic regression
%   J = COSTFUNCTION(theta, X, y) computes the cost of using theta as the
%   parameter for logistic regression and the gradient of the cost
%   w.r.t. to the parameters.

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta
%
% Note: grad should have the same dimensions as theta
%

%delta = 0;			   
%for iter = 1:m
%  x_iter=X(iter,:);
%  y_iter=y(iter);
%  z = theta'*x_iter';
%  h = 1/(1+exp(-z));
%  J = J + 1/m*(-y_iter*log(h)-(1-y_iter)*log(1-h));
%  delta = delta + (1/m)*(h-y_iter)*x_iter;
%endfor

hx = sigmoid(X*theta);
disp(size(X));
disp(size(theta));
disp(size(hx));
disp(size(y));
disp(size(y'*log(hx)));

J = (sum(-y' * log(hx) - (1 - y')*log(1 - hx)) / m);
grad =((hx - y)' * X / m)';

%grad = delta';
%disp(grad);
% =============================================================

end
