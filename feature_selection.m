% CS170   PJ2
% Name: Tsung-Ying Chen 
% SID : 861310198 
% Date: 11/29/2017 
function features = feature_selection(data)

%data = trim_data(data);    % Trim 5% of dataset
data(1,:) = [];
class = data(:,1);
data(:,1) = [];
[data,ori_col_num] = remove_feature(data);
data = zscore(data);        % Normalize data
data = [class data];
searcher = choose_algo();  % Choose algorithm
print_dataset_info(data);
features = searcher(data,ori_col_num);

end

function trimed_data = trim_data(data)
sample_n = size(data,1);
k = randperm(sample_n); 
trimed_data = data(k(1:sample_n*0.95),:); 
end

function print_dataset_info(data)

disp(['This dataset has ', num2str(size(data,2)-1), ' features with ',num2str(size(data,1)),' instances.'])
fprintf('\n'); 

end

function searcher = choose_algo()
algo = 3;
%algo = input('Type 1: Forward Selection\nType 2: Backward Elimination\nType 3: Exhaustive Search\n');

if algo == 1
    searcher = @forward_search;
elseif algo == 2
    searcher = @backward_search;
elseif algo == 3
    searcher = @exhausive_search_3;
else
    searcher = @exhausive_search_2;
end
end

function normalized_data = range_normalize(original_data)
normalized_data = original_data;
for i = 1 : length(original_data(1,:))    
    column_i = original_data(:,i);
    mini = min(column_i);
    maxi = max(column_i);
    for j = 1 : length(column_i)
        normalized_data(j,i) = (normalized_data(j,i) - mini) / maxi;
    end
end
end

function normalized_data = z_normalize(original_data)
normalized_data = original_data;
for i = 1 : length(original_data(1,:))    
    column_i = original_data(:,i);
    mean_col = mean(column_i);
    std_col = std(column_i);
    for j = 1 : length(column_i)
        normalized_data(j,i) = (normalized_data(j,i) - mean_col) / std_col;
    end
end
end

function [data,ori_col_num] = remove_feature(data)

cols_r = [];
ori_col_num = [];
for j = 1:size(data,2)
    if sum(data(:,j)) == 0
        cols_r = [cols_r j];
    else
        ori_col_num = [ori_col_num j];
    end
end

data(:,cols_r) = [];

end