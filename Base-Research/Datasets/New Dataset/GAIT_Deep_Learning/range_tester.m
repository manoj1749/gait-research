 function [T] = range_tester(source_files1,source_files2,source_files3)
    SV_tot=[];
    SV_D=[];
    [a,b]=butter(6,0.1/30,'high');
%     source_files1=dir(fullfile(pwd,'*wrist*.xlsx'));
%     source_files2=dir(fullfile(pwd,'*knee*.xlsx'));
%     source_files3=dir(fullfile(pwd,'*ankle*.xlsx'));
    raw_data1=xlsread(source_files1);
    raw_data2=xlsread(source_files2);
    raw_data3=xlsread(source_files3);
    
    mindata1 = min(raw_data1);
    maxdata1 = max(raw_data1);
    mindata2 = min(raw_data2);
    maxdata2 = max(raw_data2);
    mindata3 = min(raw_data3);
    maxdata3 = max(raw_data3);
%     
    data1 = (raw_data1-mindata1)/(maxdata1-mindata1);
    data2 = (raw_data2-mindata2)/(maxdata2-mindata2);
    data3 = (raw_data3-mindata3)/(maxdata3-mindata3);

    SV_tot(1,1)=median(data1);
    SV_tot(2,1)=median(data2);
    SV_tot(3,1)=median(data3);
    
%     filt1=filter(a,b,data1);
%     filt2=filter(a,b,data2);
%     filt3=filter(a,b,data3);
%     
%     SV_D(1,1)=median(filt1);
%     SV_D(2,1)=median(filt2);
%     SV_D(3,1)=median(filt3);

%     Z(1,1)=median((data1.^2-filt1.^2)-(6.67259*10^-11))/2*(6.67259*10^-11);
%     Z(2,1)=median((data2.^2-filt2.^2)-(6.67259*10^-11))/2*(6.67259*10^-11);
%     Z(3,1)=median((data3.^2-filt3.^2)-(6.67259*10^-11))/2*(6.67259*10^-11);
   
%     sum_vectors=[SV_tot,SV_D,Z];
%     T=[SV_tot,SV_D,Z];
    T=[SV_tot];
        
 end