function Samples = vibeUpdate(buffer, updatingMask, Samples, parameter, ...
    jump, neighborX, neighborY, position)
    %% Parameters
    height  = parameter.height;
    width   = parameter.width;
    foregroundTimesThreshold = parameter.forgroundTimeThreshold;
    global foregroundtimes;
    %% Update Model
    for indY = 2:height - 1
        shift = floor(rand()*width) + 1;
        indX = jump(shift) + 1;
        while indX < width
            if updatingMask(indY, indX) == 0   %指视频帧中的该点被判断为背景点
                foregroundtimes (indY,indX) = 0;
                value = buffer(indY, indX);
                Samples{position(shift)}(indY, indX) = value;  %更新该点数据
                Samples{position(shift)}...                    %更新相邻点的数据
                        (indY + neighborY(shift), indX + neighborX(shift)) = value;
                
             
             else
                foregroundtimes (indY,indX) =  foregroundtimes (indY,indX) + 1; 
                if foregroundtimes (indY,indX) >= foregroundTimesThreshold   %前景检测次数大于阈值则判断为背景点
                    foregroundtimes (indY,indX) = 0;
                    value = buffer(indY, indX);
                    Samples{position(shift)}(indY, indX) = value;
                    Samples{position(shift)}...
                            (indY + neighborY(shift), indX + neighborX(shift)) = value;
                end
                 
             end
             shift = shift + 1;
             indX = indX + jump(shift);
        end
    end
    
end