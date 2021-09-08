function segmentationMap = vibeSegmentation(buffer,...
    Samples, parameter)
    %% Parameters
    height  = parameter.height;
    width   = parameter.width;
    numberOfSamples         = parameter.numberOfSamples;
    matchingDistance        = parameter.matchingDistance;
    matchingNumber          = parameter.matchingNumber;
    
    %% Segmentation
    segmentationMap = uint8(ones(height, width)*(matchingNumber - 1));
    % First and Second history Image structure
    distance = abs(buffer - Samples{1}) <= matchingDistance; %�Ƚ�ÿ�����ص�Ҷ�ֵ�뱳��ģ�͵ĻҶ�ֵ�ľ���
    for ii = 1:height
        for jj = 1:width
            if ~distance(ii, jj)
                segmentationMap(ii, jj) = matchingNumber;
            else
                segmentationMap(ii, jj) = matchingNumber-1;
                %�˴�Ϊ��һ��ƥ�䣬���ж�Ϊǰ�������ص�ĻҶ�ֵ��Ϊƥ����ֵ��Ϊǰ���ָ���׼����
                %�����ж�Ϊ���������ص��ֵ��Ϊ��ʼ���ģ�ƥ����ֵ-1�����൱��ƥ�����+1��
            end
        end
    end
    % match the image and samples

    for kk = 2:numberOfSamples
        distance3 = uint8(abs(buffer - Samples{kk})...
            <= matchingDistance);%��3��~�����һ���ж�
        segmentationMap = segmentationMap - distance3;  %ÿ���ж�Ϊ�������-1��ֱ������ƥ����ֵ��ֵΪ0
    end
    
    segmentationMap = uint8(segmentationMap*255);       %����Ϊ0�ĵ��ֵ��ߵ�255
end