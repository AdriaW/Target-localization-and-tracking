%��λ��ʼ��
Length=100; %���ؿռ䳤�ȣ���λ����
Width=100;  %���ؿռ��ȣ���λ����
d=50;       %�۲�վ����������
N=6;        %�۲�վ����

for i=1:N   %�۲�վλ�ó�ʼ����λ���������
    Node(i).x=Width*rand;
    Node(i).y=Length*rand;
end

%Ŀ������ڼ�ⳡ�ص���ʵλ�ã�����Ҳ�������
Target.x=Width*rand;
Target.y=Length*rand;
X=[];   %��ʼ�����ҳ���̽�⵽Ŀ��Ĺ۲�վ��λ�ü���
for i=1:N
    if getDist(Node(i),Target)<=d
        X=[X;Node(i).x,Node(i).y];
    end 
end