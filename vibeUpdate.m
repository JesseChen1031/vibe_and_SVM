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
            if updatingMask(indY, indX) == 0   %ָ��Ƶ֡�еĸõ㱻�ж�Ϊ������
                foregroundtimes (indY,indX) = 0;
                value = buffer(indY, indX);
                Samples{position(shift)}(indY, indX) = value;  %���¸õ�����
                Samples{position(shift)}...                    %�������ڵ������
                        (indY + neighborY(shift), indX + neighborX(shift)) = value;
                
             
             else
                foregroundtimes (indY,indX) =  foregroundtimes (indY,indX) + 1; 
                if foregroundtimes (indY,indX) >= foregroundTimesThreshold   %ǰ��������������ֵ���ж�Ϊ������
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