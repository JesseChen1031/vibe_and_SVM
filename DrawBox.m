function DrawBox(xColMin,xColMax,yRowMin ,yRowMax)%������򣬷ֱ���������ߣ��ұ����ߣ�������ߣ��������
hold on 
plot([xColMin xColMax],[yRowMin yRowMin],'y')
plot([xColMin xColMax],[yRowMax yRowMax],'y')
plot([xColMin xColMin],[yRowMin yRowMax],'y')
plot([xColMax xColMax],[yRowMin yRowMax],'y')