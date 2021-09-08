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
    distance = abs(buffer - Samples{1}) <= matchingDistance; %比较每个像素点灰度值与背景模型的灰度值的距离
    for ii = 1:height
        for jj = 1:width
            if ~distance(ii, jj)
                segmentationMap(ii, jj) = matchingNumber;
            else
                segmentationMap(ii, jj) = matchingNumber-1;
                %此处为第一次匹配，将判断为前景的像素点的灰度值赋为匹配阈值，为前景分割做准备；
                %而被判断为背景的像素点的值仍为初始化的（匹配阈值-1），相当于匹配次数+1。
            end
        end
    end
    % match the image and samples

    for kk = 2:numberOfSamples
        distance3 = uint8(abs(buffer - Samples{kk})...
            <= matchingDistance);%第3次~第最后一次判断
        segmentationMap = segmentationMap - distance3;  %每次判断为背景点就-1，直到超过匹配阈值后值为0
    end
    
    segmentationMap = uint8(segmentationMap*255);       %将不为0的点的值提高到255
end