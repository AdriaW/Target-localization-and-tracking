%����λ�㷨
%��λ��ʼ��
Length=100; %���ؿռ䳤�ȣ���λ����
Width=100;  %���ؿռ��ȣ���λ����
d=50;       %�۲�վ����������
Xnum=5;     %�۲�վ��ˮƽ����ĸ���
Ynum=5;     %�۲�վ�ڴ�ֱ����ĸ���
divX=Length/Xnum/2;divY=Width/Ynum/2;   %Ϊ�������м�鿴�۲�վ�ֲ�����������Ҫ������ͼ������ϵ���棩
 
%Ŀ����������ڼ�ⳡ�ص���ʵλ�ã�����Ҳ�������
Target.x=Width*(Xnum-1)/Xnum*rand;      %(Xnum-1)/Xnum��Ŀ���x���������ƣ��������ֻ�ܵ���80��80������Ϊ����ĳ��ؿռ�100*100Ϊ��-10-->90*-10-->90,�����(Xnum-1)/Xnum����Ŀ��λ�ÿ��ܣ�100,100���������˷�Χ
Target.y=Length*(Ynum-1)/Ynum*rand;     %ͬ��

DIST=[];   %���ù۲�վ��Ŀ��֮�����ļ���
for j=1:Ynum   %�۲�վ�������� j��ʾ����������������Ϊ1-->5
    for i=1:Xnum
        Station((j-1)*Xnum+i).x=(i-1)*Length/Xnum; %j=1: 1.x-->5.x   j=2: 6.x-->10.x  ...
        Station((j-1)*Xnum+i).y=(j-1)*Length/Ynum;
        dd=getDist(Station((j-1)*Xnum+i),Target);
        DIST=[DIST dd]; %=[DIST,dd];
    end
end

%�ҳ�̽�⵽Ŀ���ź���ǿ�������۲�վ��Ҳ������Ŀ������Ĺ۲�վ
[set,index]=sort(DIST) %setΪ���кõĴ�С�������ֵ���ϣ�indexΪ��������
NI=index(1:3);  %�����3������index1~3��Ԫ��
Est_Target.x=0;      %Ŀ�����λ��x��ʼ��
Est_Target.y=0;      %Ŀ�����λ��y��ʼ��
if DIST(NI(3))<d      %���3���������Ǹ����Ƿ��ڹ۲�վ��̽����뷶Χ֮��
    for i=1:3
        Est_Target.x=Est_Target.x+Station(NI(i)).x/3;      %Ŀ�����λ��x
        Est_Target.y=Est_Target.y+Station(NI(i)).y/3;      %Ŀ�����λ��y
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure      %��ͼ
hold on;box on;axis([0-divX Length-divX 0-divY Width-divX]);     %���ͼ�εĿ��
xx=[Station(NI(1)).x, Station(NI(2)).x, Station(NI(3)).x];
yy=[Station(NI(1)).y, Station(NI(2)).y, Station(NI(3)).y];
fill(xx,yy,'y');

for j=1:Ynum   %�۲�վ�������� j��ʾ����������������Ϊ1-->5
    for i=1:Xnum
        h1=plot(Station((j-1)*Xnum+i).x, Station((j-1)*Xnum+i).y, '-ko', 'markerface','g');
        text(Station((j-1)*Xnum+i).x+1, Station((j-1)*Xnum+i).y, num2str((j-1)*Xnum+i));
    end
end

Error_Dist=getDist(Est_Target,Target);
%��Ŀ�����ʵλ�ú͹���λ��
h2=plot(Target.x, Target.y,'k^','MarkerFace','b','MarkerSize',10);
h3=plot(Est_Target.x, Est_Target.y,'ks','MarkerFace','r','MarkerSize',10);
%������λ������ʵλ������������
line([Target.x,Est_Target.x],[Target.y,Est_Target.y],'color','k');
%����Ŀ�귽Բd�ķ�Χ
circle(Target.x,Target.y,d);
%����h1,h2,h3��ʲô
legend([h1,h2,h3],'observation station','target position', 'estimate position');
xlabel(['error=',num2str(Error_Dist),'m']);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
