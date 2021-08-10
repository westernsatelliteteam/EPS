%%%%%%%%%%%%%EditableVariables%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

increment=0.01;     %%increment that will be added each cycle
NominalPower=3.964116;       %%nominal power usage during daylight
EclipsePower=1.724736;       %%
BatteryCapacity=10;
batEfficency=1;
EPSefficiency=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x=1;
modifier=1;
output=zeros(2,2);      %%setting up output array
q=batCalcFunction(data,BatteryCapacity,batEfficency,EclipsePower,NominalPower,EPSefficiency,modifier);        %%initial q value
while q>1
    modifier=modifier+increment;
    HighQ=batCalcFunction(data,BatteryCapacity,batEfficency,EclipsePower,NominalPower,EPSefficiency,modifier);        %%Checking High mod
    q=HighQ;        %%let while loop know what the new q value is
    disp("SolarPanelModifier: "+modifier);
    output(x,1)=q;      %%adding new values
    output(x,2)=modifier;   %%and new modifiers to an output table
    x=x+1;      %%setting the next output table cells
end
plot(output(1:end,2),output(1:end,1));      %%plotting output