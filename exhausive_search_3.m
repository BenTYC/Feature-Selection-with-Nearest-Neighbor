% CS170   PJ2
% Name: Tsung-Ying Chen 
% SID : 861310198 
% Date: 11/29/2017 
function best_features_o = exhausive_search_3(data,ori_col_num)

best_accuracy = 0; 

for i = 1 : size(data,2)-3
    for j = i + 1 : size(data,2)-2
        for k = j + 1 : size(data,2)-1
            %for l = k + 1 : size(data,2)-1
            test_set_of_features = [i j k];
            accuracy = leave_one_out_cross_validation(data,test_set_of_features);
            disp([num2str(ori_col_num(test_set_of_features)),'  ',num2str(accuracy)])
            if accuracy > best_accuracy 
                best_accuracy = accuracy;
                best_features = [i j k];            
            end 
            %end
            
        end
    end
end 

for i = 1 : size(data,2)-2
    for j = i + 1 : size(data,2)-1
        test_set_of_features = [i j];
        accuracy = leave_one_out_cross_validation(data,test_set_of_features);
        disp([num2str(ori_col_num(test_set_of_features)),'  ',num2str(accuracy)])
        if accuracy > best_accuracy 
            best_accuracy = accuracy;
            best_features = [i j];            
        end 
    end
end 

best_features_o = [];
for k = 1:length(best_features)
    best_features_o = [best_features_o ori_col_num(best_features(k))];
end

disp(['----The best set is ', num2str(best_features_o), ' with accuracy ',num2str(best_accuracy)])

end
