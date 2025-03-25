function [Trained_Lst,Trained_Lsw,Trained_Rst,Trained_Rsw]=range_trainer()

SV_tot_max=[];
SV_D_std_max=[];
Z_max=[];
% joint=[];
% [a,b]=butter(6,0.1/30,'high');
        
        for i=1:5
            directory1=sprintf('/home/icts/Desktop/windows/Sagar_gait_gui/EUCLIDEAN/subject 1/trial 1/CYCLE 1/left swing',i);    
            directory2=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 1\\left stance\\euclidean',i);
            directory3=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 1\\left stance\\euclidean',i);    
            directory4=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 2\\left stance\\euclidean',i);    
            directory5=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 2\\left stance\\euclidean',i);
            directory6=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 2\\left stance\\euclidean',i);    
            directory7=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 3\\left stance\\euclidean',i);    
            directory8=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 3\\left stance\\euclidean',i);
            directory9=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 3\\left stance\\euclidean',i); 
            source_files1=dir(fullfile(directory1,'*hip*.xlsx'));
            source_files2=dir(fullfile(directory2,'*knee*.xlsx'));
            source_files3=dir(fullfile(directory3,'*ankle*.xlsx'));
            source_files4=dir(fullfile(directory4,'*hip*.xlsx'));
            source_files5=dir(fullfile(directory5,'*knee*.xlsx'));
            source_files6=dir(fullfile(directory6,'*ankle*.xlsx'));
            source_files7=dir(fullfile(directory7,'*hip*.xlsx'));
            source_files8=dir(fullfile(directory8,'*knee*.xlsx'));
            source_files9=dir(fullfile(directory9,'*ankle*.xlsx'));
            file1=horzcat(source_files1.folder,'\',source_files1.name);
            file2=horzcat(source_files2.folder,'\',source_files2.name);
            file3=horzcat(source_files3.folder,'\',source_files3.name);
            file4=horzcat(source_files4.folder,'\',source_files4.name);
            file5=horzcat(source_files5.folder,'\',source_files5.name);
            file6=horzcat(source_files6.folder,'\',source_files6.name);
            file7=horzcat(source_files7.folder,'\',source_files7.name);
            file8=horzcat(source_files8.folder,'\',source_files8.name);
            file9=horzcat(source_files9.folder,'\',source_files9.name);
            
            raw_data1=xlsread(file1);
            raw_data2=xlsread(file2);
            raw_data3=xlsread(file3);
            raw_data4=xlsread(file4);
            raw_data5=xlsread(file5);
            raw_data6=xlsread(file6);
            raw_data7=xlsread(file7);
            raw_data8=xlsread(file8);
            raw_data9=xlsread(file9);
            
%             xlswrite('')
            
            mindata1 = min(raw_data1);
            maxdata1 = max(raw_data1);
            mindata2 = min(raw_data2);
            maxdata2 = max(raw_data2);
            mindata3 = min(raw_data3);
            maxdata3 = max(raw_data3);
            mindata4 = min(raw_data4);
            maxdata4 = max(raw_data4);
            mindata5 = min(raw_data5);
            maxdata5 = max(raw_data5);
            mindata6 = min(raw_data6);
            maxdata6 = max(raw_data6);
            mindata7 = min(raw_data7);
            maxdata7 = max(raw_data7);
            mindata8 = min(raw_data8);
            maxdata8 = max(raw_data8);
            mindata9 = min(raw_data9);
            maxdata9 = max(raw_data9);
            
            data1 = (raw_data1-mindata1)/(maxdata1-mindata1);
            data2 = (raw_data2-mindata2)/(maxdata2-mindata2);
            data3 = (raw_data3-mindata3)/(maxdata3-mindata3);
            data4 = (raw_data4-mindata4)/(maxdata4-mindata4);
            data5 = (raw_data5-mindata5)/(maxdata5-mindata5);
            data6 = (raw_data6-mindata6)/(maxdata6-mindata6);
            data7 = (raw_data7-mindata7)/(maxdata7-mindata7);
            data8 = (raw_data8-mindata8)/(maxdata8-mindata8);
            data9 = (raw_data9-mindata9)/(maxdata9-mindata9);
        
            SV_tot_max(1,i)=median(data1);
            SV_tot_max(2,i)=median(data2);
            SV_tot_max(3,i)=median(data3);
            SV_tot_max(4,i)=median(data4);
            SV_tot_max(5,i)=median(data5);
            SV_tot_max(6,i)=median(data6);
            SV_tot_max(7,i)=median(data7);
            SV_tot_max(8,i)=median(data8);
            SV_tot_max(9,i)=median(data9);
            
%             filt1=filter(a,b,data1);
%             filt2=filter(a,b,data2);
%             filt3=filter(a,b,data3);
%             filt4=filter(a,b,data4);
%             filt5=filter(a,b,data5);
%             filt6=filter(a,b,data6);
%             filt7=filter(a,b,data7);
%             filt8=filter(a,b,data8);
%             filt9=filter(a,b,data9);
%             
%             SV_d_max(1,i)=median(filt1);
%             SV_d_max(2,i)=median(filt2);
%             SV_d_max(3,i)=median(filt3);
%             SV_d_max(4,i)=median(filt4);
%             SV_d_max(5,i)=median(filt5);
%             SV_d_max(6,i)=median(filt6);
%             SV_d_max(7,i)=median(filt7);
%             SV_d_max(8,i)=median(filt8);
%             SV_d_max(9,i)=median(filt9);
%         
%             
%             Z1=(data1.^2-filt1.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z2=(data2.^2-filt2.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z3=(data3.^2-filt3.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z4=(data4.^2-filt4.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z5=(data5.^2-filt5.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z6=(data6.^2-filt6.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z7=(data7.^2-filt7.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z8=(data8.^2-filt8.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z9=(data9.^2-filt9.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%         
%             Z_max(1,i)=median(Z1);
%             Z_max(2,i)=median(Z2);
%             Z_max(3,i)=median(Z3);
%             Z_max(4,i)=median(Z4);
%             Z_max(5,i)=median(Z5);
%             Z_max(6,i)=median(Z6);
%             Z_max(7,i)=median(Z7);
%             Z_max(8,i)=median(Z8);
%             Z_max(9,i)=median(Z9);
                       
        end
            Trained_Lst{1,1}=[SV_tot_max(1,:);SV_tot_max(4,:);SV_tot_max(7,:)];
            Trained_Lst{2,1}=[SV_tot_max(2,:);SV_tot_max(5,:);SV_tot_max(8,:)];
            Trained_Lst{3,1}=[SV_tot_max(3,:);SV_tot_max(6,:);SV_tot_max(9,:)];
%             Trained_Lst{1,2}=[SV_d_max(1,:);SV_d_max(4,:);SV_d_max(7,:)];
%             Trained_Lst{2,2}=[SV_d_max(2,:);SV_d_max(5,:);SV_d_max(8,:)];
%             Trained_Lst{3,2}=[SV_d_max(3,:);SV_d_max(6,:);SV_d_max(9,:)];
%             Trained_Lst{1,3}=[Z_max(1,:);Z_max(4,:);Z_max(7,:)];
%             Trained_Lst{2,3}=[Z_max(2,:);Z_max(5,:);Z_max(8,:)];
%             Trained_Lst{3,3}=[Z_max(3,:);Z_max(6,:);Z_max(9,:)];
        
        for i=1:5
            directory1=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 1\\left swing\\euclidean',i);    
            directory2=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 1\\left swing\\euclidean',i);
            directory3=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 1\\left swing\\euclidean',i);    
            directory4=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 2\\left swing\\euclidean',i);    
            directory5=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 2\\left swing\\euclidean',i);
            directory6=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 2\\left swing\\euclidean',i);    
            directory7=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 3\\left swing\\euclidean',i);    
            directory8=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 3\\left swing\\euclidean',i);
            directory9=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 3\\left swing\\euclidean',i); 
            source_files1=dir(fullfile(directory1,'*hip*.xlsx'));
            source_files2=dir(fullfile(directory2,'*knee*.xlsx'));
            source_files3=dir(fullfile(directory3,'*ankle*.xlsx'));
            source_files4=dir(fullfile(directory4,'*hip*.xlsx'));
            source_files5=dir(fullfile(directory5,'*knee*.xlsx'));
            source_files6=dir(fullfile(directory6,'*ankle*.xlsx'));
            source_files7=dir(fullfile(directory7,'*hip*.xlsx'));
            source_files8=dir(fullfile(directory8,'*knee*.xlsx'));
            source_files9=dir(fullfile(directory9,'*ankle*.xlsx'));
            file1=horzcat(source_files1.folder,'\',source_files1.name);
            file2=horzcat(source_files2.folder,'\',source_files2.name);
            file3=horzcat(source_files3.folder,'\',source_files3.name);
            file4=horzcat(source_files4.folder,'\',source_files4.name);
            file5=horzcat(source_files5.folder,'\',source_files5.name);
            file6=horzcat(source_files6.folder,'\',source_files6.name);
            file7=horzcat(source_files7.folder,'\',source_files7.name);
            file8=horzcat(source_files8.folder,'\',source_files8.name);
            file9=horzcat(source_files9.folder,'\',source_files9.name);
            
            raw_data1=xlsread(file1);
            raw_data2=xlsread(file2);
            raw_data3=xlsread(file3);
            raw_data4=xlsread(file4);
            raw_data5=xlsread(file5);
            raw_data6=xlsread(file6);
            raw_data7=xlsread(file7);
            raw_data8=xlsread(file8);
            raw_data9=xlsread(file9);
            
            mindata1 = min(raw_data1);
            maxdata1 = max(raw_data1);
            mindata2 = min(raw_data2);
            maxdata2 = max(raw_data2);
            mindata3 = min(raw_data3);
            maxdata3 = max(raw_data3);
            mindata4 = min(raw_data4);
            maxdata4 = max(raw_data4);
            mindata5 = min(raw_data5);
            maxdata5 = max(raw_data5);
            mindata6 = min(raw_data6);
            maxdata6 = max(raw_data6);
            mindata7 = min(raw_data7);
            maxdata7 = max(raw_data7);
            mindata8 = min(raw_data8);
            maxdata8 = max(raw_data8);
            mindata9 = min(raw_data9);
            maxdata9 = max(raw_data9);
            
            data1 = (raw_data1-mindata1)/(maxdata1-mindata1);
            data2 = (raw_data2-mindata2)/(maxdata2-mindata2);
            data3 = (raw_data3-mindata3)/(maxdata3-mindata3);
            data4 = (raw_data4-mindata4)/(maxdata4-mindata4);
            data5 = (raw_data5-mindata5)/(maxdata5-mindata5);
            data6 = (raw_data6-mindata6)/(maxdata6-mindata6);
            data7 = (raw_data7-mindata7)/(maxdata7-mindata7);
            data8 = (raw_data8-mindata8)/(maxdata8-mindata8);
            data9 = (raw_data9-mindata9)/(maxdata9-mindata9);
        
            SV_tot_max(1,i)=median(data1);
            SV_tot_max(2,i)=median(data2);
            SV_tot_max(3,i)=median(data3);
            SV_tot_max(4,i)=median(data4);
            SV_tot_max(5,i)=median(data5);
            SV_tot_max(6,i)=median(data6);
            SV_tot_max(7,i)=median(data7);
            SV_tot_max(8,i)=median(data8);
            SV_tot_max(9,i)=median(data9);
            
%             filt1=filter(a,b,data1);
%             filt2=filter(a,b,data2);
%             filt3=filter(a,b,data3);
%             filt4=filter(a,b,data4);
%             filt5=filter(a,b,data5);
%             filt6=filter(a,b,data6);
%             filt7=filter(a,b,data7);
%             filt8=filter(a,b,data8);
%             filt9=filter(a,b,data9);
%         
%             SV_d_max(1,i)=median(filt1);
%             SV_d_max(2,i)=median(filt2);
%             SV_d_max(3,i)=median(filt3);
%             SV_d_max(4,i)=median(filt4);
%             SV_d_max(5,i)=median(filt5);
%             SV_d_max(6,i)=median(filt6);
%             SV_d_max(7,i)=median(filt7);
%             SV_d_max(8,i)=median(filt8);
%             SV_d_max(9,i)=median(filt9);
%         
%            
%             Z1=(data1.^2-filt1.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z2=(data2.^2-filt2.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z3=(data3.^2-filt3.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z4=(data4.^2-filt4.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z5=(data5.^2-filt5.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z6=(data6.^2-filt6.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z7=(data7.^2-filt7.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z8=(data8.^2-filt8.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z9=(data9.^2-filt9.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%         
%             Z_max(1,i)=median(Z1);
%             Z_max(2,i)=median(Z2);
%             Z_max(3,i)=median(Z3);
%             Z_max(4,i)=median(Z4);
%             Z_max(5,i)=median(Z5);
%             Z_max(6,i)=median(Z6);
%             Z_max(7,i)=median(Z7);
%             Z_max(8,i)=median(Z8);
%             Z_max(9,i)=median(Z9);
        
        end
            Trained_Lsw{1,1}=[SV_tot_max(1,:);SV_tot_max(4,:);SV_tot_max(7,:)];
            Trained_Lsw{2,1}=[SV_tot_max(2,:);SV_tot_max(5,:);SV_tot_max(8,:)];
            Trained_Lsw{3,1}=[SV_tot_max(3,:);SV_tot_max(6,:);SV_tot_max(9,:)];
%             Trained_Lsw{1,2}=[SV_d_max(1,:);SV_d_max(4,:);SV_d_max(7,:)];
%             Trained_Lsw{2,2}=[SV_d_max(2,:);SV_d_max(5,:);SV_d_max(8,:)];
%             Trained_Lsw{3,2}=[SV_d_max(3,:);SV_d_max(6,:);SV_d_max(9,:)];
%             Trained_Lsw{1,3}=[Z_max(1,:);Z_max(4,:);Z_max(7,:)];
%             Trained_Lsw{2,3}=[Z_max(2,:);Z_max(5,:);Z_max(8,:)];
%             Trained_Lsw{3,3}=[Z_max(3,:);Z_max(6,:);Z_max(9,:)];

        for i=1:5
            directory1=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 1\\right swing\\euclidean',i);    
            directory2=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 1\\right swing\\euclidean',i);
            directory3=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 1\\right swing\\euclidean',i);    
            directory4=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 2\\right swing\\euclidean',i);    
            directory5=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 2\\right swing\\euclidean',i);
            directory6=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 2\\right swing\\euclidean',i);    
            directory7=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 3\\right swing\\euclidean',i);    
            directory8=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 3\\right swing\\euclidean',i);
            directory9=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 3\\right swing\\euclidean',i); 
            source_files1=dir(fullfile(directory1,'*hip*.xlsx'));
            source_files2=dir(fullfile(directory2,'*knee*.xlsx'));
            source_files3=dir(fullfile(directory3,'*ankle*.xlsx'));
            source_files4=dir(fullfile(directory4,'*hip*.xlsx'));
            source_files5=dir(fullfile(directory5,'*knee*.xlsx'));
            source_files6=dir(fullfile(directory6,'*ankle*.xlsx'));
            source_files7=dir(fullfile(directory7,'*hip*.xlsx'));
            source_files8=dir(fullfile(directory8,'*knee*.xlsx'));
            source_files9=dir(fullfile(directory9,'*ankle*.xlsx'));
            file1=horzcat(source_files1.folder,'\',source_files1.name);
            file2=horzcat(source_files2.folder,'\',source_files2.name);
            file3=horzcat(source_files3.folder,'\',source_files3.name);
            file4=horzcat(source_files4.folder,'\',source_files4.name);
            file5=horzcat(source_files5.folder,'\',source_files5.name);
            file6=horzcat(source_files6.folder,'\',source_files6.name);
            file7=horzcat(source_files7.folder,'\',source_files7.name);
            file8=horzcat(source_files8.folder,'\',source_files8.name);
            file9=horzcat(source_files9.folder,'\',source_files9.name);
            
            raw_data1=xlsread(file1);
            raw_data2=xlsread(file2);
            raw_data3=xlsread(file3);
            raw_data4=xlsread(file4);
            raw_data5=xlsread(file5);
            raw_data6=xlsread(file6);
            raw_data7=xlsread(file7);
            raw_data8=xlsread(file8);
            raw_data9=xlsread(file9);
            
            mindata1 = min(raw_data1);
            maxdata1 = max(raw_data1);
            mindata2 = min(raw_data2);
            maxdata2 = max(raw_data2);
            mindata3 = min(raw_data3);
            maxdata3 = max(raw_data3);
            mindata4 = min(raw_data4);
            maxdata4 = max(raw_data4);
            mindata5 = min(raw_data5);
            maxdata5 = max(raw_data5);
            mindata6 = min(raw_data6);
            maxdata6 = max(raw_data6);
            mindata7 = min(raw_data7);
            maxdata7 = max(raw_data7);
            mindata8 = min(raw_data8);
            maxdata8 = max(raw_data8);
            mindata9 = min(raw_data9);
            maxdata9 = max(raw_data9);
            
            data1 = (raw_data1-mindata1)/(maxdata1-mindata1);
            data2 = (raw_data2-mindata2)/(maxdata2-mindata2);
            data3 = (raw_data3-mindata3)/(maxdata3-mindata3);
            data4 = (raw_data4-mindata4)/(maxdata4-mindata4);
            data5 = (raw_data5-mindata5)/(maxdata5-mindata5);
            data6 = (raw_data6-mindata6)/(maxdata6-mindata6);
            data7 = (raw_data7-mindata7)/(maxdata7-mindata7);
            data8 = (raw_data8-mindata8)/(maxdata8-mindata8);
            data9 = (raw_data9-mindata9)/(maxdata9-mindata9);
        
            SV_tot_max(1,i)=median(data1);
            SV_tot_max(2,i)=median(data2);
            SV_tot_max(3,i)=median(data3);
            SV_tot_max(4,i)=median(data4);
            SV_tot_max(5,i)=median(data5);
            SV_tot_max(6,i)=median(data6);
            SV_tot_max(7,i)=median(data7);
            SV_tot_max(8,i)=median(data8);
            SV_tot_max(9,i)=median(data9);
            
            
%             filt1=filter(a,b,data1);
%             filt2=filter(a,b,data2);
%             filt3=filter(a,b,data3);
%             filt4=filter(a,b,data4);
%             filt5=filter(a,b,data5);
%             filt6=filter(a,b,data6);
%             filt7=filter(a,b,data7);
%             filt8=filter(a,b,data8);
%             filt9=filter(a,b,data9);
%         
%             SV_d_max(1,i)=median(filt1);
%             SV_d_max(2,i)=median(filt2);
%             SV_d_max(3,i)=median(filt3);
%             SV_d_max(4,i)=median(filt4);
%             SV_d_max(5,i)=median(filt5);
%             SV_d_max(6,i)=median(filt6);
%             SV_d_max(7,i)=median(filt7);
%             SV_d_max(8,i)=median(filt8);
%             SV_d_max(9,i)=median(filt9);
%         
%            
%             Z1=(data1.^2-filt1.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z2=(data2.^2-filt2.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z3=(data3.^2-filt3.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z4=(data4.^2-filt4.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z5=(data5.^2-filt5.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z6=(data6.^2-filt6.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z7=(data7.^2-filt7.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z8=(data8.^2-filt8.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z9=(data9.^2-filt9.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%         
%             Z_max(1,i)=median(Z1);
%             Z_max(2,i)=median(Z2);
%             Z_max(3,i)=median(Z3);
%             Z_max(4,i)=median(Z4);
%             Z_max(5,i)=median(Z5);
%             Z_max(6,i)=median(Z6);
%             Z_max(7,i)=median(Z7);
%             Z_max(8,i)=median(Z8);
%             Z_max(9,i)=median(Z9);
            
        end
        
            Trained_Rsw{1,1}=[SV_tot_max(1,:);SV_tot_max(4,:);SV_tot_max(7,:)];
            Trained_Rsw{2,1}=[SV_tot_max(2,:);SV_tot_max(5,:);SV_tot_max(8,:)];
            Trained_Rsw{3,1}=[SV_tot_max(3,:);SV_tot_max(6,:);SV_tot_max(9,:)];
%             Trained_Rsw{1,2}=[SV_d_max(1,:);SV_d_max(4,:);SV_d_max(7,:)];
%             Trained_Rsw{2,2}=[SV_d_max(2,:);SV_d_max(5,:);SV_d_max(8,:)];
%             Trained_Rsw{3,2}=[SV_d_max(3,:);SV_d_max(6,:);SV_d_max(9,:)];
%             Trained_Rsw{1,3}=[Z_max(1,:);Z_max(4,:);Z_max(7,:)];
%             Trained_Rsw{2,3}=[Z_max(2,:);Z_max(5,:);Z_max(8,:)];
%             Trained_Rsw{3,3}=[Z_max(3,:);Z_max(6,:);Z_max(9,:)];
            
        for i=1:5
            directory1=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 1\\right stance\\euclidean',i);    
            directory2=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 1\\right stance\\euclidean',i);
            directory3=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 1\\right stance\\euclidean',i);    
            directory4=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 2\\right stance\\euclidean',i);    
            directory5=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 2\\right stance\\euclidean',i);
            directory6=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 2\\right stance\\euclidean',i);    
            directory7=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 3\\right stance\\euclidean',i);    
            directory8=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 3\\right stance\\euclidean',i);
            directory9=sprintf('C:\\Users\\SAGAR\\Desktop\\EUCLIDEAN\\subject %d\\trial 1\\CYCLE 3\\right stance\\euclidean',i); 
            source_files1=dir(fullfile(directory1,'*hip*.xlsx'));
            source_files2=dir(fullfile(directory2,'*knee*.xlsx'));
            source_files3=dir(fullfile(directory3,'*ankle*.xlsx'));
            source_files4=dir(fullfile(directory4,'*hip*.xlsx'));
            source_files5=dir(fullfile(directory5,'*knee*.xlsx'));
            source_files6=dir(fullfile(directory6,'*ankle*.xlsx'));
            source_files7=dir(fullfile(directory7,'*hip*.xlsx'));
            source_files8=dir(fullfile(directory8,'*knee*.xlsx'));
            source_files9=dir(fullfile(directory9,'*ankle*.xlsx'));
            file1=horzcat(source_files1.folder,'\',source_files1.name);
            file2=horzcat(source_files2.folder,'\',source_files2.name);
            file3=horzcat(source_files3.folder,'\',source_files3.name);
            file4=horzcat(source_files4.folder,'\',source_files4.name);
            file5=horzcat(source_files5.folder,'\',source_files5.name);
            file6=horzcat(source_files6.folder,'\',source_files6.name);
            file7=horzcat(source_files7.folder,'\',source_files7.name);
            file8=horzcat(source_files8.folder,'\',source_files8.name);
            file9=horzcat(source_files9.folder,'\',source_files9.name);
            
            raw_data1=xlsread(file1);
            raw_data2=xlsread(file2);
            raw_data3=xlsread(file3);
            raw_data4=xlsread(file4);
            raw_data5=xlsread(file5);
            raw_data6=xlsread(file6);
            raw_data7=xlsread(file7);
            raw_data8=xlsread(file8);
            raw_data9=xlsread(file9);
            
            mindata1 = min(raw_data1);
            maxdata1 = max(raw_data1);
            mindata2 = min(raw_data2);
            maxdata2 = max(raw_data2);
            mindata3 = min(raw_data3);
            maxdata3 = max(raw_data3);
            mindata4 = min(raw_data4);
            maxdata4 = max(raw_data4);
            mindata5 = min(raw_data5);
            maxdata5 = max(raw_data5);
            mindata6 = min(raw_data6);
            maxdata6 = max(raw_data6);
            mindata7 = min(raw_data7);
            maxdata7 = max(raw_data7);
            mindata8 = min(raw_data8);
            maxdata8 = max(raw_data8);
            mindata9 = min(raw_data9);
            maxdata9 = max(raw_data9);
            
            data1 = (raw_data1-mindata1)/(maxdata1-mindata1);
            data2 = (raw_data2-mindata2)/(maxdata2-mindata2);
            data3 = (raw_data3-mindata3)/(maxdata3-mindata3);
            data4 = (raw_data4-mindata4)/(maxdata4-mindata4);
            data5 = (raw_data5-mindata5)/(maxdata5-mindata5);
            data6 = (raw_data6-mindata6)/(maxdata6-mindata6);
            data7 = (raw_data7-mindata7)/(maxdata7-mindata7);
            data8 = (raw_data8-mindata8)/(maxdata8-mindata8);
            data9 = (raw_data9-mindata9)/(maxdata9-mindata9);
        
            SV_tot_max(1,i)=median(data1);
            SV_tot_max(2,i)=median(data2);
            SV_tot_max(3,i)=median(data3);
            SV_tot_max(4,i)=median(data4);
            SV_tot_max(5,i)=median(data5);
            SV_tot_max(6,i)=median(data6);
            SV_tot_max(7,i)=median(data7);
            SV_tot_max(8,i)=median(data8);
            SV_tot_max(9,i)=median(data9);
            
            
%             filt1=filter(a,b,data1);
%             filt2=filter(a,b,data2);
%             filt3=filter(a,b,data3);
%             filt4=filter(a,b,data4);
%             filt5=filter(a,b,data5);
%             filt6=filter(a,b,data6);
%             filt7=filter(a,b,data7);
%             filt8=filter(a,b,data8);
%             filt9=filter(a,b,data9);
%         
%             SV_d_max(1,i)=median(filt1);
%             SV_d_max(2,i)=median(filt2);
%             SV_d_max(3,i)=median(filt3);
%             SV_d_max(4,i)=median(filt4);
%             SV_d_max(5,i)=median(filt5);
%             SV_d_max(6,i)=median(filt6);
%             SV_d_max(7,i)=median(filt7);
%             SV_d_max(8,i)=median(filt8);
%             SV_d_max(9,i)=median(filt9);
%         
%            
%             Z1=(data1.^2-filt1.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z2=(data2.^2-filt2.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z3=(data3.^2-filt3.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z4=(data4.^2-filt4.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z5=(data5.^2-filt5.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z6=(data6.^2-filt6.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z7=(data7.^2-filt7.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z8=(data8.^2-filt8.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%             Z9=(data9.^2-filt9.^2-(6.67259*10^-11))/2*(6.67259*10^-11);
%         
%             Z_max(1,i)=median(Z1);
%             Z_max(2,i)=median(Z2);
%             Z_max(3,i)=median(Z3);
%             Z_max(4,i)=median(Z4);
%             Z_max(5,i)=median(Z5);
%             Z_max(6,i)=median(Z6);
%             Z_max(7,i)=median(Z7);
%             Z_max(8,i)=median(Z8);
%             Z_max(9,i)=median(Z9);
  
            
        end
            Trained_Rst{1,1}=[SV_tot_max(1,:);SV_tot_max(4,:);SV_tot_max(7,:)];
            Trained_Rst{2,1}=[SV_tot_max(2,:);SV_tot_max(5,:);SV_tot_max(8,:)];
            Trained_Rst{3,1}=[SV_tot_max(3,:);SV_tot_max(6,:);SV_tot_max(9,:)];
%             Trained_Rst{1,2}=[SV_d_max(1,:);SV_d_max(4,:);SV_d_max(7,:)];
%             Trained_Rst{2,2}=[SV_d_max(2,:);SV_d_max(5,:);SV_d_max(8,:)];
%             Trained_Rst{3,2}=[SV_d_max(3,:);SV_d_max(6,:);SV_d_max(9,:)];
%             Trained_Rst{1,3}=[Z_max(1,:);Z_max(4,:);Z_max(7,:)];
%             Trained_Rst{2,3}=[Z_max(2,:);Z_max(5,:);Z_max(8,:)];
%             Trained_Rst{3,3}=[Z_max(3,:);Z_max(6,:);Z_max(9,:)];
% end
           

