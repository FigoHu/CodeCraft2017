function [F,all] = cdn( W,C,consumer,need,price )
    [n w c v0]=construct(W,C,consumer,need);
    last_all=inf;
    r=2;
    alist=[];
    count=0;
    while 1
        F=MCF(n,w,c,v0);
        tore=find(F(1,:)>0);
        cost=price*length(tore);
        %w(1,:)=w(1,:)./2;%����˥��
        %w(1,tore)=cost./sum(need);%ȫ�־�̯
        w(1,tore)=price./F(1,tore);%�ڵ��̯
        %for k=tore w(1,k)=price./f(1,k).*sum(c(:,k))./sum(c(k,:));end%������ɢ�ͽڵ�
        for k=tore 
            if sum(F(2:end,k))>0 w(1,k)=w(1,k)*2; end
        end
        all=cost+sum(sum(F(2:end,:).*w(2:end,:)));
        %F,w,all
        c(1,r)=sum(need);
        
        if length(tore)>1 tore(find(tore==r))=[];r=tore(randi(length(tore)));
        if min(alist)<all c(1,r)=0;end 
        end
        
        if min(alist)==all
            count=count+1;
        else count=0;
        end
        if count==3 break;
        end
        
        last_all=all;
        alist=[alist all];
        
    end
end
