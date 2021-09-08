%% ����
numberOfSamples         = parameter.numberOfSamples;
updateFactor            = parameter.updateFactor;


%% ��ʼ�� ViBe
Samples = cell(1, numberOfSamples);  %��һ������Ϊԭͼ

    Samples{1} = vidFrame;

for ii = 2:numberOfSamples          %ʣ�µ�����Ϊ����������ԭͼ
     Samples{ii} = vidFrame +...
        double(floor(rand(height, width))*20 - 10);  %��������Ϊ�������
end

%% Random Part
size = 2*max(height, width) + 1;
% jump[]��һ��ֵΪ from 1 to 2*updateFactor�����飬���鳤��Ϊ1 x size
jump = floor(rand(1, size)*2*updateFactor) + 1;
% neighborX, Y represent the neighbor index,0~3������������ȶ�Ϊ1 x size
neighborX = floor(rand(1, size)*3) - 1;
neighborY = floor(rand(1, size)*3) - 1;
% position[] from 1 to numberOfSamples
position = floor(rand(1, size)*numberOfSamples) + 1;

disp('Initialize ViBe')