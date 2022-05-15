function derivative = TIME_DERIVATIVE(Matrix,time)

    % The function returns the time derivative of Matrix.
    % This function had to be created in order to remove undesired peaks before
    % filtering the data

    [lines,columns] = size(Matrix);
    derivative = [zeros(lines,1)];


    for j = 2 : columns
        derivative(:,j) = (Matrix(:,j) - Matrix(:,j-1))./(time(:,j)-time(:,j-1));
    end
end
