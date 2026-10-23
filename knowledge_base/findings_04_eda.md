## 7 · Findings

**1. Winter trips use about 43 % more energy per km.** Median consumption is 19.1 kWh/100 km in winter against
13.3 in summer (p < 0.001). Distance, acceleration and elevation range were similar, and speed was only slightly
higher in winter (p = 0.06). One difference does exist: winter trips spent more time stopped (12 % vs 9 %, p = 0.03).
While stopped the heater keeps running and no distance is gained, which adds to heating per km.

**2. Cabin heating is the largest single cause, and it is front-loaded.**
- Heating takes a median 18 % of winter battery energy (3.8 kWh/100 km), and up to 30 % in TripB02.
- Colder trips draw more heating power (rho = −0.39 within winter trips), and heating's share of battery energy falls as it gets warmer (rho = −0.77 over all trips). Summer trips use almost no heating once stale readings are removed (notebook 02, 3.5).
- Mean heating power is about 3.6 kW in the first 5 minutes and drops to about 1.2 kW after 15 minutes, once the cabin has warmed up.
- Short winter trips are therefore the least efficient.

**3. Without heating and A/C, winter is still about 3.1 kWh/100 km worse, and speed explains only a small part of it.**
After controlling for speed, the winter effect is still about +2.4 kWh/100 km. Speed-matched trips (45–65 km/h)
show 12.0 against 15.1 kWh/100 km. Part of it is
**regeneration limited by a cold battery**:
- The 99th-percentile regeneration current is about 22 A with the battery below 0 °C and about 60 A at 0–5 °C, against more than 120 A above 10 °C.
- Recovered energy halves in winter (12 % vs 23 % of energy drawn) and rises with battery temperature (rho = 0.64).
- The remaining gap (cold tyres, denser air, higher resistive losses) cannot be separated with this data. It is a hypothesis, not a finding.

**4. Pack resistance depends strongly on temperature.**
- Apparent resistance falls from about 197 mΩ below 5 °C to about 73 mΩ above 25 °C (rho = −0.91 over 556 events).
- SoC has almost no effect (rho = −0.09).
- At the same current, a cold pack sags much deeper, which is why winter trips show about 6× more sag events per 10 km.
- Across trips, battery temperature at the start ranks trips by median resistance almost perfectly (rho = −0.97).

**5. Correlations.**
- While driving, battery power follows motor torque, throttle and acceleration (rho 0.82–0.91), and speed only weakly (0.38).
- At trip level, temperature (ambient and battery) is the hub. It links consumption, heating, regeneration, resistance and battery warm-up.

**Caveats**
- There are only 70 trips, from one car and one driver group around Munich. The seasons also differ in route, so season effects are associations, not controlled experiments.
- Battery temperature is logged in whole degrees.
- Resistance is an *apparent* value (sag ÷ current), not a lab measurement.

**What this means for the next steps**
- Temperature (battery and ambient), heating power, speed and torque are the key inputs for the models (step 6).
- Cold-weather sag and the B02 heating event are natural anomaly candidates (step 7).