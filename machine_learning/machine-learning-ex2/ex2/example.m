function [J, grad] = costFunctionReg(theta, X, y, lambda)
J = 0;
grad = zeros(size(theta));

temp_theta = [];

for jj = 2:length(theta)

    temp_theta(jj) = theta(jj)^2;
end

theta_reg = lambda/(2*m)*sum(temp_theta);

temp_sum =[];

for ii =1:m

   temp_sum(ii) = -y(ii)*log(sigmoid(theta'*X(ii,:)'))-(1-y(ii))*log(1-sigmoid(theta'*X(ii,:)'));

end

tempo = sum(temp_sum);

J = (1/m)*tempo+theta_reg;

%regulatization
%theta 0

reg_theta0 = 0;

for i=1:m
    reg_theta0(i) = ((sigmoid(theta'*X(i,:)'))-y(i))*X(i,1)
end

theta_temp(1) = (1/m)*sum(reg_theta0)

grad(1) = theta_temp

sum_thetas = []
thetas_sum = []

for j = 2:size(theta)
    for i = 1:m

        sum_thetas(i) = ((sigmoid(theta'*X(i,:)'))-y(i))*X(i,j)
    end

    thetas_sum(j) = (1/m)*sum(sum_thetas)+((lambda/m)*theta(j))
    sum_thetas = []
end

for z=2:size(theta)
    grad(z) = thetas_sum(z)
end


% =============================================================

end
