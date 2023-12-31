clear all;

F = @(x) x.^3 + 3.*x - 1;
X = -10:1:10;
plot(X, F(X))

a = -2;
b = 2;
eps = 0.01;
[der1, der2] = derivative();

ans1 = first(F, a, b, eps);
ans2 = second(F, a, b, eps, der1, der2);
ans3 = third(F, a, eps, der1);

function ansver = first(F, a, b, eps)
    if F(a)*F(b) > 0
        error('Корень не существует в данном интервале.');
    end
    
    while abs(b - a) > eps
        ansver = (a + b) / 2;
        if F(a) * F(ansver) < 0
            b = ansver;
        elseif F(b) * F(ansver) < 0
            a = ansver;
        end
    end
    
    ansver = (a + b) / 2;
end

function ansver = second(F, a, b, eps, der1, der2)
    if F(a) * der2(a) > 0
        ansver = a;
    elseif F(b) * der2(b) > 0
        ansver = b;
    end
    
    pr = inf;
    while pr > eps
        pr = F(ansver) / der1(ansver);
        ansver = ansver - pr;
    end
end

function ansver = third(F, a, eps, der1)
    M = 1.01 * der1(a);
    k = M;
    f = @(ansver) ansver - F(ansver) / k;
    ansver = a;
    pr = inf;
    
    while pr > eps
        ansver_prev = ansver;
        ansver = f(ansver);
        pr = abs(ansver - ansver_prev);
    end
end

function [der1, der2] = derivative()
    syms x;
    f = x^3 + 3*x - 1;
    der1 = matlabFunction(diff(f));
    der2 = matlabFunction(diff(f, 2));
end
