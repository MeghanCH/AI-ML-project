% Run neural network training

[eigenvectors, weights, latents ] = pca(data_compressed'); 
setdemorandstream(491218382);
net = patternnet(10);
[net,tr]=train(net,weights',label');

test_y = net(weights');
test_l = vec2ind(test_y);
