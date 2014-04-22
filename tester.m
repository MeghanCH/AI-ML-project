function [accuracy] = tester(net,data_mean,count,eigenvectors,data,correct_label)

% Testing
data_compressed_mean = bsxfun(@minus,data,data_mean');
weights_test_data = data_compressed_mean'*eigenvectors(:,1:count);
% test_y = mlpfwd(net,weights_test_data);
% test_l = vec2ind(test_y');
% % 
% test_y = net(data_projected');

test_y = mlpfwd(net,weights_test_data);
test_l = vec2ind(test_y');
l = vec2ind(correct_label);
correct_num = length(find(l==test_l));
accuracy = correct_num/size(correct_label,2)*100;
end


% test_l = svmclassify(svmstruct,data_projected);