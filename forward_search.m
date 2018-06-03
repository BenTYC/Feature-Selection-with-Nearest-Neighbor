% CS170   PJ2
% Name: Tsung-Ying Chen 
% SID : 861310198 
% Date: 11/29/2017 
function best_features_o = forward_search(data,ori_col_num)

current_set_of_features = []; % Initialize an empty set
current_accuracy_by_current_set = [];  % For plot
best_accuracy = 0; % For picking the best features

for i = 1 : size(data,2)-1 
    %disp(['On the ',num2str(i),'th level of the search tree'])
    feature_to_add_at_this_level = [];
    best_so_far_accuracy = 0;    
    
    for k = 1 : size(data,2)-1 
        if isempty(intersect(current_set_of_features,k)) % Only consider adding, if not already added.
            %disp(['--Considering adding the ', num2str(k),' feature'])
            test_set_of_features = [current_set_of_features k];
            accuracy = leave_one_out_cross_validation(data,test_set_of_features);
            disp(['Using feature(s) ', num2str(ori_col_num(test_set_of_features)),' accuracy is ', num2str(accuracy)])

            if accuracy > best_so_far_accuracy 
                best_so_far_accuracy = accuracy;
                feature_to_add_at_this_level = k;            
            end        
        end
    end
    
    %%% add the best feature
    current_set_of_features(i) =  feature_to_add_at_this_level;
    current_accuracy_by_current_set(i) = best_so_far_accuracy;
    disp(['On level ', num2str(i),' i added feature ', num2str(ori_col_num(feature_to_add_at_this_level)), ' to current set with accuracy ', num2str(best_so_far_accuracy),])
    %fprintf('\n');
    
    %%%%% Record the best subset
    if best_so_far_accuracy > best_accuracy
        best_features = current_set_of_features;
        best_accuracy = best_so_far_accuracy;
    end
end 

best_features_o = [];
for k = 1:length(best_features)
    best_features_o = [best_features_o ori_col_num(best_features(k))];
end

disp(['Finished search!! The best feature subset is ', num2str(best_features_o), ', which has an accuracy of ',num2str(best_accuracy)])
plot_features_err(current_accuracy_by_current_set);

end

function plot_features_err(current_accuracy_by_current_set)
X = 1:length(current_accuracy_by_current_set);
Y = current_accuracy_by_current_set;
plot(X,Y)
xlabel('number of features')
ylabel('accuracy')
set(gca,'fontsize',16)
hold on
%{
indexmax = find(max(Y) == Y);
xmax = X(indexmax);
ymax = Y(indexmax);
strmax = ['\leftarrow Max = ',num2str(ymax),'; number of features: ',num2str(xmax)];
text(xmax,ymax,strmax,'FontSize', 16)
%}
end
