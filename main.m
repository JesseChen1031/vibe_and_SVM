%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Author��CHX
% ViBe code reference��Brilliantdo��CSDN���Լ�
%                      http://www2.ulg.ac.be/telecom/research/vibe/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; clc; close all;
%% ����
parameter.numberOfSamples           = 20; %����������
parameter.matchingDistance          = 21; %����ƥ�������ֵ��С����ֵΪƥ��
parameter.matchingNumber            = 2;  %ʵ������ƥ����ֵ
parameter.updateFactor              = 5;
parameter.lastHistoryImageSwapped   = 0;
parameter.forgroundTimeThreshold    = 20; %ǰ��������ֵ
parameter.RectangleWidth            = 32; %ɨ���Ŀ�
parameter.RectangleHeight           = 32; %ɨ���ĸ�
global foregroundtimes ;              %ǰ������


%% ��ȡ��Ƶ����ȡ��Ƶ�ĳ������Ϣ
filename = 'TestVideo.mp4';             %��Ҫ��ȡ����Ƶ����
video = VideoReader(filename);

firstFrame = true;
height = video.Height;
width = video.Width;

parameter.height = height;
parameter.width = width;
foregroundtimes = zeros(width,height); %��ÿ�����ص��ǰ������Ԥ��Ϊ0


%% ѵ���������õ�Ԥ��ģ��
TrainSVM;
loopcount=1;
%% ViBe�˶�Ŀ�����Լ�������
while hasFrame(video)            %ѭ��ֱ����Ƶ��ÿһ֡����ȡ���
    vidFrame = readFrame(video); %��ȡ֡��
    showFrame = vidFrame;         %�����������չ����֡��
    vidFrame = rgb2gray(vidFrame);%��֡���ҶȻ�
    vidFrame = double(vidFrame);  %���Ҷ����ݴ���Ϊ˫��������

    tic;                          %��ʱ��ʼ
    if firstFrame                 %�ж��Ƿ�Ϊ��һ֡
        firstFrame = false;
        initViBe;                 %��ʼ��ViBe
    end
    segmentationMap = vibeSegmentation(vidFrame,...
    Samples, parameter);    %ǰ����ȡ�����˶�Ŀ����
    Samples = vibeUpdate(vidFrame,...
        segmentationMap, Samples, parameter, ...
        jump, neighborX, neighborY, position);  %��������
    segmentationMap = medfilt2(segmentationMap);
    
   
    [Drawcenter,Num] = SVMdetection(segmentationMap,parameter);  %������������⣬���������λ���Լ�����
    str = {'��ǰ����:',int2str(Num)};
    figure(1);
    imshow(showFrame);
    title('Detection-By CHX'),text(8,20,str,'Color','green','FontSize',10); %��ʾ����
    hold on
    for i=1:Num
        DrawBox(Drawcenter(i,1)-16,Drawcenter(i,1)+16,...
            Drawcenter(i,2)-16,Drawcenter(i,2)+16);
        
    end
    
    print(figure(1),strcat('ʵ����/Final2/',num2str(loopcount),'.bmp'),'-dbmp');
   


    toc;                         %��ʱ����
    loopcount=loopcount+1;
end