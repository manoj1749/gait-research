
clear
clc
pkg load io 

original_file='4_ S5_L hip_T1.xlsx';
iterate1='4_ S5_L hip_T1_st1.xlsx';
iterate2='4_ S5_L hip_T1_st2.xlsx';
iterate3='4_ S5_L hip_T1_st3.xlsx';

[num,txt,raw]=xlsread(original_file);%raw data converted into excel sheets
data1=num;

##time=data1(1:end,1);
##x=data1(1:end,2);
##y=data1(1:end,3);
##z=data1(1:end,4);
##%Ploting the the X Y Z raw data for checking the cycles position.
##figure(1)
##plot(time,x,'b')
##figure(2)
##plot(time,y,'g')
##figure(3)
##plot(time,z,'r')

tor1=input('Input sensor starting time: ');
tor2=27; #cycle1
tor3=28; 
tor4=31; #cycle2
tor5=32;
tor6=36; #cycle3
tor7=37;

inicut1= tor2 - tor1;#calculation
endcut1= tor3 - tor1;#calculation
inicut2= tor4 - tor1;#calculation
endcut2= tor5 - tor1;#calculation
inicut3= tor6 - tor1;#calculation
endcut3= tor7 - tor1;#calculation

for i=1:length(data1)
    ini=round(data1(i,1));
    endi=round(data1(i,1));
    if(ini==inicut1)
        inipos1=i;
    end
    if(endi==endcut1)
        endpos1=i;
    end
end

data3=[];
for c=1:4
    data2=data1(inipos1:endpos1,c);
    data3=horzcat(data3,data2);
end

for i=1:length(data1)
    ini=round(data1(i,1));
    endi=round(data1(i,1));
    if(ini==inicut2)
        inipos2=i;
    end
    if(endi==endcut2)
        endpos2=i;
    end
end

data4=[];
for c=1:4
    data2d=data1(inipos2:endpos2,c);
    data4=horzcat(data4,data2d);
end



for i=1:length(data1)
    ini=round(data1(i,1));
    endi=round(data1(i,1));
    if(ini==inicut3)
        inipos3=i;
    end
    if(endi==endcut3)
        endpos3=i;
    end
end

data5=[];
for c=1:4
    data2e=data1(inipos3:endpos3,c);
    data5=horzcat(data5,data2e);
end


data2a=data1(inipos1:endpos1,6);
data3=horzcat(data3,data2a);
data2a=data1(inipos1:endpos1,7);
data3=horzcat(data3,data2a);
data2b=data1(inipos2:endpos2,6);
data4=horzcat(data4,data2b);
data2b=data1(inipos2:endpos2,7);
data4=horzcat(data4,data2b);
data2c=data1(inipos3:endpos3,6);
data5=horzcat(data5,data2c);
data2c=data1(inipos3:endpos3,7);
data5=horzcat(data5,data2c);

xlswrite(iterate1,data3);
xlswrite(iterate2,data4);
xlswrite(iterate3,data5);
%output file
%trimed data