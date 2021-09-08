function DrawBox(xColMin,xColMax,yRowMin ,yRowMax)%画框程序，分别是左边竖线，右边竖线，上面横线，下面横线
hold on 
plot([xColMin xColMax],[yRowMin yRowMin],'y')
plot([xColMin xColMax],[yRowMax yRowMax],'y')
plot([xColMin xColMin],[yRowMin yRowMax],'y')
plot([xColMax xColMax],[yRowMin yRowMax],'y')