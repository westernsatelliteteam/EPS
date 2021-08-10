

%csvwrite('FileName.csv', data)



%Solar Table
timeStep=10; %Minutes
columnNum=1; %Which column is used

length=height(solarTable);
c=2;
q=1;
data=zeros(1,5);
while(c<length)
   eclipseTime=0;
   sunlightTime=0;
   pTotal=0;
   eTotal=0;
   while(solarTable(c,columnNum) ==0 && c<length)       %%while the power value is more than 0
   eclipseTime=eclipseTime+timeStep;        %%add to the eclipse time
   c=c+1;
   end
   
   while(solarTable(c,columnNum)~=0 && c<length)        %%while the power value is more than zero
   sunlightTime=sunlightTime+timeStep;      %%adding up time in the sunlight (10 1 minute time steps in a row
   pTotal=pTotal+solarTable(c,columnNum);       %%adding up avg power per orbit
   eTotal=eTotal+(timeStep/60*solarTable(c,columnNum)); %%Adding up energy per orbit
   c=c+1;
   end
   pAvg=pTotal/(sunlightTime/timeStep);
   
   data(q,1)=eclipseTime/60;
   data(q,2)=sunlightTime/60;
   data(q,3)=pAvg;
   data(q,4)=eTotal;
   data(q,5)=(eTotal/((eclipseTime/60)+(sunlightTime/60)));
   q=q+1;
 % disp(eclipseTime);
%  disp(sunlightTime);
%  disp(pAvg);
%  disp(eTotal);
 % disp("Break");
end

