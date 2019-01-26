%��άƽ����С���˶�λ�㷨
%��λ��ʼ��
Length=100; %���ؿռ䳤�ȣ���λ����
Width=100;  %���ؿռ��ȣ���λ����
Height=100; %���ؿռ�߶ȣ���λ����
d=50;       %�۲�վ����������
Node_number=5;  %�۲�վ�ĸ��������ٱ�����4��
n=Node_number;
R=5;    %�۲�վ������������
for i=1:Node_number     %�۲�վ��λ�ó�ʼ��������λ�������������
    %�˴������ǹ۲�վ��ͬһƽ������������ͬһƽ�棬���ȹ��Ƴ�x,y,�����z
    Node(i).x=Width*rand;
    Node(i).y=Length*rand;
    Node(i).z=Height*rand;
    Node(i).D=Node(i).x^2+Node(i).y^2+Node(i).z^2;  %�̶���������λ�ù���
end
    
%Ŀ����������ڼ�ⳡ�ص���ʵλ�ã�����Ҳ�������
Target.x=Width*rand;
Target.y=Length*rand;
Target.z=Height*rand;

%�۲�վ̽��Ŀ��
X=[];   %��վ���۲�վ����λ�ü���
Z=[];   %��������

for i=1:Node_number
    [d1,d2]=getDist(Node(i),Target);    %�۲�վ��Ŀ�����ʵ����
    d1=d1+sqrt(R)*randn;    %������������ܵ���ֵΪ5�ĸ�˹����������Ⱦ
    X=[X;Node(i).x,Node(i).y,Node(i).z];
    Z=[Z,d1];
end

H=[];b=[];

for i=1:Node_number-1
    H=[H;2*(X(n,1)-X(i,1)),2*(X(n,2)-X(i,2)),2*(X(n,3)-X(i,3))];
    b=[b;Z(i)^2-Z(n)^2+Node(n).D-Node(i).D];
end

% for i=2:Node_number
%     H=[H;2*(X(i,1)-X(1,1)),2*(X(i,2)-X(1,2)),2*(X(i,3)-X(1,3))];
%     b=[b;Z(1)^2-Z(i)^2+Node(i).D-Node(1).D];
% end

Estimate=inv(H'*H)*H'*b;    %Ŀ��Ĺ���λ��
Est_Target.x=Estimate(1); Est_Target.y=Estimate(2); Est_Target.z=Estimate(3);
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure      %��ͼ
hold on;box on;axis([0 100 0 100 0 100]);     %���ͼ�εĿ��

for i=1:Node_number
    h1=plot3(Node(i).x,Node(i).y,Node(i).z, 'ko', 'markerface','g','markersize',10);
    text(Node(i).x+2, Node(i).y,Node(i).z,['Node',num2str(i)])
end

%��Ŀ�����ʵλ�ú͹���λ��
h2=plot3(Target.x, Target.y, Target.z,'k^','MarkerFace','b','MarkerSize',10);
h3=plot3(Est_Target.x, Est_Target.y, Est_Target.z,'ks','MarkerFace','r','MarkerSize',10);

[Error_Dist,d2]=getDist(Est_Target,Target);
%������λ������ʵλ������������
line([Target.x,Est_Target.x],[Target.y,Est_Target.y],[Target.z,Est_Target.z],'color','k');
%����h1,h2,h3��ʲô
legend([h1,h2,h3],'observation station','target position', 'estimate position');
xlabel(['error=',num2str(Error_Dist),'m']);
axis square; view(3); grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
