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
        X=[X;Node(i).x, Node(i).y];  %����̽�⵽Ŀ��Ĺ۲�վλ��
    end 
end

M=size(X,1);    %̽�⵽Ŀ��Ĺ۲�վ����
if M>0
    Est_Target.x=sum(X(:,1))/M;     %�����㷨����λ��x
    Est_Target.y=sum(X(:,2))/M;     %�����㷨����λ��y
    Error_Dist=getDist(Est_Target,Target) %Ŀ����ʵλ�������λ�õ�ƫ�����
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure      %��ͼ
hold on;box on;axis([0 100 0 100]);     %���ͼ�εĿ��
for i=1:N
    h1=plot(Node(i).x,Node(i).y,'ko','markerface','g','MarkerSize',10); 
    text(Node(i).x+2,Node(i).y,['Node',num2str(i)]); %
end
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
