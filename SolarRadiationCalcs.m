%For one day (~15 orbits)
FOS = 1.3;

avgPower = mean(DailyData.Power);
maxPower = max(DailyData.Power);
minPower = min(DailyData.Power);

avgTime = mean(DailyData.Time);
maxTime = max(DailyData.Time);
minTime = min(DailyData.Time);

avgEnergy = avgPower * avgTime *FOS;
maxEnergy = maxPower * maxTime * FOS;
minEnergy = minPower * minTime *FOS;


