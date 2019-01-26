%��άƽ����С���˶�λ�㷨
%��λ��ʼ��
Length=100; %���ؿռ䳤�ȣ���λ����
Width=100;  %���ؿռ��ȣ���λ����
d=50;       %�۲�վ����������
Node_number=5;  %�۲�վ�ĸ��������ٱ���������
n=Node_number;

for i=1:Node_number     %�۲�վ��λ�ó�ʼ��������λ�������������
    Node(i).x=Width*rand;
    Node(i).y=Length*rand;
    Node(i).D=Node(i).x^2+Node(i).y^2;  %�̶���������λ�ù���
end
    
%Ŀ����������ڼ�ⳡ�ص���ʵλ�ã�����Ҳ�������
Target.x=Width*rand;
Target.y=Length*rand;

%�۲�վ̽��Ŀ��
X=[];
Z=[];   %��������

for i=1:Node_number
    [d1,d2]=getDist(Node(i),Target);    %�۲�վ��Ŀ�����ʵ����
    d1=d1+sqrt(5)*randn;    %������������ܵ���ֵΪ5�ĸ�˹����������Ⱦ
    X=[X;Node(i).x,Node(i).y];
    Z=[Z,d1];
end

H=[];b=[];
for i=1:Node_number-1
    H=[H;2*(X(n,1)-X(i,1)),2*(X(n,2)-X(i,2))];
    b=[b;Z(i)^2-Z(n)^2+Node(n).D-Node(i).D];
end

Estimate=inv(H'*H)*H'*b;    %Ŀ��Ĺ���λ��
Est_Target.x=Estimate(1); Est_Target.y=Estimate(2);
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure      %��ͼ
hold on;box on;axis([0 100 0 100]);     %���ͼ�εĿ��

for i=1:Node_number
    h1=plot(Node(i).x,Node(i).y, 'ko', 'markerface','g','markersize',10);
    text(Node(i).x+2, Node(i).y,['Node',num2str(i)])
end

[Error_Dist,d2]=getDist(Est_Target,Target);
%��Ŀ�����ʵλ�ú͹���λ��
h2=plot(Target.x, Target.y,'k^','MarkerFace','b','MarkerSize',10);
h3=plot(Est_Target.x, Est_Target.y,'ks','MarkerFace','r','MarkerSize',10);
%������λ������ʵλ������������
line([Target.x,Est_Target.x],[Target.y,Est_Target.y],'color','k');
%����h1,h2,h3��ʲô
legend([h1,h2,h3],'observation station','target position', 'estimate position');
xlabel(['error=',num2str(Error_Dist),'m']);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
