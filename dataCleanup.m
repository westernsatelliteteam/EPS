%%HOW TO USE THIS SCRIPT

%1. OPEN STK DATA IN EXCEL/SHEETS AND DELETE ALL COLUMNS EXCEPT THE POWER
%COLUMN

%2. Import STK Power data as a single column of numeric data, by default it
%will import the table, set this to numeric matrix.

%3. Rename this numeric matrix is called "solarTable"

%4. Run this app (dataCleanup.m)

%5. Then input this command "csvwrite('FileName.csv', data)"

%6. If you wish you can change Filename to anything you'd like or rename it
%afterwards

%7. You can now find the output data in the matlab directory

%The data is output as follows
%Eclipse Time (hrs), Daylight Time (hrs), Power in the given orbit
%(W), Energy of given orbit (Wh), and Energy/Orbit Period an adjusted
%Wh/time which is useful to find the worst case orbital scenario.




%Solar Table
timeStep=10; %Minutes
columnNum=1; %Which column is used

length=length(solarTable);
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

