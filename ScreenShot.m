clear; clc; close all;
object=imread('1.jpg');
[RawHeight,RawWidth]=size(object);
RectangleWidth=32;
RectangleHeight=32; %���ƻ������ڴ�С


ScanParameter=16;%���ƻ�������ƶ�����
ScanRow=1;
ScanCol=1;


PedestrianCount=1;
savefile=['Finalsamples/0/',num2str(PedestrianCount),'.bmp'];

%% Main
while(RectangleHeight+ScanRow<=RawHeight&&RectangleWidth+ScanCol<=RawWidth)
    while(ScanRow+RectangleHeight<=RawHeight)
        ScanCol=1;
        while(ScanCol+RectangleWidth<=RawWidth)
            Cut=object(ScanRow:ScanRow+RectangleHeight-1,ScanCol:ScanCol+RectangleWidth-1);
    
        
            savefile=['Finalsamples/0/',int2str(PedestrianCount),'.bmp'];
            imwrite(Cut,savefile,'bmp');
            PedestrianCount=PedestrianCount+1;

            ScanCol=ScanCol+ScanParameter;
        end
        ScanRow=ScanRow+ScanParameter;
    end                             
end
