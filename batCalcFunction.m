function [optimizer] = batCalcFunction(data,batEngMax,batEfficiency,EclipsePower,NominalPower,EPSefficiency,solarModifier)

%%%%%%Editable Variables%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%batEngMax=30; %%Watt Hours
%%batEfficiency=1;

%EclipsePower=5.5;   %%WATTS
%NominalPower=7.6;   %%WATTS
%EPSefficiency=0.95;

%SolarModifier=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
optimizer=0;

batEng=0;
output=zeros((length(data)),1);  %%Blank Output array
minTimes=zeros(10,3);   %%Listing energy states where we reached zero
x=1;
for q=1:length(data)
    nomUsage=EPSefficiency*((NominalPower*data(q,2))+(EclipsePower*data(q,1)));
    
    
    energy=solarModifier*data(q,4);          %%find current orbits energy in
    batEng=batEng*batEfficiency;    %%Adjust Battery storage based on efficency
    if((energy-nomUsage)>=0)        %%if there is enough solar energy for nominal
       
       if(batEng~=batEngMax)        %%If there is energy left over add it to the batteries
       batEng=batEng+(energy-nomUsage);
       end
       output(q)=2;
       
    elseif(energy-nomUsage+batEng>=0)     %%if solar energy + some bat can keep nominal on and if we prefer it
        batEng=batEng-nomUsage+energy;          %power the sat and subtract energy from battery
        output(q)=1;
           
    else                                  %%If battery and solar cannot keep sat on
        if(batEng~=batEngMax)
        batEng=batEng+energy;           %%add energy to the battery
        end
        output(q)=0;            %%satellite goes dark
    end
      if(batEng>batEngMax)
      batEng=batEngMax;
      end
    
   if(output(q)==0)
       minTimes(x,1)=energy;
       x=x+1;
       %disp("Attempt Failed");
       optimizer=optimizer+1;
   end
      
    
end
%plot(output);

end

