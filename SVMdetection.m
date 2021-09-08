function [Drawcenter,Num] = SVMdetection(object,param)


%% Parameters
% cellsize=param.cellsize;
RectangleWidth=param.RectangleWidth;
RectangleHeight=param.RectangleHeight; %���ƻ������ڴ�С
global classifier;


[RawHeight,RawWidth]=size(object);
ScanParameter=16;%���ƻ�������ƶ�����
ScanRow=1;
ScanCol=1;
Boxcenter=zeros(50,2);

PedestrianCount=1;


%% Main
while(RectangleHeight+ScanRow<=RawHeight&&RectangleWidth+ScanCol<=RawWidth)
    while(ScanRow+RectangleHeight<=RawHeight)
        ScanCol=1;
        while(ScanCol+RectangleWidth<=RawWidth)
            Cut=object(ScanRow:ScanRow+RectangleHeight-1,ScanCol:ScanCol+RectangleWidth-1);
            Cut=bwareaopen(Cut,150);
            ResizeCut=imresize(Cut,[32 32]);
            CutFeatures = extractHOGFeatures(ResizeCut);
            label = predict(classifier,CutFeatures);
            if(label==char('1'))%�����Ϊ����
                CurrentcenterX=(ScanCol+(ScanCol+RectangleWidth))/2;
                CurrentcenterY=(ScanRow+(ScanRow+RectangleHeight))/2;
                SaveFlag=1;
                for centerIndex=1:length(Boxcenter(:))/2
                    if(sqrt((Boxcenter(centerIndex,1)-CurrentcenterX)^2+(Boxcenter(centerIndex,2)-CurrentcenterY)^2)<=28)
                        Boxcenter(centerIndex,1)=(Boxcenter(centerIndex,1)+CurrentcenterX)/2; %�жϣ���Ϊ�ظ�ѡȡ����ȡ�е�
                        Boxcenter(centerIndex,2)=(Boxcenter(centerIndex,2)+CurrentcenterY)/2;
                        SaveFlag=0;
                        break;
                    end
                end
                if(SaveFlag==1)
                   Boxcenter(PedestrianCount,1)= CurrentcenterX;
                   Boxcenter(PedestrianCount,2)= CurrentcenterY;
                   PedestrianCount= PedestrianCount+1;
                  
                end
        
            end  
            ScanCol=ScanCol+ScanParameter;
        end
        ScanRow=ScanRow+ScanParameter;
    end                             
end

Drawcenter= Boxcenter;
Num=PedestrianCount-1;


