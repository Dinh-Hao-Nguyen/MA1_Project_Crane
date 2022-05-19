function correct = correct_data(Matrix)

    % The function returns the time derivative of Matrix.
    % This function had to be created in order to remove undesired peaks before
    % filtering the data

    [lines , columns] = size(Matrix);
    correct = zeros(lines,columns);


    for j = 1 : columns
        for i=1:lines
            if j>=2 & (abs(Matrix(i,j)-correct(i,j-1))>300) 
                if Matrix(i,j)<0
                    correct(i,j) = Matrix(i,j) + 360;
                end
                if Matrix(i,j)>0 
                    correct(i,j) = Matrix(i,j) - 360;
                end
            else
                correct(i,j) = Matrix(i,j);
            end
        end
    end
end
