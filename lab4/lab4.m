clear all;
A = [1, 1, 1, 1; 1, 2, 2, 2; 2, 3, 4, 4; 3, 4, 5, 6];
B = [2; 4; 7; 9];
n = 4;

% Метод Гаусса
Start1 = tic;
Y = gauss(A, B, n);
End1 = toc(Start1);

% Оператор обратной косой черты
Start2 = tic;
X = matr(A, B);
End2 = toc(Start2);

disp('Решение методом Гаусса:');
disp(X);
disp(['Затраченное время: ', num2str(End1), ' секунд']);

disp('Решение с использованием оператора обратной косой черты:');
disp(Y);
disp(['Затраченное время: ', num2str(End2), ' секунд']);

function X = gauss(A, B, n)
    X = zeros(n, 1);
    
    check = 1;
    proverka = n;
    k = 1;
    tStart = tic;
    
    while proverka > 1
        while k < n
            pr = -A(k+1, check) / A(check, check);
            A(k+1, check:n) = A(k+1, check:n) + A(check, check:n) * pr;
            B(k+1) = B(k+1) + B(check) * pr;
            k = k + 1;
        end
        proverka = proverka - 1;
        check = check + 1;
        k = check;
    end
    
    % Записываем затраченное время на этап исключения
    X(1) = toc(tStart);
    
    TStart = tic;
    for i = n:-1:1
        X(i) = (B(i) - A(i, (i+1):n) * X((i+1):n)) / A(i, i);
    end
    
    % Записываем затраченное время на этап обратной подстановки
    X(2) = toc(TStart);
end

function Y = matr(A, B)
    tStart = tic;
    Y = A \ B;
    % Записываем затраченное время на оператор обратной косой черты
    Y(1) = toc(tStart);
end


