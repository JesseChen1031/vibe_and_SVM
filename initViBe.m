%% 参数
numberOfSamples         = parameter.numberOfSamples;
updateFactor            = parameter.updateFactor;


%% 初始化 ViBe
Samples = cell(1, numberOfSamples);  %第一个样本为原图

    Samples{1} = vidFrame;

for ii = 2:numberOfSamples          %剩下的样本为添加噪声后的原图
     Samples{ii} = vidFrame +...
        double(floor(rand(height, width))*20 - 10);  %后半段是人为添加噪声
end

%% Random Part
size = 2*max(height, width) + 1;
% jump[]是一个值为 from 1 to 2*updateFactor的数组，数组长度为1 x size
jump = floor(rand(1, size)*2*updateFactor) + 1;
% neighborX, Y represent the neighbor index,0~3的随机数，长度都为1 x size
neighborX = floor(rand(1, size)*3) - 1;
neighborY = floor(rand(1, size)*3) - 1;
% position[] from 1 to numberOfSamples
position = floor(rand(1, size)*numberOfSamples) + 1;

disp('Initialize ViBe')