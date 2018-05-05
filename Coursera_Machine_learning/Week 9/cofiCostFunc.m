function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda)
%COFICOSTFUNC Collaborative filtering cost function
%   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, num_movies, ...
%   num_features, lambda) returns the cost and gradient for the
%   collaborative filtering problem.
%

% Unfold the U and W matrices from params
X = reshape(params(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(params(num_movies*num_features+1:end), ...
                num_users, num_features);

            
% You need to return the following values correctly
J = 0;
X_grad = zeros(size(X));
Theta_grad = zeros(size(Theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost function and gradient for collaborative
%               filtering. Concretely, you should first implement the cost
%               function (without regularization) and make sure it is
%               matches our costs. After that, you should implement the 
%               gradient and use the checkCostFunction routine to check
%               that the gradient is correct. Finally, you should implement
%               regularization.
%
% Notes: X - num_movies  x num_features matrix of movie features
%        Theta - num_users  x num_features matrix of user features
%        Y - num_movies x num_users matrix of user ratings of movies
%        R - num_movies x num_users matrix, where R(i, j) = 1 if the 
%            i-th movie was rated by the j-th user
%
% You should set the following variables correctly:
%
%        X_grad - num_movies x num_features matrix, containing the 
%                 partial derivatives w.r.t. to each element of X
%        Theta_grad - num_users x num_features matrix, containing the 
%                     partial derivatives w.r.t. to each element of Theta
%

%Multiplying with R matrix ensures that we consider only those movies in the cost
% function that are rated by the user
temp = ((X*Theta' - Y).*R);

J = sum(sum(temp.*temp))/2 + lambda*(sum(sum(Theta.*Theta)) + sum(sum(X.*X)))/2; 

%Partial Differentiation wrt theta(j,k) 
%Theta_grad(j,k) = Temp(1,j)*X(1,k)+ Temp(2,j)*X(2,k)+ Temp(3,j)*X(3,k)+ Temp(4,j)*X(4,k)
for j = 1:num_users,
Theta_grad(j,:) = sum(temp(:,j).*X) + lambda*(Theta(j,:));
end

%Partial Diifferentiation wrt x(j,k)
%X_grad(j,k) = Temp(j,1)*Theta(1,k)+Temp(j,2)*Theta(2,k)+Temp(j,3)*Theta(3,k)
for i = 1:num_movies,
X_grad(i,:) = sum(temp(i,:)'.*Theta) + lambda*(X(i,:));
end

% =============================================================

grad = [X_grad(:); Theta_grad(:)];

end