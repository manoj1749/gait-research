function [output]=gait_classifier(file1,file2,file3)
% -------------------------------------------------------------------------

tic
clc
% clear all
% close all
counter=0;
stance=0;
swing=0;
output=[];
% -------------------------------------------------------------------------

[Trained_Lst,Trained_Lsw,Trained_Rst,Trained_Rsw]=range_trainer();
T=range_tester(file1,file2,file3);

% -------------------------------------------------------------------------
if(counter==0)
    L_st_min=[5 5 5];
    L_sw_min=[5 5 5];
    R_st_min=[5 5 5];
    R_sw_min=[5 5 5];
    for i=1:3
        for j=1:3
            for k=1:5
              temp= Trained_Lst{i,1}(j,k)-T(i,1);
              if(i==1)
                 if(abs(temp)<=abs(L_st_min(i)))
                    L_st_min(i)=temp;
                    x(i)=Trained_Lst{i,1}(j,k);
                 end
              end
              if(i==2)
                 if(abs(temp)<=abs(L_st_min(i)))
                    L_st_min(i)=temp;
                    x(i)=Trained_Lst{i,1}(j,k);
                 end
              end
              if(i==3)  
                 if(abs(temp)<=abs(L_st_min(i)))
                    L_st_min(i)=temp;
                    x(i)=Trained_Lst{i,1}(j,k);
                 end
              end
            end                
        end
    end
    counter=0;
    for i=1:3
        for j=1:3
            for k=1:5
              temp= Trained_Lsw{i,1}(j,k)-T(i,1);
              if(i==1)
                 if(abs(temp)<abs(L_sw_min(i)))
                    L_sw_min(i)=temp;
                    x(i)=Trained_Lsw{i,1}(j,k);
                 end
              end
              if(i==2)
                 if(abs(temp)<abs(L_sw_min(i)))
                     L_sw_min(i)=temp;
                     x(i)=Trained_Lsw{i,1}(j,k);
                 end
              end
              if(i==3)
                 if(abs(temp)<abs(L_sw_min(i)))
                    L_sw_min(i)=temp;
                    x(i)=Trained_Lsw{i,1}(j,k);
                 end
              end
            end                
        end
    end
    counter=0;
    for i=1:3
        for j=1:3
            for k=1:5
              temp= Trained_Rst{i,1}(j,k)-T(i,1);
              if(i==1)
                 if(abs(temp)<abs(R_st_min(i)))
                    R_st_min(i)=temp;
                    x(i)=Trained_Rst{i,1}(j,k);
                 end
              end
              if(i==2)
                 if(abs(temp)<abs(R_st_min(i)))
                     R_st_min(i)=temp;
                     x(i)=Trained_Rst{i,1}(j,k);
                 end
              end
              if(i==3)
                 if(abs(temp)<abs(R_st_min(i)))
                    R_st_min(i)=temp;
                    x(i)=Trained_Rst{i,1}(j,k);
                 end
              end
            end                
        end
    end
    counter=0;
    for i=1:3
        for j=1:3
            for k=1:5
              temp= Trained_Rsw{i,1}(j,k)-T(i,1);
              if(i==1)
                 if(abs(temp)<abs(R_sw_min(i)))
                    R_sw_min(i)=temp;
                    x(i)=Trained_Rsw{i,1}(j,k);
                 end
              end
              if(i==2)
                 if(abs(temp)<abs(R_sw_min(i)))
                     R_sw_min(i)=temp;
                     x(i)=Trained_Rsw{i,1}(j,k);
                 end
              end
              if(i==3)
                 if(abs(temp)<abs(R_sw_min(i)))
                    R_sw_min(i)=temp;
                    x(i)=Trained_Rsw{i,1}(j,k);
                 end
              end
            end                
        end
    end
   
% ------------------------------------------------------------------------- 
   
% -------------------------------------------------------------------------

    if(counter==0)
    if(abs(L_st_min(1))<abs(L_sw_min(1)) & abs(L_st_min(1))<abs(R_sw_min(1)))
        if(abs(L_st_min(2))<abs(L_sw_min(2)) & abs(L_st_min(2))<abs(R_sw_min(2)))
            if(abs(L_st_min(3))<abs(L_sw_min(3)) & abs(L_st_min(3))<abs(R_sw_min(3)))
                disp('Data is from stance')
                output='stance';
                counter=1;
                t=L_st_min;
            end
        end
    end
    end
    if(counter==0)
    if(abs(L_sw_min(1))<abs(L_st_min(1)) & abs(L_sw_min(1))<abs(R_st_min(1)))
        if(abs(L_sw_min(2))<abs(L_st_min(2)) & abs(L_sw_min(2))<abs(R_st_min(2)))
            if(abs(L_sw_min(3))<abs(L_st_min(3)) & abs(L_sw_min(3))<abs(R_st_min(3)))
                disp('Data is from swing')
                output='swing';
                counter=1;
                t=L_sw_min;
            end
        end
    end
    end
    if(counter==0)
    if(abs(R_st_min(1))<abs(L_sw_min(1)) & abs(R_st_min(1))<abs(R_sw_min(1)))
        if(abs(R_st_min(2))<abs(L_sw_min(2)) & abs(R_st_min(2))<abs(R_sw_min(2)))
            if(abs(R_st_min(3))<abs(L_sw_min(3)) & abs(R_st_min(3))<abs(R_sw_min(3)))
                disp('Data is from stance')
                output='stance';
                counter=1;
            end
        end
    end
    end
    if(counter==0)
    if(abs(R_sw_min(1))<abs(L_st_min(1)) & abs(R_sw_min(1))<abs(R_st_min(1)))
        if(abs(R_sw_min(2))<abs(L_st_min(2)) & abs(R_sw_min(2))<abs(R_st_min(2)))
            if(abs(R_sw_min(3))<abs(L_st_min(3)) & abs(R_sw_min(3))<abs(R_st_min(3)))
                disp('Data is from swing')
                output='swing';
                counter=1;
                t=R_sw_min;                
            end
        end
    end
    end
    
% -------------------------------------------------------------------------    
    if(counter==0)
    if(abs(L_st_min(1))<abs(L_sw_min(1))&abs(L_st_min(1))<abs(R_sw_min(1)))
        if(abs(L_st_min(2))<abs(L_sw_min(2))&abs(L_st_min(2))<abs(R_sw_min(2)))
            t=[L_st_min(1) L_st_min(2) L_st_min(3)];
            disp('stance')
            output='stance';
            counter=1;
        end
    end
    if(abs(abs(L_st_min(1))-abs(L_sw_min(1)))>0.1&abs(abs(L_st_min(1))-abs(R_sw_min(1)))>0.1)
        if(abs(abs(L_st_min(2))-abs(L_sw_min(2)))>0.1&abs(abs(L_st_min(2))-abs(R_sw_min(2)))>0.1)
            t=[L_st_min(1) L_st_min(2) L_st_min(3)];
            disp('stance')
            output='stance';
            counter=1;
        end
    end
    end
    if(counter==0)
    if(abs(L_st_min(1))<abs(L_sw_min(1))&abs(L_st_min(1))<abs(R_sw_min(1)))
        if(abs(L_st_min(3))<abs(L_sw_min(3))&abs(L_st_min(3))<abs(R_sw_min(3)))
            t=[L_st_min(1) L_st_min(2) L_st_min(3)];
            disp('stance')
            output='stance';
            counter=1;
        end
    end
    if(abs(abs(L_st_min(1))-abs(L_sw_min(1)))>0.1&abs(abs(L_st_min(1))-abs(R_sw_min(1)))>0.1)
        if(abs(abs(L_st_min(3))-abs(L_sw_min(3)))>0.1&abs(abs(L_st_min(3))-abs(R_sw_min(3)))>0.1)
            t=[L_st_min(1) L_st_min(2) L_st_min(3)];
            disp('stance')
            output='stance';
            counter=1;
        end
    end
    end
    if(counter==0)
    if(abs(L_st_min(3))<abs(L_sw_min(3))&abs(L_st_min(3))<abs(R_sw_min(3)))
        if(abs(L_st_min(2))<abs(L_sw_min(2))&abs(L_st_min(2))<abs(R_sw_min(2)))
            t=[L_st_min(1) L_st_min(2) L_st_min(3)];
            disp('stance')
            output='stance';
            counter=1;
        end
    end
    if(abs(abs(L_st_min(3))-abs(L_sw_min(3)))>0.1&abs(abs(L_st_min(3))-abs(R_sw_min(3)))>0.1)
        if(abs(abs(L_st_min(2))-abs(L_sw_min(2)))>0.1&abs(abs(L_st_min(2))-abs(R_sw_min(2)))>0.1)
            t=[L_st_min(1) L_st_min(2) L_st_min(3)];
            disp('stance')
            output='stance';
            counter=1;
        end
    end
    end
    
% -------------------------------------------------------------------------
    if(counter==0)
    if(abs(R_st_min(1))<abs(L_sw_min(1))&abs(R_st_min(1))<abs(R_sw_min(1)))
        if(abs(R_st_min(2))<abs(L_sw_min(2))&abs(R_st_min(2))<abs(R_sw_min(2)))
            t=[R_st_min(1) R_st_min(2) R_st_min(3)];
            disp('stance')
            output='stance';
            counter=1;
            t=R_st_min;
        end
    end
    if(abs(abs(R_st_min(1))-abs(L_sw_min(1))>0.1&abs(abs(R_st_min(1))-abs(R_sw_min(1)))>0.1))
        if(abs(abs(R_st_min(2))-abs(L_sw_min(2))>0.1&abs(abs(R_st_min(2))-abs(R_sw_min(2)))>0.1))
            t=[R_st_min(1) R_st_min(2) R_st_min(3)];
            disp('stance')
            output='stance';
            counter=1;
            t=R_st_min;
        end
    end
    end
    if(counter==0)
    if(abs(R_st_min(1))<abs(L_sw_min(1))&abs(R_st_min(1))<abs(R_sw_min(1)))
        if(abs(R_st_min(3))<abs(L_sw_min(3))&abs(R_st_min(3))<abs(R_sw_min(3)))
            t=[R_st_min(1) R_st_min(2) R_st_min(3)];
            disp('stance')
            output='stance';
            counter=1;
            t=R_st_min;
        end
    end
    if(abs(abs(R_st_min(1))-abs(L_sw_min(1))>0.1&abs(abs(R_st_min(1))-abs(R_sw_min(1)))>0.1))
        if(abs(abs(R_st_min(3))-abs(L_sw_min(3))>0.1&abs(abs(R_st_min(3))-abs(R_sw_min(3)))>0.1))
            t=[R_st_min(1) R_st_min(2) R_st_min(3)];
            disp('stance')
            output='stance';
            counter=1;
            t=R_st_min;
        end
    end
    end
    if(counter==0)
    if(abs(R_st_min(3))<abs(L_sw_min(3))&abs(R_st_min(3))<abs(R_sw_min(3)))
        if(abs(R_st_min(2))<abs(L_sw_min(2))&abs(R_st_min(2))<abs(R_sw_min(2)))
            t=[R_st_min(1) R_st_min(2) R_st_min(3)];
            disp('stance')
            output='stance';
            counter=1;
            t=R_st_min;
        end
    end
    if(abs(abs(R_st_min(3))-abs(L_sw_min(3))>0.1&abs(abs(R_st_min(3))-abs(R_sw_min(3)))>0.1))
        if(abs(abs(R_st_min(2))-abs(L_sw_min(2))>0.1&abs(abs(R_st_min(2))-abs(R_sw_min(2)))>0.1))
            t=[R_st_min(1) R_st_min(2) R_st_min(3)];
            disp('stance')
            output='stance';
            counter=1;
            t=R_st_min;
        end
    end
    end
  
% -------------------------------------------------------------------------                

if(counter==0)                
if(abs(R_sw_min(1))<abs(L_st_min(1))&abs(R_sw_min(1))<abs(R_st_min(1)))
    if(abs(R_sw_min(2))<abs(L_st_min(2))&abs(R_sw_min(2))<abs(R_st_min(2)))
        t=[R_sw_min(1) R_sw_min(2) R_sw_min(3)];
        disp('swing')
        output='swing';
        counter=1;
    end
end
if(abs(abs(R_sw_min(1))-abs(L_st_min(1))>0.1&abs(R_sw_min(1))-abs(R_st_min(1))>0.1))
    if(abs(abs(R_sw_min(2))-abs(L_st_min(2))>0.1&abs(abs(R_sw_min(2))-abs(R_st_min(2))>0.1)))
        t=[R_sw_min(1) R_sw_min(2) R_sw_min(3)];
        disp('swing')
        output='swing';
        counter=1;
    end
end
end
if(counter==0)
if(abs(R_sw_min(1))<abs(L_st_min(1))&abs(R_sw_min(1))<abs(R_st_min(1)))
    if(abs(R_sw_min(3))<abs(L_st_min(3))&abs(R_sw_min(3))<abs(R_st_min(3)))
        t=[R_sw_min(1) R_sw_min(2) R_sw_min(3)];
        disp('swing')
        output='swing';
        counter=1;
    end
end
if(abs(abs(R_sw_min(1))-abs(L_st_min(1))>0.1&abs(abs(R_sw_min(1))-abs(R_st_min(1)))>0.1))
    if(abs(abs(R_sw_min(3))-abs(L_st_min(3))>0.1&abs(abs(R_sw_min(3))-abs(R_st_min(3)))>0.1))
        t=[R_sw_min(1) R_sw_min(2) R_sw_min(3)];
        disp('swing')
        output='swing';
        counter=1;
    end
end
end
if(counter==0)
if(abs(R_sw_min(3))<abs(L_st_min(3))&abs(R_sw_min(3))<abs(R_st_min(3)))
    if(abs(R_sw_min(2))<abs(L_st_min(2))&abs(R_sw_min(2))<abs(R_st_min(2)))
        t=[R_sw_min(1) R_sw_min(2) R_sw_min(3)];
        disp('swing')
        output='swing';
        counter=1;
    end
end
if(abs(abs(R_sw_min(3))-abs(L_st_min(3))>0.1&abs(abs(R_sw_min(3))-abs(R_st_min(3)))>0.1))
    if(abs(abs(R_sw_min(2))-abs(L_st_min(2))>0.1&abs(abs(R_sw_min(2))-abs(R_st_min(2)))>0.1))
        t=[R_sw_min(1) R_sw_min(2) R_sw_min(3)];
        disp('swing')
        output='swing';
        counter=1;
    end
end
end
  
% -------------------------------------------------------------------------                
if(counter==0)
if(abs(L_sw_min(1))<abs(L_st_min(1))&abs(L_sw_min(1))<abs(R_st_min(1)))
    if(abs(L_sw_min(2))<abs(L_st_min(2))&abs(L_sw_min(2))<abs(R_st_min(2)))
        t=[L_sw_min(1) L_sw_min(2) L_sw_min(3)];
        disp('swing')
        output='swing';
        counter=1;
    end
end
if(abs(abs(L_sw_min(1))-abs(L_st_min(1))>0.1&abs(abs(L_sw_min(1))-abs(R_st_min(1)))>0.1))
    if(abs(abs(L_sw_min(2))-abs(L_st_min(2))>0.1&abs(abs(L_sw_min(2))-abs(R_st_min(2)))>0.1))
        t=[L_sw_min(1) L_sw_min(2) L_sw_min(3)];
        disp('swing')
        output='swing';
        counter=1;
    end
end
end
if(counter==0)
if(abs(L_sw_min(1))<abs(L_st_min(1))&abs(L_sw_min(1))<abs(R_st_min(1)))
    if(abs(L_sw_min(3))<abs(L_st_min(3))&abs(L_sw_min(3))<abs(R_st_min(3)))
        t=[L_sw_min(1) L_sw_min(2) L_sw_min(3)];
        disp('swing')
        output='swing';
        counter=1;
    end
end
if(abs(abs(L_sw_min(1))-abs(L_st_min(1))>0.1&abs(abs(L_sw_min(1))-abs(R_st_min(1)))>0.1))
    if(abs(abs(L_sw_min(3))-abs(L_st_min(3))>0.1&abs(abs(L_sw_min(3))-abs(R_st_min(3)))>0.1))
        t=[L_sw_min(1) L_sw_min(2) L_sw_min(3)];
        disp('swing')
        output='swing';
        counter=1;
    end
end
end
if(counter==0)
if(abs(L_sw_min(3))<abs(L_st_min(3))&abs(L_sw_min(3))<abs(R_st_min(3)))
    if(abs(L_sw_min(2))<abs(L_st_min(2))&abs(L_sw_min(2))<abs(R_st_min(2)))
        t=[L_sw_min(1) L_sw_min(2) L_sw_min(3)];
        disp('swing')
        output='swing';
        counter=1;
    end
end
if(abs(abs(L_sw_min(3))-abs(L_st_min(3))>0.1&abs(abs(L_sw_min(3))-abs(R_st_min(3)))>0.1))
    if(abs(abs(L_sw_min(2))-abs(L_st_min(2))>0.1&abs(abs(L_sw_min(2))-abs(R_st_min(2)))>0.1))
        t=[L_sw_min(1) L_sw_min(2) L_sw_min(3)];
        disp('swing')
        output='stance';
        counter=1;
    end
end
end
output
%     Actual=T'
%     [n_T]=hebbian_algo(T,x);
%     disp(n_T)
%     [w b]=HebbNN(T);
%     disp(w)
end 
% test1 = 'haitest'

      


%     err1=T;
%     err2=x';
%     diff=err1-err2;
%     if mean(diff)<=0.02
%             disp('chances to become stacnce')
%     end
    
%     err1=T;
%     err2=x';
%     diff=err1-err2;
%     if mean(diff)<=0.02
%        disp('chances to become swing')
%     end
         
    
        
 
%     for i=1:5
%         for k=1:18
%             if(abs(st(i,k))<abs(sw(i,k)))
%                 stance=stance+1;
%             elseif(abs(st(i,k))>abs(sw(i,k)))
%                 swing=swing+1;
%             end
%         end
%     end
%     if(swing>1 || stance>1)
% % error=((approx-exact)/exact)*100
% % approx. stance-exact stance ==> go to satnce
%     else
%         perc1=0;
%         perc2=0;
%     end
%          sprintf('There is %f percent chance of data belonging to swing and\n %f chance of belonging to stance',perc1,perc2)

toc
% ==========================END OF PROGRAM==============================
