% CS170   PJ2
% Name: Tsung-Ying Chen 
% SID : 861310198 
% Date: 11/29/2017 
function accuracy = leave_one_out_cross_validation(data,test_set_of_features)

Y = data(:,1);
X = data(:,test_set_of_features + 1);
    
predY = [];
for i = 1:size(data,1)
    testX  = X(i,:);
    trainX = X;  trainX(i,:) = [];
    trainY = Y;  trainY(i,:) = [];
    predY(i) = nearest_neighbor(trainX,trainY,testX);
end

accuracy = sum(predY == Y')/size(Y,1);

end

function predY = nearest_neighbor(trainX,trainY,testX)

distance_to_nearest_neighbor = inf;
for i = 1:size(trainX,1)
    i_X = trainX(i,:);
    distance_to_i = sqrt(sum((i_X - testX).^2)); % Euclidean distance
    
    if distance_to_i < distance_to_nearest_neighbor
        predY = trainY(i);                       % i is the nearst neighbor
        distance_to_nearest_neighbor = distance_to_i;
    end
end
end


