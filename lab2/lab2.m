clear all;
X = [2 4 5 7 9 10 13 15];
Y = [0.1 0.3 0.8 0.9 0.9 1 1.6 2.1];

subplot(3,1,1)
plot(X,Y)
title('Исходные данные')

f_linear = the_method_of_smaller_squares1(X, Y);
subplot(3,1,2)
plot(X, f_linear(X))
title('Линейная аппроксимация')

f_quadratic = the_method_of_smaller_squares2(X, Y);
subplot(3,1,3)
plot(X, f_quadratic(X))
title('Квадратичная аппроксимация')

function y = the_method_of_smaller_squares1(X, Y)
    n = length(X);
    A = [n sum(X); sum(X) sum(X.^2)];
    B = [sum(Y); sum(X.*Y)];
    C = A \ B;
    A0 = C(1);
    A1 = C(2);
    y = @(x) A1 + A0.*x;
end

function y = the_method_of_smaller_squares2(X, Y)
    n = length(X);
    A = [n sum(X) sum(X.^2); sum(X) sum(X.^2) sum(X.^3); sum(X.^2) sum(X.^3) sum(X.^4)];
    B = [sum(Y); sum(X.*Y); sum(X.^2.*Y)];
    C = A \ B; 
    A0 = C(1);
    A1 = C(2);
    A2 = C(3);
    y = @(x) A0 + A1.*x + A2.*x.^2;
end