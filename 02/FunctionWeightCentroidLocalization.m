%��Ȩ�����㷨
%��λ��ʼ��
Length=100; %���ؿռ䳤�ȣ���λ����
Width=100;  %���ؿռ��ȣ���λ����
d=50;       %�۲�վ����������
Node_number=6;        %�۲�վ����
SNR=50;     %�����,��λdb

for i=1:Node_number   %�۲�վλ�ó�ʼ����λ���������
    Node(i).x=Width*rand;
    Node(i).y=Length*rand;
end

%Ŀ������ڼ�ⳡ�ص���ʵλ�ã�����Ҳ�������
Target.x=Width*rand;
Target.y=Length*rand;
X=[];   %��ʼ�����ҳ���̽�⵽Ŀ��Ĺ۲�վ��λ�ü���
W=[];   %Ȩֵ 
for i=1:Node_number
    dd=getDist(Node(i),Target);
    Q=(1/dd)/(10^(20/SNR));  %��������ȹ�ʽ����������, �������S���������S=1/dd��ϵ
    if dd<=d
        X=[X;Node(i).x,Node(i).y];
        W=[W,1/((dd+sqrt(Q)*randn))^2]; %�ź�˥����ʽ
    end
end

%Ȩֵ��һ��
W=W./sum(W);    %��ʾW�е�ÿһ��ֵ��sum(W)���
M=size(X,1);    %̽�⵽Ŀ��Ĺ۲�վ����
sumx=0;sumy=0;
for i=1:M
    sumx=sumx+X(i,1)*W(i);
    sumy=sumy+X(i,2)*W(i);
end
Est_Target.x=sumx;      %Ŀ�����λ��x
Est_Target.y=sumy;      %Ŀ�����λ��y
Error_Dist=getDist(Est_Target,Target)      %Ŀ����ʵλ�������λ�õ�ƫ�����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure      %��ͼ
hold on;box on;axis([0 100 0 100]);     %���ͼ�εĿ��
for i=1:Node_number
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
