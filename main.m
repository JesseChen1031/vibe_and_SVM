%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Author：CHX
% ViBe code reference：Brilliantdo（CSDN）以及
%                      http://www2.ulg.ac.be/telecom/research/vibe/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; clc; close all;
%% 参数
parameter.numberOfSamples           = 20; %定义样本数
parameter.matchingDistance          = 21; %定义匹配距离阈值，小于阈值为匹配
parameter.matchingNumber            = 2;  %实际上是匹配阈值
parameter.updateFactor              = 5;
parameter.lastHistoryImageSwapped   = 0;
parameter.forgroundTimeThreshold    = 20; %前景计数阈值
parameter.RectangleWidth            = 32; %扫描框的宽
parameter.RectangleHeight           = 32; %扫描框的高
global foregroundtimes ;              %前景计数


%% 读取视频并获取视频的长宽等信息
filename = 'TestVideo.mp4';             %需要读取的视频名字
video = VideoReader(filename);

firstFrame = true;
height = video.Height;
width = video.Width;

parameter.height = height;
parameter.width = width;
foregroundtimes = zeros(width,height); %将每个像素点的前景计数预设为0


%% 训练样本，得到预测模型
TrainSVM;
loopcount=1;
%% ViBe运动目标检测以及人类检测
while hasFrame(video)            %循环直至视频的每一帧都读取完毕
    vidFrame = readFrame(video); %获取帧数
    showFrame = vidFrame;         %保留用于最后展出的帧数
    vidFrame = rgb2gray(vidFrame);%将帧数灰度化
    vidFrame = double(vidFrame);  %将灰度数据储存为双精度数组

    tic;                          %计时开始
    if firstFrame                 %判断是否为第一帧
        firstFrame = false;
        initViBe;                 %初始化ViBe
    end
    segmentationMap = vibeSegmentation(vidFrame,...
    Samples, parameter);    %前景提取，即运动目标检测
    Samples = vibeUpdate(vidFrame,...
        segmentationMap, Samples, parameter, ...
        jump, neighborX, neighborY, position);  %背景更新
    segmentationMap = medfilt2(segmentationMap);
    
   
    [Drawcenter,Num] = SVMdetection(segmentationMap,parameter);  %进行人流量检测，返回人类的位置以及数量
    str = {'当前人数:',int2str(Num)};
    figure(1);
    imshow(showFrame);
    title('Detection-By CHX'),text(8,20,str,'Color','green','FontSize',10); %显示人数
    hold on
    for i=1:Num
        DrawBox(Drawcenter(i,1)-16,Drawcenter(i,1)+16,...
            Drawcenter(i,2)-16,Drawcenter(i,2)+16);
        
    end
    
    print(figure(1),strcat('实验结果/Final2/',num2str(loopcount),'.bmp'),'-dbmp');
   


    toc;                         %计时结束
    loopcount=loopcount+1;
end