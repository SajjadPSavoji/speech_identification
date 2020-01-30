function [predict] = knn_classifier(test,train,k)
%this function determines the nearest neighbor using knn algorithem
% using knn_search
test=test.';
train=train.';
idx=knnsearch(train,test,'k',k);
predict=floor(mode(idx)/100)+1;
predict=mode(predict);


% % costum
% distance=zeros(800,100);
% for i=1:100
%     for j=1:800
%         distance(j,i)=sum((test(:,i)-train(:,j)).^2);
%     end
% end
% [B,I]=mink(distance,k);
% C=reshape(B,[],1);
% [BC,IC]=mink(C,k);
% temp=zeros(k,1);
% for i=1:k
%       temp(i,1)=floor(I(IC(k)-floor(IC(k)/k)*k , floor(IC(k)/k)+1)/100)+1;
% end
% predict=mode(temp);
